-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
	input = {
		-- Use multiple keyboard layouts and switch between them with Left Alt + Right Alt.
		kb_layout = "de,us",
		kb_options = "grp:alt_shift_toggle",

		-- Change speed of keyboard repeat.
		repeat_rate = 40,
		repeat_delay = 600,

		-- Start with numlock on by default.
		numlock_by_default = true,

		touchpad = {
			-- Use natural (inverse) scrolling.
			natural_scroll = true,

			-- Use two-finger clicks for right-click instead of lower-right corner.
			clickfinger_behavior = true,

			-- Control the speed of your scrolling.
			scroll_factor = 0.2,
		},
	},
})

-- Scroll nicely in the terminal.
o.window("(Alacritty|kitty)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Touchpad gesture for changing workspaces is bound in bindings.lua instead
-- of here: the built-in action = "workspace" gesture only cycles Hyprland's
-- global workspace list, ignoring the per-monitor "hyprsplit-<monitor>-<slot>"
-- workspaces set up there, so it needs the same slot-naming helpers.
-- See https://wiki.hypr.land/Configuring/Gestures/
