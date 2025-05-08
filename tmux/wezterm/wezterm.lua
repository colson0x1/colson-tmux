--[[
WezTerm Configuration - Enterprise Edition
Optimized for Senior Engineers 
Author: Colson (@colson0x1)
--]]

local wezterm = require("wezterm")
local config = {}

-- Configuration constants
local DEFAULT_FONT_SIZE = 12.5
local APP_MODIFIER = "ALT"
local URL_MODIFIER = "ALT"

-- Set to true only when debugging configuration issues
local DEBUG_MODE = false

-- Simple logging function - doesn't use a Logger table to avoid errors
local function log(message)
	if DEBUG_MODE then
		wezterm.log_info(message)
	end
end

log("Initializing WezTerm configuration")

--------------------------------------------------
-- Environment Detection
--------------------------------------------------
local is_wayland = os.getenv("WAYLAND_DISPLAY") ~= nil
local home_dir = os.getenv("HOME") or ""

-- Command cache to avoid repeated subprocess calls
local command_cache = {}
local function command_exists(cmd)
	if command_cache[cmd] ~= nil then
		return command_cache[cmd]
	end

	local success, _ = wezterm.run_child_process({ "which", cmd })
	command_cache[cmd] = success
	return success
end

--------------------------------------------------
-- Application & URL Definitions
--------------------------------------------------
local apps = {}
local urls = {
	google = "https://www.google.com",
	youtube = "https://www.youtube.com",
	jira = "https://syrosin.atlassian.net",
	gh = "https://github.com",
}

-- Detect applications with intelligent fallbacks
if command_exists("google-chrome-stable") then
	apps.chrome = "google-chrome-stable"
elseif command_exists("google-chrome") then
	apps.chrome = "google-chrome"
elseif command_exists("chromium") then
	apps.chrome = "chromium"
elseif command_exists("firefox") then
	apps.chrome = "firefox"
else
	apps.chrome = "xdg-open https://www.google.com"
end

if command_exists("discord") then
	apps.discord = "discord"
else
	apps.discord = "xdg-open https://discord.com/app"
end

if command_exists("postman") then
	apps.postman = "postman"
else
	apps.postman = "xdg-open https://web.postman.co"
end

if command_exists("slack") then
	apps.slack = "slack"
else
	apps.slack = "xdg-open https://app.slack.com"
end

if command_exists("spotify") then
	apps.spotify = "spotify"
else
	apps.spotify = "xdg-open https://open.spotify.com"
end

-- Determine Neovim executable
if command_exists("nvim") then
	apps.nvim = "nvim"
elseif command_exists("vim") then
	apps.nvim = "vim"
else
	apps.nvim = "vi"
end

--------------------------------------------------
-- Command Utilities
--------------------------------------------------
local function parse_cmd(cmd_str)
	if not cmd_str or cmd_str == "" then
		return {}
	end

	local args = {}
	local in_quotes = false
	local current_arg = ""
	local quote_char = nil

	for i = 1, #cmd_str do
		local char = cmd_str:sub(i, i)

		if (char == '"' or char == "'") and (i == 1 or cmd_str:sub(i - 1, i - 1) ~= "\\") then
			if not in_quotes then
				in_quotes = true
				quote_char = char
			elseif char == quote_char then
				in_quotes = false
				quote_char = nil
			else
				current_arg = current_arg .. char
			end
		elseif char == " " and not in_quotes then
			if current_arg ~= "" then
				table.insert(args, current_arg)
				current_arg = ""
			end
		else
			current_arg = current_arg .. char
		end
	end

	if current_arg ~= "" then
		table.insert(args, current_arg)
	end

	return args
end

local function create_app_launcher(app_cmd)
	return wezterm.action_callback(function(window, pane)
		local args = parse_cmd(app_cmd)
		if #args > 0 then
			wezterm.background_child_process(args)
		end
		return false
	end)
end

local function create_url_opener(url)
	return wezterm.action_callback(function(window, pane)
		wezterm.background_child_process({ "xdg-open", url })
		return false
	end)
end

