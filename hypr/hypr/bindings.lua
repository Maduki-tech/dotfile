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

-- Swap the active monitor's workspace with the next monitor's. This is a
-- built-in Hyprland dispatcher (not a hyprsplit one), so it works fine even
-- though the hyprsplit plugin itself doesn't load.
o.bind("SUPER + S", "Swap workspace with next monitor", hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1" }))
