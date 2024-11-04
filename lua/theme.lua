vim.cmd('highlight clear')
vim.opt.termguicolors = true
vim.g.colors_name = 'kanagawa'

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
  black = '#1F1F28',
  black2 = '#2A2A37',
  light_grey = '#5C5C66',
  one_bg2 = '#3A3A4B',
  nord_blue = '#5E81AC',
  one_bg3 = '#464655',
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
  TbFill = { bg = colors.black2 },
  TbBufOn = { fg = colors.white, bg = colors.black },
  TbBufOff = { fg = colors.light_grey, bg = colors.black2 },
  TbBufOnModified = { fg = colors.green, bg = colors.black },
  TbBufOffModified = { fg = colors.red, bg = colors.black2 },
  TbBufOnClose = { fg = colors.red, bg = colors.black },
  TbBufOffClose = { fg = colors.light_grey, bg = colors.black2 },
  TbTabNewBtn = { fg = colors.white, bg = colors.one_bg2 },
  TbTabOn = { fg = colors.red },
  TbTabOff = { fg = colors.white, bg = colors.black2 },
  TbTabCloseBtn = { fg = colors.black, bg = colors.nord_blue },
  TBTabTitle = { fg = colors.black, bg = colors.blue },
  TbCloseAllBufsBtn = { bold = true, fg = colors.black, bg = colors.red },
}

for group, opts in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, opts)
end