--------------------------------------------------
-- Crimson Dark Theme Settings
--------------------------------------------------
-- A custom dark theme with reddish tones, designed for professionals
-- who appreciate a darker aesthetic with vibrant accents.
local crimson_dark = {
	-- Base colors
	bg = "#0A0A0C", -- Near-black background
	bg_highlight = "#1A1A1E", -- Slightly lighter for highlights
	bg_accent = "#2A1015", -- Very dark red tint for accents

	-- Foreground colors
	fg = "#E5E5E9", -- Light grey for main text
	fg_dark = "#C0C0C6", -- Slightly darker grey for secondary text
	fg_muted = "#8C8C96", -- Muted text

	-- Red accents (primary theme color)
	red_bright = "#FF3B51", -- Bright red for primary accents
	red = "#E02B40", -- Standard red
	red_muted = "#C02535", -- Muted red
	red_dark = "#801A25", -- Dark red for subtle highlights

	-- Supporting colors
	orange = "#FF7D4A", -- Orange accent
	yellow = "#FFCA80", -- Softer yellow
	green = "#7AE0A0", -- Subdued green
	cyan = "#56D1E0", -- Subdued cyan
	blue = "#6B9BDF", -- Subdued blue
	purple = "#BD93F9", -- Purple accent
	magenta = "#E986C0", -- Magenta accent

	-- UI element colors
	black = "#121216", -- Black for UI elements
	bright_black = "#4D4D59", -- Brighter black for UI
	white = "#F0F0F5", -- White

	-- Special colors
	error = "#FF2E3F", -- Error color
	warning = "#FFAA33", -- Warning color
	info = "#5CA8FF", -- Info color
	hint = "#9292A0", -- Hint color
}

--------------------------------------------------
-- Core Configuration
--------------------------------------------------
-- Terminal settings
config.term = "wezterm"

-- Font configuration
config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMono Nerd Font", weight = "Medium" },
	{ family = "JetBrains Mono", weight = "Medium" },
	"Hack Nerd Font",
	"DejaVu Sans Mono",
})

-- Typography settings
config.font_size = DEFAULT_FONT_SIZE
config.line_height = 1.2 -- Slightly increased for better readability
config.cell_width = 1.0

-- Window settings
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_background_opacity = 1.0

-- User experience
config.hide_mouse_cursor_when_typing = true
config.adjust_window_size_when_changing_font_size = false
config.warn_about_missing_glyphs = false

-- Initial window size
config.initial_cols = 120
config.initial_rows = 35

-- System integration
config.enable_wayland = is_wayland
config.enable_scroll_bar = false

-- Graphics and performance
config.front_end = "WebGpu"
config.webgpu_preferred_adapter = nil
config.animation_fps = 60

--------------------------------------------------
-- Crimson Dark Theme for WezTerm
--------------------------------------------------
-- A professionally designed dark theme with reddish accents,
-- optimized for reducing eye strain during long coding sessions
-- while providing a visually distinctive aesthetic.

