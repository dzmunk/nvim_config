vim.cmd.highlight 'clear'
if vim.fn.exists 'syntax_on' then
    vim.cmd.syntax 'reset'
end

vim.g.colors_name = 'personal'
vim.o.termguicolors = true

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

local hl = vim.api.nvim_set_hl

hl(0, 'Normal',         { fg = colors.fg, bg = colors.bg })
hl(0, 'NormalNC',       { link = 'Normal' })
hl(0, 'NormalFloat',    { fg = colors.fg, bg = colors.bg })
hl(0, 'CursorLine',     { bg = colors.black2 })
hl(0, 'CursorLineNr',   { fg = colors.yellow, bold = true })
hl(0, 'LineNr',         { fg = colors.light_grey })
hl(0, 'Visual',         { bg = colors.one_bg3 })
hl(0, 'Search',         { fg = colors.black, bg = colors.nord_blue, bold = true })
hl(0, 'IncSearch',      { fg = colors.black, bg = colors.orange,   bold = true })
hl(0, 'MatchParen',     { underline = true })
hl(0, 'StatusLine',     { fg = colors.fg, bg = colors.black2 })
hl(0, 'StatusLineNC',   { fg = colors.light_grey, bg = colors.black2 })
hl(0, 'Pmenu',          { fg = colors.fg, bg = colors.black2 })
hl(0, 'PmenuSel',       { fg = colors.black, bg = colors.blue, bold = true })
hl(0, 'PmenuSbar',      { bg = colors.one_bg2 })
hl(0, 'PmenuThumb',     { bg = colors.one_bg3 })
hl(0, 'TabLineSel',     { fg = colors.bg, bg = colors.fg })
hl(0, 'TabLine',        { fg = colors.white, bg = colors.bg })
hl(0, 'TabLineFill',    { fg = colors.bg, bg = colors.bg })

hl(0, 'Comment',        { fg = colors.white, italic = true })
hl(0, 'Constant',       { fg = colors.cyan })
hl(0, 'String',         { fg = colors.green })
hl(0, 'Character',      { link = 'String' })
hl(0, 'Number',         { fg = colors.orange })
hl(0, 'Boolean',        { fg = colors.orange })
hl(0, 'Identifier',     { fg = colors.blue })
hl(0, 'Function',       { fg = colors.yellow })
hl(0, 'Statement',      { fg = colors.red })
hl(0, 'Operator',       { fg = colors.white })
hl(0, 'Type',           { fg = colors.magenta })
hl(0, 'PreProc',        { fg = colors.magenta })
hl(0, 'Special',        { fg = colors.cyan })

hl(0, 'DiagnosticError', { fg = colors.red })
hl(0, 'DiagnosticWarn',  { fg = colors.orange })
hl(0, 'DiagnosticInfo',  { fg = colors.blue })
hl(0, 'DiagnosticHint',  { fg = colors.cyan })
hl(0, 'DiagnosticOk',    { fg = colors.green })
hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = colors.red })
hl(0, 'DiagnosticUnderlineWarn',  { undercurl = true, sp = colors.orange })
hl(0, 'DiagnosticUnderlineInfo',  { undercurl = true, sp = colors.blue })
hl(0, 'DiagnosticUnderlineHint',  { undercurl = true, sp = colors.cyan })

hl(0, '@comment',            { link = 'Comment' })
hl(0, '@constant',           { link = 'Constant' })
hl(0, '@string',             { link = 'String' })
hl(0, '@string.escape',      { fg = colors.orange })
hl(0, '@character',          { link = 'Character' })
hl(0, '@number',             { link = 'Number' })
hl(0, '@boolean',            { link = 'Boolean' })
hl(0, '@variable',           { fg = colors.fg })
hl(0, '@variable.builtin',   { fg = colors.orange, italic = true })
hl(0, '@function',           { link = 'Function' })
hl(0, '@function.builtin',   { fg = colors.yellow, italic = true })
hl(0, '@type',               { link = 'Type' })
hl(0, '@type.builtin',       { fg = colors.magenta, italic = true })
hl(0, '@keyword',            { fg = colors.red })
hl(0, '@keyword.return',     { fg = colors.red, bold = true })
hl(0, '@operator',           { link = 'Operator' })
hl(0, '@punctuation',        { fg = colors.fg })

hl(0, 'NvimTreeNormal',       { fg = colors.fg, bg = colors.bg })
hl(0, 'NvimTreeFolderName',   { fg = colors.blue })
hl(0, 'NvimTreeCursorLine',   { bg = colors.one_bg3 })
hl(0, 'BufferLineSelected',   { bg = colors.bg, underline = true, sp = colors.fg })
hl(0, 'BufferLineFill',       { bg = colors.bg })

vim.g.terminal_color_0  = colors.black
vim.g.terminal_color_1  = colors.red
vim.g.terminal_color_2  = colors.green
vim.g.terminal_color_3  = colors.yellow
vim.g.terminal_color_4  = colors.blue
vim.g.terminal_color_5  = colors.magenta
vim.g.terminal_color_6  = colors.cyan
vim.g.terminal_color_7  = colors.white
vim.g.terminal_color_8  = colors.one_bg3
vim.g.terminal_color_9  = colors.red
vim.g.terminal_color_10 = colors.green
vim.g.terminal_color_11 = colors.yellow
vim.g.terminal_color_12 = colors.nord_blue
vim.g.terminal_color_13 = colors.magenta
vim.g.terminal_color_14 = colors.cyan
vim.g.terminal_color_15 = colors.fg
