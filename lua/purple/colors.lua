local util = require("purple.util")
local hslutil = require("purple.hsl")
local hsl = hslutil.hslToHex

local M = {}

---@class Palette
M.default = {
  none = "NONE",

  gitGreen = "#5aff5d",
  gitOrange = "#ffae44",
  gitRed = "#ff4444",

  background = "#1d1d1d",
  base04 = "#171717",
  base03 = hsl(192, 100, 11),
  base02 = hsl(192, 81, 14),
  -- Comments
  base01 = "#51545c",
  base00 = hsl(196, 13, 45),
  base0 = hsl(186, 8, 65),
  base1 = hsl(180, 7, 70),
  white = "#d1d1d1",
  yellow = "#3d2aff",
  yellow100 = "#685aff",
  yellow300 = hsl(45, 100, 50),
  yellow500 = hsl(45, 100, 35),
  yellow700 = hsl(45, 100, 20),
  yellow900 = hsl(46, 100, 10),
  pink = "#ff5eed",
  red = "#a52aff",
  red100 = "#ba5aff",
  red300 = hsl(1, 90, 64),
  red500 = hsl(1, 71, 52),
  red700 = hsl(1, 71, 42),
  red900 = hsl(1, 71, 20),
  magenta = "#2883ff",
  magenta100 = "#5ea2ff",
  magenta500 = hsl(331, 64, 52),
  magenta700 = hsl(331, 64, 42),
  violet = hsl(237, 43, 60),
  violet100 = hsl(236, 100, 90),
  violet300 = hsl(237, 69, 77),
  violet500 = hsl(237, 43, 60),
  violet700 = hsl(237, 43, 50),
  violet900 = hsl(237, 42, 25),
  blue = "#2b4fff",
  blue100 = "#5c78ff",
  blue300 = hsl(205, 90, 62),
  blue500 = hsl(205, 69, 49),
  blue700 = hsl(205, 70, 35),
  blue900 = hsl(205, 69, 20),
  cyan = "#28b9ff",
  cyan100 = "#5ac8ff",
  cyan300 = hsl(175, 85, 55),
  cyan500 = hsl(175, 59, 40),
  cyan700 = hsl(182, 59, 25),
  green = "#7129ff",
  green100 = "#905aff",
  green500 = hsl(68, 100, 30),
  green900 = hsl(68, 100, 10),

  bg = "#1d1d1d",
  bg_highlight = hsl(192, 100, 11),
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
  colors.bg_popup = colors.base04
  colors.bg_statusline = "#1d1d1d"

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
    or config.options.styles.sidebars == "dark" and colors.base04
    or colors.bg

  colors.bg_float = config.options.styles.floats == "transparent" and colors.none
    or config.options.styles.floats == "dark" and colors.base04
    or colors.bg

  -- colors.fg_float = config.options.styles.floats == "dark" and colors.base01 or colors.fg
  colors.fg_float = colors.fg

  colors.error = colors.red500
  colors.warning = colors.yellow500
  colors.info = colors.blue500
  colors.hint = colors.cyan500
  colors.todo = colors.violet500

  config.options.on_colors(colors)
  if opts.transform and config.is_day() then
    util.invert_colors(colors)
  end

  return colors
end

return M
