o.bind("SUPER + B", "Browser", "omarchy-launch-browser")

-- Toggle Ghostty transparency instead of the default float/tile toggle.
-- Note: SUPER+T was previously bound to "Toggle window floating/tiling".
hl.unbind("SUPER + T")
o.bind("SUPER + T", "Toggle terminal transparency", "~/.config/script/ghostty-toggle-opacity")

-- Free up W / S / ALT+S (close window, scratchpad toggle, move to scratchpad)
-- for hyprsplit's per-monitor workspace bindings below.
-- Note: SUPER+W was "Close window", SUPER+S was "Toggle scratchpad", and
-- SUPER+ALT+S was "Move window to scratchpad".
hl.unbind("SUPER + W")
hl.unbind("SUPER + S")
hl.unbind("SUPER + ALT + S")

o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

-- Use a custom lid-switch script instead of Omarchy's default lid handling.
-- Note: switch:on/off:Lid Switch previously ran omarchy-system-lid-close /
-- omarchy-hyprland-monitor-clamshell.
hl.unbind("switch:on:Lid Switch")
hl.unbind("switch:off:Lid Switch")
o.bind("switch:on:Lid Switch", nil, "~/.config/hypr/scripts/laptop-display.sh off", { locked = true })
o.bind("switch:off:Lid Switch", nil, "~/.config/hypr/scripts/laptop-display.sh on", { locked = true })
-- Per-monitor workspaces (hyprsplit-style), implemented natively instead of via
-- the hyprsplit plugin: that plugin refuses to load under this Hyprland's Lua
-- config ("[hyprsplit] Only legacy config supported" - confirmed via
-- `hyprctl plugin load`), so the `plugin { hyprsplit { ... } }` block and the
-- `split:workspace` binds in bindings.conf are dead; bindings.conf itself isn't
-- even sourced by hyprland.lua. This replicates hyprsplit's core behavior -
-- SUPER+1..5 switches workspace 1..5 on whichever monitor is currently
-- focused, independently per monitor - using per-monitor named workspaces
-- ("hyprsplit-<monitor name>-<slot>") instead of a real plugin.
local hyprsplitWorkspaceCount = 5

local function hyprsplitWorkspaceTarget(slot)
	local monitor = hl.get_active_monitor()
	return "name:hyprsplit-" .. monitor.name .. "-" .. tostring(slot)
end

for slot = 1, hyprsplitWorkspaceCount do
	local key = "code:" .. tostring(slot + 9)

	-- Replace the global (cross-monitor) workspace switch from tiling.lua's
	-- default SUPER+1..0 loop for this key.
	hl.unbind("SUPER + " .. key)
	hl.unbind("SUPER + SHIFT + " .. key)
	hl.unbind("SUPER + SHIFT + ALT + " .. key)

	o.bind("SUPER + " .. key, "Switch to workspace " .. slot .. " (this monitor)", function()
		hl.dispatch(hl.dsp.focus({ workspace = hyprsplitWorkspaceTarget(slot) }))
	end)

	o.bind("SUPER + SHIFT + " .. key, "Move window to workspace " .. slot .. " (this monitor)", function()
		hl.dispatch(hl.dsp.window.move({ workspace = hyprsplitWorkspaceTarget(slot) }))
	end)

	o.bind(
		"SUPER + SHIFT + ALT + " .. key,
		"Move window silently to workspace " .. slot .. " (this monitor)",
		function()
			hl.dispatch(hl.dsp.window.move({ workspace = hyprsplitWorkspaceTarget(slot), follow = false }))
		end
	)
end

