local util = require("purple.util")

local M = {}

---@class Palette
M.default = {
  none = "NONE",

  gitGreen   = "#5aff5d",
  gitOrange  = "#ffae44",
  gitRed     = "#ff4444",
  warning    = "#ffd700",

  fg         = "#2f2f2f",
  lgtbase00  = "#ffffff",
  lgtbase01  = "#d1d1d1",
  base03     = "#171717",
  base02     = "#302c2c",
  base01     = "#51545c",
  base00     = "#7e7e7e",

  yellow     = "#3d2aff",
  yellow100  = "#685aff",
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
  temp2      = "#5effc3",
  pink       = "#ff5eed",
  red500     = "#dc312e",

  bg = "#1d1d1d",
  bg_highlight = "#1d1d1d",
}

---@return ColorScheme
function M.setup(opts)
  opts = opts or {}
  local config = require("purple.config")
  
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

  colors.error = colors.red500
  colors.warning = "#d38454"
  colors.info = colors.gitOrange
  colors.hint = colors.cyan100
  colors.todo = colors.lgtbase00

  config.options.on_colors(colors)

  return colors
end

return M