config.colors = {
	-- Base colors
	foreground = crimson_dark.fg,
	background = crimson_dark.bg,

	-- Cursor
	cursor_bg = crimson_dark.red_bright,
	cursor_fg = crimson_dark.bg,
	cursor_border = crimson_dark.red_bright,

	-- Selection
	selection_fg = crimson_dark.fg,
	selection_bg = crimson_dark.bg_accent,

	-- Normal colors (ANSI 0-7)
	ansi = {
		crimson_dark.black, -- Black
		crimson_dark.red, -- Red
		crimson_dark.green, -- Green
		crimson_dark.yellow, -- Yellow
		crimson_dark.blue, -- Blue
		crimson_dark.magenta, -- Magenta
		crimson_dark.cyan, -- Cyan
		crimson_dark.fg_dark, -- White
	},

	-- Bright colors (ANSI 8-15)
	brights = {
		crimson_dark.bright_black, -- Bright Black
		crimson_dark.red_bright, -- Bright Red
		crimson_dark.green, -- Bright Green
		crimson_dark.orange, -- Bright Yellow (using orange)
		crimson_dark.blue, -- Bright Blue
		crimson_dark.purple, -- Bright Magenta
		crimson_dark.cyan, -- Bright Cyan
		crimson_dark.white, -- Bright White
	},

	-- Extended colors for UI accents
	indexed = {
		[16] = crimson_dark.orange, -- Orange
		[17] = crimson_dark.error, -- Error red
	},

	-- Tab bar (even though it's disabled, for consistency)
	tab_bar = {
		background = crimson_dark.bg,
		active_tab = {
			bg_color = crimson_dark.bg_accent,
			fg_color = crimson_dark.red_bright,
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = crimson_dark.bg,
			fg_color = crimson_dark.fg_muted,
		},
		inactive_tab_hover = {
			bg_color = crimson_dark.bg_highlight,
			fg_color = crimson_dark.red,
		},
		new_tab = {
			bg_color = crimson_dark.bg,
			fg_color = crimson_dark.fg_muted,
		},
		new_tab_hover = {
			bg_color = crimson_dark.bg_highlight,
			fg_color = crimson_dark.red,
		},
	},
}

--------------------------------------------------
-- Environment Variables
--------------------------------------------------
-- Set environment variables for consistent terminal experience
config.set_environment_variables = {
	-- Terminal capabilities for proper color support
	COLORTERM = "truecolor",
	TERM = "xterm-256color",
}

--------------------------------------------------
-- Keybinding System
--------------------------------------------------
config.keys = {
	-- Diagnostics
	{
		key = "d",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.ShowDebugOverlay,
		desc = "Show debug overlay",
	},
	{
		key = "r",
		mods = "CTRL|ALT",
		action = wezterm.action.ReloadConfiguration,
		desc = "Reload configuration",
	},

	-- Window management
	{
		key = "f",
		mods = "CTRL|ALT",
		action = wezterm.action.ToggleFullScreen,
		desc = "Toggle fullscreen mode",
	},

	-- Application launchers
	{
		key = "c",
		mods = APP_MODIFIER,
		action = create_app_launcher(apps.chrome),
		desc = "Launch browser",
	},
	{
		key = "d",
		mods = APP_MODIFIER,
		action = create_app_launcher(apps.discord),
		desc = "Launch Discord",
	},
	{
		key = "p",
		mods = APP_MODIFIER,
		action = create_app_launcher(apps.postman),
		desc = "Launch Postman",
	},
	{
		key = "s",
		mods = APP_MODIFIER,
		action = create_app_launcher(apps.slack),
		desc = "Launch Slack",
	},
	{
		key = "t",
		mods = APP_MODIFIER,
		action = create_app_launcher(apps.spotify),
		desc = "Launch Spotify",
	},
	{
		key = "n",
		mods = APP_MODIFIER,
		action = wezterm.action.SpawnCommandInNewWindow({
			args = parse_cmd(apps.nvim),
		}),
		desc = "Launch Neovim in new window",
	},

	-- URL launchers
	{
		key = "g",
		mods = URL_MODIFIER,
		action = create_url_opener(urls.google),
		desc = "Open Google",
	},
	{
		key = "y",
		mods = URL_MODIFIER,
		action = create_url_opener(urls.youtube),
		desc = "Open YouTube",
	},
	{
		key = "j",
		mods = URL_MODIFIER,
		action = create_url_opener(urls.jira),
		desc = "Open Jira",
	},
	{
		key = "h",
		mods = URL_MODIFIER,
		action = create_url_opener(urls.gh),
		desc = "Open GitHub",
	},
}

--------------------------------------------------
-- Recovery Options
--------------------------------------------------
config.launch_menu = config.launch_menu or {}
table.insert(config.launch_menu, {
	label = "Safe Mode",
	args = { "--config-file", "none" },
})

table.insert(config.launch_menu, {
	label = "Neovim",
	args = { apps.nvim },
})

--------------------------------------------------
-- Event Handlers
--------------------------------------------------
wezterm.on("window-config-reloaded", function(window, pane)
	window:toast_notification("WezTerm", "Configuration reloaded successfully", nil, 2000)
end)

-- Ensure configurations are available
wezterm.on("gui-startup", function()
	log("GUI started successfully")
end)

return config
