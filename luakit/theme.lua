--------------------------
-- Default luakit theme --
--------------------------

local S_yellow  = "#b58900"
local S_orange  = "#cb4b16"
local S_red     = "#dc322f"
local S_magenta = "#d33682"
local S_violet  = "#6c71c4"
local S_blue    = "#268bd2"
local S_cyan    = "#2aa198"
local S_green   = "#859900"
local S_base03  = "#002b36"
local S_base02  = "#073642"
local S_base01  = "#586e75"
local S_base00  = "#657b83"
local S_base0   = "#839496"
local S_base1   = "#93a1a1"
local S_base2   = "#eee8d5"
local S_base3   = "#fdf6e3"

local theme = {}

-- Default settings
theme.font = "xft:DejaVu Sans Mono:regular:size=10"
theme.fg   = S_base00
theme.bg   = S_base03

-- Genaral colours
theme.success_fg = S_green
theme.error_bg = S_red

-- Warning colours
theme.warning_fg = S_red

-- Menu colours
theme.menu_selected_bg          = S_magenta
theme.menu_primary_title_fg     = S_red

-- Input bar specific
theme.ibar_fg           = S_base00
theme.ibar_bg           = S_base02

-- Proxy manager
theme.dbar_error_fg   = S_red

-- Trusted/untrusted ssl colours
theme.trust_fg          = S_green
theme.notrust_fg        = S_red

return theme
-- vim: et:sw=4:ts=8:sts=4:tw=80