-- 3-finger touchpad swipe pages through the current monitor's hyprsplit
-- slots (1..5) instead of Hyprland's global workspace list, matching what
-- SUPER+1..5 already does. Swipe left = next slot, right = previous slot.
--
-- The current slot per monitor is tracked here via the "workspace.active"
-- event instead of being read from hl.get_active_monitor() at swipe time:
-- querying the monitor's activeWorkspace field on demand kept returning the
-- slot from *before* the previous swipe (e.g. still "1" right after
-- switching to "2"), so a swipe back computed from the wrong starting slot
-- and wrapped past 1 to 5. Updating a local table on every workspace
-- activation avoids depending on that field being current.
local hyprsplitCurrentSlotByMonitor = {}

-- Seed from whatever's active right now, so the very first swipe after a
-- config reload (before any other switch fires the event below) still
-- starts from the real slot instead of guessing 1.
for _, monitor in ipairs(hl.get_monitors()) do
	local name = monitor.activeWorkspace and monitor.activeWorkspace.name
	local slot = name and tonumber(name:match("^hyprsplit%-.+%-(%d+)$"))
	if slot then
		hyprsplitCurrentSlotByMonitor[monitor.name] = slot
	end
end

hl.on("workspace.active", function(workspace)
	local monitorName = workspace.monitor and workspace.monitor.name
	local slot = tonumber(workspace.name:match("^hyprsplit%-.+%-(%d+)$"))
	if monitorName and slot then
		hyprsplitCurrentSlotByMonitor[monitorName] = slot
	end
end)

-- Unlike the built-in "workspace" gesture action (which steps exactly once
-- per swipe), a custom Lua action gets invoked directly by the gesture
-- engine and can fire more than once for a single physical swipe. Without
-- a cooldown, that could still stack extra steps onto one swipe. Ignore
-- repeat firings per monitor briefly.
local hyprsplitSwipeCooldown = {}

local function hyprsplitSwipe(delta)
	local monitor = hl.get_active_monitor()
	if hyprsplitSwipeCooldown[monitor.name] then
		return
	end
	hyprsplitSwipeCooldown[monitor.name] = true
	hl.timer(function()
		hyprsplitSwipeCooldown[monitor.name] = nil
	end, { timeout = 250, type = "oneshot" })

	local slot = hyprsplitCurrentSlotByMonitor[monitor.name] or 1
	local nextSlot = ((slot - 1 + delta) % hyprsplitWorkspaceCount) + 1
	hl.dispatch(hl.dsp.focus({ workspace = hyprsplitWorkspaceTarget(nextSlot) }))
end

hl.gesture({
	fingers = 3,
	direction = "left",
	action = function()
		hyprsplitSwipe(1)
	end,
})
hl.gesture({
	fingers = 3,
	direction = "right",
	action = function()
		hyprsplitSwipe(-1)
	end,
})

o.bind(
	"SUPER + S",
	"Swap workspace with next monitor",
	hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1" })
)

-- Named hyprsplit-<monitor>-<slot> workspaces above are only ever created
-- lazily, the first time SUPER+1..5 is pressed on a given monitor. Without
-- this, a monitor boots (or appears via hotplug) sitting on whichever plain
-- numeric workspace Hyprland auto-assigns it, which the hyprsplit-workspaces
-- Quickshell widget doesn't recognize, so nothing shows as active until the
-- user manually presses a workspace key. Force every monitor onto its own
-- "-1" slot immediately instead.
local function hyprsplitInitMonitor(monitor)
	hl.dispatch(hl.dsp.focus({ monitor = monitor.name }))
	hl.dispatch(hl.dsp.focus({ workspace = "name:hyprsplit-" .. monitor.name .. "-1" }))
end

local function hyprsplitInitAllMonitors()
	local monitors = hl.get_monitors()
	local originalActive = hl.get_active_monitor()

	for _, monitor in ipairs(monitors) do
		hyprsplitInitMonitor(monitor)
	end

	if originalActive then
		hl.dispatch(hl.dsp.focus({ monitor = originalActive.name }))
	end
end

hl.on("hyprland.start", hyprsplitInitAllMonitors)
hl.on("monitor.added", function(monitor)
	hyprsplitInitMonitor(monitor)
end)
