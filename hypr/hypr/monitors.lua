-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

-- Toolkit-specific scale (matches the 2x XWayland/monitor scale below).
hl.env("GDK_SCALE", "2")
hl.env("XCURSOR_SIZE", "32")
hl.env("STEAM_FORCE_DESKTOPUI_SCALING", "1")

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

hl.monitor({ output = "eDP-1", mode = "2944x1840@90.00Hz", position = "0x0", scale = 2 })

hl.monitor({ output = "DP-8", mode = "1920x1080", position = "1920x0", scale = 1 })
hl.monitor({ output = "DP-9", mode = "1920x1080", position = "0x0", scale = 1 })
