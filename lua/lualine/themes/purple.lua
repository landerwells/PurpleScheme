local colors = require("purple.colors").setup({ transform = true })
local config = require("purple.config").options

local purple_local = {}

purple_local.normal = {
  a = { bg = colors.blue, fg = colors.black },
  b = { bg = colors.base0, fg = colors.base04 },
  c = { bg = colors.bg_statusline, fg = colors.fg },
}

purple_local.insert = {
  a = { bg = colors.green, fg = colors.black },
}

purple_local.command = {
  a = { bg = colors.yellow, fg = colors.black },
}

purple_local.visual = {
  a = { bg = colors.magenta, fg = colors.black },
}

purple_local.replace = {
  a = { bg = colors.red, fg = colors.black },
}

purple_local.terminal = {
  a = { bg = colors.green, fg = colors.black },
}

purple_local.inactive = {
  a = { bg = colors.bg_statusline, fg = colors.blue },
  b = { bg = colors.bg_statusline, fg = colors.fg, gui = "bold" },
  c = { bg = colors.bg_statusline, fg = colors.fg },
}

if config.lualine_bold then
  for _, mode in pairs(purple_local) do
    mode.a.gui = "bold"
  end
end

return purple_local
