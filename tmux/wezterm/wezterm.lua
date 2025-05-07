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
-- Tokyo Night Theme Settings
--------------------------------------------------
-- Define Tokyo Night color palette for consistency across tools
local tokyo_night = {
	bg = "#1a1b26",
	bg_dark = "#16161e",
	bg_highlight = "#292e42",
	terminal_black = "#414868",
	fg = "#c0caf5",
	fg_dark = "#a9b1d6",
	fg_gutter = "#3b4261",
	dark3 = "#545c7e",
	comment = "#565f89",
	blue = "#7aa2f7",
	cyan = "#7dcfff",
	blue0 = "#3d59a1",
	blue1 = "#2ac3de",
	blue2 = "#0db9d7",
	blue5 = "#89ddff",
	blue6 = "#b4f9f8",
	blue7 = "#394b70",
	magenta = "#bb9af7",
	magenta2 = "#ff007c",
	purple = "#9d7cd8",
	orange = "#ff9e64",
	yellow = "#e0af68",
	green = "#9ece6a",
	green1 = "#73daca",
	green2 = "#41a6b5",
	teal = "#1abc9c",
	red = "#f7768e",
	red1 = "#db4b4b",
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
-- Tokyo Night Theme for WezTerm
--------------------------------------------------
-- A meticulously crafted theme inspired by Tokyo's night cityscape,
-- designed for distinguished engineers and UI/UX professionals.
-- This theme perfectly complements the Tokyo Night theme in Neovim and tmux.

config.colors = {
	-- Base colors
	foreground = tokyo_night.fg,
	background = tokyo_night.bg,

	-- Cursor
	cursor_bg = tokyo_night.fg,
	cursor_fg = tokyo_night.bg,
	cursor_border = tokyo_night.fg,

	-- Selection
	selection_fg = tokyo_night.bg,
	selection_bg = tokyo_night.bg_highlight,

	-- Normal colors (ANSI 0-7)
	ansi = {
		tokyo_night.bg_dark, -- Black
		tokyo_night.red, -- Red
		tokyo_night.green, -- Green
		tokyo_night.yellow, -- Yellow
		tokyo_night.blue, -- Blue
		tokyo_night.magenta, -- Magenta
		tokyo_night.cyan, -- Cyan
		tokyo_night.fg_dark, -- White
	},

	-- Bright colors (ANSI 8-15)
	brights = {
		tokyo_night.terminal_black, -- Bright Black
		tokyo_night.red1, -- Bright Red
		tokyo_night.green1, -- Bright Green
		tokyo_night.orange, -- Bright Yellow
		tokyo_night.blue1, -- Bright Blue
		tokyo_night.magenta, -- Bright Magenta
		tokyo_night.blue2, -- Bright Cyan
		tokyo_night.fg, -- Bright White
	},

	-- Extended colors for UI accents
	indexed = {
		[16] = tokyo_night.orange, -- Orange
		[17] = tokyo_night.red1, -- Error red
	},

	-- Tab bar (even though it's disabled, for consistency)
	tab_bar = {
		background = tokyo_night.bg_dark,
		active_tab = {
			bg_color = tokyo_night.bg,
			fg_color = tokyo_night.blue,
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = tokyo_night.bg_dark,
			fg_color = tokyo_night.dark3,
		},
		inactive_tab_hover = {
			bg_color = tokyo_night.bg,
			fg_color = tokyo_night.blue,
		},
		new_tab = {
			bg_color = tokyo_night.bg_dark,
			fg_color = tokyo_night.dark3,
		},
		new_tab_hover = {
			bg_color = tokyo_night.bg,
			fg_color = tokyo_night.blue,
		},
	},
}

--------------------------------------------------
-- Environment Variables for Theme Consistency
--------------------------------------------------
-- Set environment variables to ensure consistent theming across tools
config.set_environment_variables = {
	-- For Neovim - ensure it knows we want Tokyo Night theme
	NVIM_THEME = "tokyonight",

	-- Terminal capabilities for proper color support
	COLORTERM = "truecolor",
	TERM = "xterm-256color",

	-- Tokyo Night specific environment variables
	TOKYONIGHT_STYLE = "night",
}

--------------------------------------------------
-- Neovim Integration - Create init.lua
--------------------------------------------------
-- This section creates a Neovim config that automatically applies Tokyo Night
-- when launched from WezTerm, ensuring theme consistency

local nvim_tokyo_night_config_path = home_dir .. "/.config/nvim/tokyo_night.lua"
local nvim_tokyo_night_content = [[
-- Tokyo Night theme configuration for Neovim
-- This file is automatically generated by WezTerm

-- Only load this file if we're in WezTerm
if vim.env.WEZTERM_PANE then
  -- Set colorscheme to Tokyo Night
  vim.cmd('colorscheme tokyonight')
  
  -- Ensure the correct variant is used
  vim.g.tokyonight_style = "night"
  
  -- Enable transparent background if supported
  vim.g.tokyonight_transparent = false
  vim.g.tokyonight_transparent_sidebar = false
  
  -- Ensure terminal colors match
  vim.g.terminal_color_0 = "#16161e"
  vim.g.terminal_color_1 = "#f7768e"
  vim.g.terminal_color_2 = "#9ece6a"
  vim.g.terminal_color_3 = "#e0af68"
  vim.g.terminal_color_4 = "#7aa2f7"
  vim.g.terminal_color_5 = "#bb9af7"
  vim.g.terminal_color_6 = "#7dcfff"
  vim.g.terminal_color_7 = "#a9b1d6"
  vim.g.terminal_color_8 = "#414868"
  vim.g.terminal_color_9 = "#f7768e"
  vim.g.terminal_color_10 = "#9ece6a"
  vim.g.terminal_color_11 = "#e0af68"
  vim.g.terminal_color_12 = "#7aa2f7"
  vim.g.terminal_color_13 = "#bb9af7"
  vim.g.terminal_color_14 = "#7dcfff"
  vim.g.terminal_color_15 = "#c0caf5"
end

-- Return module for importing
return {
  style = "night",
  colors = {
    bg = "#1a1b26",
    bg_dark = "#16161e",
    bg_highlight = "#292e42",
    terminal_black = "#414868",
    fg = "#c0caf5",
    fg_dark = "#a9b1d6",
    fg_gutter = "#3b4261",
    dark3 = "#545c7e",
    comment = "#565f89",
    blue = "#7aa2f7",
    cyan = "#7dcfff",
    blue0 = "#3d59a1",
    blue1 = "#2ac3de",
    blue2 = "#0db9d7",
    blue5 = "#89ddff",
    blue6 = "#b4f9f8",
    blue7 = "#394b70",
    magenta = "#bb9af7",
    magenta2 = "#ff007c",
    purple = "#9d7cd8",
    orange = "#ff9e64",
    yellow = "#e0af68",
    green = "#9ece6a",
    green1 = "#73daca",
    green2 = "#41a6b5",
    teal = "#1abc9c",
    red = "#f7768e",
    red1 = "#db4b4b",
  }
}
]]

-- Also create an init.lua detection file
local nvim_init_check_path = home_dir .. "/.config/nvim/init_wezterm.lua"
local nvim_init_check_content = [[
-- WezTerm integration for Neovim
-- This file is automatically generated by WezTerm

-- Only load this if we're in WezTerm
if vim.env.WEZTERM_PANE then
  -- Check if Tokyo Night plugin is installed
  local has_tokyonight = pcall(require, "tokyonight")
  
  if has_tokyonight then
    -- Load the plugin and set the style
    vim.cmd('colorscheme tokyonight')
    vim.g.tokyonight_style = "night"
  else
    -- Print a message that the plugin needs to be installed
    vim.api.nvim_echo({
      {"Tokyo Night theme not found. Install with your package manager:", "WarningMsg"},
      {"", ""},
      {"\nFor packer.nvim:", "Title"},
      {"\nuse 'folke/tokyonight.nvim'", ""},
      {"\n\nFor vim-plug:", "Title"},
      {"\nPlug 'folke/tokyonight.nvim'", ""}
    }, true, {})
    
    -- Set some basic colors that approximate Tokyo Night
    vim.cmd('highlight Normal guibg=#1a1b26 guifg=#c0caf5')
    vim.cmd('highlight LineNr guifg=#3b4261')
    vim.cmd('highlight CursorLine guibg=#292e42')
    vim.cmd('highlight Pmenu guibg=#1a1b26 guifg=#c0caf5')
    vim.cmd('highlight PmenuSel guibg=#292e42 guifg=#c0caf5')
    vim.cmd('highlight Comment guifg=#565f89')
    vim.cmd('highlight Statement guifg=#bb9af7')
    vim.cmd('highlight Identifier guifg=#7aa2f7')
    vim.cmd('highlight Function guifg=#7aa2f7')
    vim.cmd('highlight String guifg=#9ece6a')
    vim.cmd('highlight Constant guifg=#ff9e64')
    vim.cmd('highlight Type guifg=#2ac3de')
    vim.cmd('highlight Special guifg=#e0af68')
  end
end
]]

-- Function to ensure Neovim configuration exists
local function ensure_nvim_config()
	-- Ensure the config directory exists
	local nvim_config_dir = home_dir .. "/.config/nvim"
	wezterm.run_child_process({ "mkdir", "-p", nvim_config_dir })

	-- Write the Tokyo Night theme configuration
	local file = io.open(nvim_tokyo_night_config_path, "w")
	if file then
		file:write(nvim_tokyo_night_content)
		file:close()
		log("Created Neovim Tokyo Night theme configuration")
	else
		log("Failed to create Neovim configuration file")
	end

	-- Write the init detection file
	local init_file = io.open(nvim_init_check_path, "w")
	if init_file then
		init_file:write(nvim_init_check_content)
		init_file:close()
		log("Created Neovim WezTerm integration file")
	else
		log("Failed to create Neovim integration file")
	end

	-- Check if init.lua exists, if not create it with a simple loader
	local init_exists = wezterm.run_child_process({ "test", "-f", nvim_config_dir .. "/init.lua" })
	if not init_exists then
		local init_main = io.open(nvim_config_dir .. "/init.lua", "w")
		if init_main then
			init_main:write([[
-- Auto-generated Neovim config by WezTerm
-- Load WezTerm integration if available
local wezterm_init = vim.fn.expand('~/.config/nvim/init_wezterm.lua')
if vim.fn.filereadable(wezterm_init) == 1 then
  dofile(wezterm_init)
end

-- Your custom Neovim configuration goes here
]])
			init_main:close()
			log("Created basic Neovim init.lua")
		end
	else
		-- Ensure init.lua loads our integration
		local init_content = io.open(nvim_config_dir .. "/init.lua", "r")
		if init_content then
			local content = init_content:read("*all")
			init_content:close()

			if not content:find("init_wezterm.lua") then
				local init_update = io.open(nvim_config_dir .. "/init.lua", "w")
				if init_update then
					init_update:write([[
-- WezTerm integration (auto-inserted)
local wezterm_init = vim.fn.expand('~/.config/nvim/init_wezterm.lua')
if vim.fn.filereadable(wezterm_init) == 1 then
  dofile(wezterm_init)
end

]] .. content)
					init_update:close()
					log("Updated existing Neovim init.lua with WezTerm integration")
				end
			end
		end
	end
end

-- Set up Neovim configuration if nvim is available
if command_exists("nvim") then
	ensure_nvim_config()
end

--------------------------------------------------
-- Tmux Configuration - Tokyo Night Theme
--------------------------------------------------
-- Generate tmux config with matching Tokyo Night theme
local tmux_config_path = home_dir .. "/.tmux.tokyo-night.conf"
local tmux_config_content = [[
# Tokyo Night theme for tmux
# Designed to match WezTerm and Neovim configurations

# Enable true color support
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"

# Set environment variables for Neovim theme consistency
set-environment -g NVIM_THEME tokyonight
set-environment -g TOKYONIGHT_STYLE night

# Status bar colors
set -g status-style "bg=#16161e,fg=#7aa2f7"

# Window list colors
set -g window-status-current-style "bg=#3b4261,fg=#7aa2f7,bold"
set -g window-status-style "bg=#16161e,fg=#565f89"

# Pane borders
set -g pane-border-style "fg=#3b4261"
set -g pane-active-border-style "fg=#7aa2f7"

# Message colors
set -g message-style "bg=#3b4261,fg=#7aa2f7,bold"
set -g message-command-style "bg=#3b4261,fg=#7aa2f7,bold"

# Clock mode
set -g clock-mode-colour "#7aa2f7"

# Status bar layout
set -g status-left "#[fg=#1a1b26,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#16161e,nobold]"
set -g window-status-format " #I:#W "
set -g window-status-current-format "#[fg=#16161e,bg=#3b4261]#[fg=#7aa2f7,bg=#3b4261] #I:#W #[fg=#3b4261,bg=#16161e]"
set -g status-right "#[fg=#3b4261,bg=#16161e]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d #[fg=#1a1b26,bg=#7aa2f7] %H:%M "

# Set status bar position and length
set -g status-position bottom
set -g status-left-length 50
set -g status-right-length 50

# Set a custom session initialization command to set WEZTERM_PANE
set-hook -g after-new-session "set-environment WEZTERM_PANE 1"
set-hook -g after-new-window "set-environment WEZTERM_PANE 1"

# Source this file for a Tokyo Night tmux session:
# tmux -f ~/.tmux.tokyo-night.conf new-session -A -s main
]]

-- Write tmux config file if it doesn't exist
local function ensure_tmux_config()
	local success, _ = wezterm.run_child_process({ "test", "-f", tmux_config_path })
	if not success then
		local file = io.open(tmux_config_path, "w")
		if file then
			file:write(tmux_config_content)
			file:close()
			log("Created tmux Tokyo Night theme configuration")
		else
			log("Failed to create tmux configuration file")
		end
	end
end

-- Set up tmux configuration if tmux is available
if command_exists("tmux") then
	ensure_tmux_config()
end

-- Create a function to launch tmux with the Tokyo Night theme
local function create_tmux_launcher()
	return wezterm.action_callback(function(window, pane)
		-- Ensure the tmux config exists
		ensure_tmux_config()

		-- Launch tmux with our theme
		window:perform_action(
			wezterm.action.SpawnCommandInNewWindow({
				args = { "tmux", "new-session", "-A", "-s", "main", "-f", tmux_config_path },
				set_environment_variables = {
					WEZTERM_PANE = "1",
					NVIM_THEME = "tokyonight",
					TOKYONIGHT_STYLE = "night",
				},
			}),
			pane
		)
		return false
	end)
end

--------------------------------------------------
-- Additional Environment Setup
--------------------------------------------------
-- Set WEZTERM_PANE for all new processes to ensure theme detection
config.set_environment_variables["WEZTERM_PANE"] = "1"

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
			set_environment_variables = {
				WEZTERM_PANE = "1",
				NVIM_THEME = "tokyonight",
				TOKYONIGHT_STYLE = "night",
			},
		}),
		desc = "Launch Neovim in new window",
	},

	-- Add tmux launcher with theme
	{
		key = "m",
		mods = APP_MODIFIER,
		action = create_tmux_launcher(),
		desc = "Launch tmux with Tokyo Night theme",
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
	label = "Neovim with Tokyo Night",
	args = { apps.nvim },
	set_environment_variables = {
		WEZTERM_PANE = "1",
		NVIM_THEME = "tokyonight",
		TOKYONIGHT_STYLE = "night",
	},
})

table.insert(config.launch_menu, {
	label = "Tmux with Tokyo Night",
	args = { "tmux", "new-session", "-A", "-s", "main", "-f", tmux_config_path },
	set_environment_variables = {
		WEZTERM_PANE = "1",
		NVIM_THEME = "tokyonight",
		TOKYONIGHT_STYLE = "night",
	},
})

--------------------------------------------------
-- Event Handlers
--------------------------------------------------
wezterm.on("window-config-reloaded", function(window, pane)
	window:toast_notification("WezTerm", "Configuration reloaded successfully", nil, 2000)
end)

-- Ensure configurations are available
wezterm.on("gui-startup", function()
	if command_exists("tmux") then
		ensure_tmux_config()
	end
	if command_exists("nvim") then
		ensure_nvim_config()
	end
	log("GUI started successfully")
end)

return config
