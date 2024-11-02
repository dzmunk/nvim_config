-- theme.lua
vim.cmd('highlight clear')
vim.opt.termguicolors = true
vim.g.colors_name = 'my_kanagawa'

local colors = {
  bg = '#1F1F28',
  fg = '#DCD7BA',
  red = '#E46876',
  green = '#98BB6C',
  yellow = '#E6C384',
  blue = '#7FB4CA',
  magenta = '#957FB8',
  cyan = '#7AA89F',
  white = '#C8C093',
  orange = '#FF9E3B',
}

local highlights = {
  Normal = { fg = colors.fg, bg = colors.bg },
  Comment = { fg = colors.white, italic = true },
  Constant = { fg = colors.cyan },
  String = { fg = colors.green },
  Identifier = { fg = colors.blue },
  Function = { fg = colors.yellow },
  Statement = { fg = colors.red },
  Type = { fg = colors.magenta },
  TabLineSel = { fg = colors.bg, bg = colors.fg },
  TabLine = { fg = colors.white, bg = colors.bg },
  TabLineFill = { fg = colors.bg, bg = colors.bg },
}

for group, opts in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, opts)
end

