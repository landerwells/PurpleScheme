local util = require("purple.util")
local hslutil = require("purple.hsl")
local hsl = hslutil.hslToHex

local M = {}

---@class Palette
M.default = {
  none = "NONE",

  gitGreen   = "#5aff5d",
  gitOrange  = "#ffae44",
  gitRed     = "#ff4444",
  temp       = "#ffd700",
  temp2      = "#5effc3",

  base03     = "#171717",
  base02     = "#302c2c",
  base01     = "#51545c",
  temp3      = "#7e7e7e",
  white      = "#d1d1d1",
  base00     = hsl(196, 13, 45),
  base0      = hsl(186, 8, 65),

  yellow     = "#3d2aff",
  yellow100  = "#685aff",
  pink       = "#ff5eed",
  red        = "#a52aff",
  red100     = "#ba5aff",
  magenta    = "#2883ff",
  magenta100 = "#5ea2ff",
  blue       = "#2b4fff",
  blue100    = "#5c78ff",
  cyan       = "#28b9ff",
  cyan100    = "#5ac8ff",
  green      = "#7129ff",
  green100   = "#905aff",
  red500     = hsl(1, 71, 52),
  violet     = hsl(237, 43, 60),
  violet700  = hsl(237, 43, 50),
  violet900  = hsl(237, 42, 25),

  bg = "#1d1d1d",
  bg_highlight = "#1d1d1d",
  fg = hsl(186, 8, 55),
}

---@return ColorScheme
function M.setup(opts)
  opts = opts or {}
  local config = require("purple.config")

  -- local style = config.is_day() and config.options.light_style or config.options.style
  local style = "default"
  local palette = M[style] or {}
  if type(palette) == "function" then
    palette = palette()
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

  util.bg = colors.bg
  util.day_brightness = config.options.day_brightness

  colors.black = util.darken(colors.bg, 0.8, "#000000")
  colors.border = colors.black

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.base03
  colors.bg_statusline = "#1d1d1d"

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
    or config.options.styles.sidebars == "dark" and colors.base03
    or colors.bg

  colors.bg_float = config.options.styles.floats == "transparent" and colors.none
    or config.options.styles.floats == "dark" and colors.base03
    or colors.bg

  -- colors.fg_float = config.options.styles.floats == "dark" and colors.base01 or colors.fg
  colors.fg_float = colors.fg

  colors.error = hsl(1, 71, 52)
  colors.warning = "#d38454"
  colors.info = "#ffae44"
  colors.hint = colors.cyan100
  colors.todo = colors.white

  config.options.on_colors(colors)
  if opts.transform and config.is_day() then
    util.invert_colors(colors)
  end

  return colors
end

return M
