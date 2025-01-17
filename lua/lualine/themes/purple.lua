local colors = require("purple.colors").setup({ transform = true })
local config = require("purple.config").options

local purple_local = {}

purple_local.normal = {
  a = { bg = "#ffffff", fg = "#000000" },
  b = { bg = "#171717", fg = "#ffffff" },
  c = { bg = "#1d1d1d", fg = "#1d1d1d" },
}

purple_local.insert = {
  a = { bg = colors.green100, fg = colors.black },
}

purple_local.command = {
  a = { bg = colors.yellow100, fg = colors.black },
}

purple_local.visual = {
  a = { bg = colors.magenta, fg = colors.black },
}

purple_local.replace = {
  a = { bg = colors.red100, fg = colors.black },
}

purple_local.terminal = {
  a = { bg = colors.pink, fg = colors.black },
}

purple_local.inactive = {
  a = { bg = colors.bg_statusline, fg = colors.base01 },
  b = { bg = colors.bg_statusline, fg = colors.fg, gui = "bold" },
  c = { bg = colors.bg_statusline, fg = colors.fg },
}

if config.lualine_bold then
  for _, mode in pairs(purple_local) do
    mode.a.gui = "bold"
  end
end

return purple_local
