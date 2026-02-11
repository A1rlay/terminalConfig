local wezterm = require("wezterm")
local config = wezterm.config_builder()
local utf8 = require("utf8")

local function mono()
	local schemes = wezterm.get_builtin_color_schemes()
	local s = schemes["Monokai Remastered"]

	return {
		bg = s.background or "#272822",
		fg = s.foreground or "#F8F8F2",
		tab_bg = "#272822",
		tab_act = "#3E3D32",
		tab_dim = "#1F1F1F",
		dim_fg = "#75715E",
		green = "#A6E22E",
		red = "#F92672",
		cyan = "#66D9EF",
		yellow = "#E6DB74",
		purple = "#AE81FF",
	}
end

local c = mono()

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- Tab
wezterm.on("format-tab-title", function(tab)
	local ACTIVE_BG = c.tab_act
	local ACTIVE_FG = c.fg
	local INACTIVE_BG = c.tab_bg
	local INACTIVE_FG = c.dim_fg

	local title = "  🦐's Shell  "

	local bg = tab.is_active and ACTIVE_BG or INACTIVE_BG
	local fg = tab.is_active and ACTIVE_FG or INACTIVE_FG

	return {
		{ Background = { Color = c.tab_dim } },
		{ Foreground = { Color = bg } },
		{ Text = SOLID_LEFT_ARROW },

		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = title },

		{ Background = { Color = c.tab_dim } },
		{ Foreground = { Color = bg } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

-- tmux status
wezterm.on("update-right-status", function(window, _)
	local SOLID_LEFT_ARROW = ""
	local ARROW_FOREGROUND = { Foreground = { Color = c.green } }
	local prefix = ""
	local shrimp_fg = c.green

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1F990) -- Shrimp
		shrimp_fg = c.red
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end

	if window:active_tab():tab_id() ~= 0 then
		ARROW_FOREGROUND = { Foreground = { Color = shrimp_fg } }
	end

	window:set_left_status(wezterm.format({
		{ Background = { Color = c.bg } },
		{ Foreground = { Color = shrimp_fg } },
		{ Text = prefix },
		ARROW_FOREGROUND,
		{ Text = SOLID_LEFT_ARROW },
	}))
end)

config = {
	automatically_reload_config = true,
	-- Color Scheme
	color_scheme = "Monokai Remastered",
	-- Font
	font = wezterm.font_with_fallback({
		{ family = "Iosevka Nerd Font" },
		{ family = "Symbols Nerd Font Mono" },
		{ family = "Segoe UI Emoji" },
	}),
	font_rules = {
		{
			italic = true,
			font = wezterm.font_with_fallback({
				{ family = "Iosevka Nerd Font", italic = true },
				{ family = "Symbols Nerd Font Mono" },
				{ family = "Segoe UI Emoji" },
			}),
		},

		{
			intensity = "Bold",
			font = wezterm.font_with_fallback({
				{ family = "Iosevka Nerd Font", weight = "Bold" },
				{ family = "Symbols Nerd Font Mono" },
				{ family = "Segoe UI Emoji" },
			}),
		},

		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font_with_fallback({
				{ family = "Iosevka Nerd Font", weight = "Bold", italic = true },
				{ family = "Symbols Nerd Font Mono" },
				{ family = "Segoe UI Emoji" },
			}),
		},
	},
	font_size = 14,
	line_height = 1.1,
	cell_width = 1,
	-- Render
	front_end = "OpenGL",
	webgpu_power_preference = "HighPerformance",
	max_fps = 90,
	animation_fps = 30,
	prefer_egl = false,
	-- Window Look & Feel
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	use_fancy_tab_bar = true,
	window_decorations = "RESIZE",
	-- Transparency
	window_background_opacity = 0,
	text_background_opacity = 0.75,
	win32_system_backdrop = "Tabbed",
	-- Never Prompt
	window_close_confirmation = "NeverPrompt",
	-- Frame
	window_frame = {
		active_titlebar_bg = c.bg,
		active_titlebar_fg = c.fg,
		inactive_titlebar_bg = c.bg,
		inactive_titlebar_fg = c.fg,
		font = wezterm.font("Iosevka Nerd Font"),
		font_size = 10,
	},
	-- Default Domain
	default_domain = "WSL:Ubuntu-24.04",
	-- Quality of Life
	cursor_blink_rate = 0,
	scrollback_lines = 5000,
	audible_bell = "Disabled",
	-- Background Image
	background = {
		{
			source = {
				-- File = [[C:\Users\A1rla\OneDrive\Desktop\Folder Things\images\haruhi.jpg]],
				File = [[C:\Users\A1rla\OneDrive\Desktop\Folder Things\images\Fumiel.jpg]],
			},
			hsb = {
				hue = 1,
				saturation = 1,
				brightness = 0.03,
			},
			opacity = 0.5,
			width = "100%",
			height = "100%",
		},
		{
			-- source = { Color = "#111825" },
			-- source = { Color = "#070e15" },
			source = { Color = "#0f0f0f" },
			width = "100%",
			height = "100%",
			opacity = 0.25,
		},
	},
	-- Padding
	window_padding = {
		left = 15,
		right = 5,
		top = 5,
		bottom = 0,
	},
	-- tmux
	leader = { key = "q", mods = "ALT", timeout_milliseconds = 2000 },
	keys = {
		{
			mods = "LEADER",
			key = "c",
			-- action = wezterm.action.SpawnTab("CurrentPaneDomain"),
			action = wezterm.action.SpawnTab({ DomainName = "WSL:Ubuntu-24.04" }),
		},
		{
			mods = "LEADER",
			key = "x",
			action = wezterm.action.CloseCurrentPane({ confirm = false }),
		},
		{
			mods = "LEADER",
			key = "v",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			mods = "LEADER",
			key = "s",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			mods = "LEADER",
			key = "h",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			mods = "LEADER",
			key = "j",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		{
			mods = "LEADER",
			key = "k",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			mods = "LEADER",
			key = "l",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
	},
}

return config
