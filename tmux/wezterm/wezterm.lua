--[[
WezTerm Configuration - Enterprise Edition
Optimized for professional development
Author: Colson (@colson0x1)
--]]

local wezterm = require("wezterm")
local config = {}

-- Constants
local DEFAULT_FONT_SIZE = 12.5
local APP_MODIFIER = "ALT"
local URL_MODIFIER = "ALT"

-- Set to true only when debugging configuration issues
local DEBUG_MODE = false

-- Logger
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
-- Core Configuration
--------------------------------------------------
-- Terminal settings
config.term = "wezterm"

-- Font configuration
config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	"JetBrains Mono",
	"Hack Nerd Font",
	"DejaVu Sans Mono",
})

-- Typography settings - removed invalid properties
config.font_size = DEFAULT_FONT_SIZE
config.line_height = 1.15
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
-- Premium Nord Theme for Distinguished Engineers
--------------------------------------------------
-- This professional-grade Nord theme variant has been optimized for
-- readability during extended coding sessions while maintaining
-- exceptional contrast ratios for reduced eye strain.
config.colors = {
	-- Base colors - pure black background with optimized Nord foreground
	foreground = "#E5E9F0", -- Slightly brighter for better contrast on black
	background = "#000000", -- Pure black background

	-- Cursor with high visibility
	cursor_bg = "#88C0D0", -- Nord's cyan for better visibility
	cursor_fg = "#000000",
	cursor_border = "#88C0D0",

	-- Selection with optimal contrast
	selection_fg = "#000000",
	selection_bg = "#81A1C1", -- Nord's blue for clear selection state

	-- Normal colors - calibrated for code readability
	ansi = {
		"#3B4252", -- Black
		"#BF616A", -- Red
		"#A3BE8C", -- Green
		"#EBCB8B", -- Yellow
		"#81A1C1", -- Blue
		"#B48EAD", -- Magenta
		"#88C0D0", -- Cyan
		"#E5E9F0", -- White
	},

	-- Bright colors - enhanced for important syntax elements
	brights = {
		"#4C566A", -- Bright Black
		"#D08770", -- Bright Red (Nord's orange for better distinction)
		"#A3BE8C", -- Bright Green
		"#EBCB8B", -- Bright Yellow
		"#5E81AC", -- Bright Blue (using deeper Nord blue for emphasis)
		"#B48EAD", -- Bright Magenta
		"#8FBCBB", -- Bright Cyan
		"#ECEFF4", -- Bright White
	},

	-- Tab bar (even though it's disabled, for consistency)
	tab_bar = {
		background = "#000000",
		active_tab = {
			bg_color = "#1C1C1C",
			fg_color = "#E5E9F0",
		},
		inactive_tab = {
			bg_color = "#000000",
			fg_color = "#4C566A",
		},
		inactive_tab_hover = {
			bg_color = "#1C1C1C",
			fg_color = "#E5E9F0",
		},
		new_tab = {
			bg_color = "#000000",
			fg_color = "#4C566A",
		},
		new_tab_hover = {
			bg_color = "#1C1C1C",
			fg_color = "#E5E9F0",
		},
	},
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
			args = parse_cmd(apps.nvim .. " ."),
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

--------------------------------------------------
-- Event Handlers
--------------------------------------------------
wezterm.on("window-config-reloaded", function(window, pane)
	window:toast_notification("WezTerm", "Configuration reloaded successfully", nil, 2000)
end)

return config
