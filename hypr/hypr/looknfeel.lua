-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
	general = {
		border_size = 3,
	},

	decoration = {
		-- Use round window corners.
		rounding = 8,
	},
})

-- Fully opaque windows (overrides Omarchy's default slight transparency).
o.window({ tag = "default-opacity" }, { opacity = "1 1" })
--
-- -- Cursor IDE: active/inactive opacity 0.9
-- o.window("^cursor$", { tag = "-default-opacity", opacity = "0.9 0.9" })
