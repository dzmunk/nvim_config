-- statusline.lua
vim.o.statusline = '%f %y %m %= %p%% %l:%c'

-- Tabline configuration
vim.o.showtabline = 2  -- Always show tabline
vim.o.tabline = '%!v:lua.Tabline()'

function Tabline()
  local s = ''
  for i = 1, vim.fn.tabpagenr('$') do
    local winnr = vim.fn.tabpagewinnr(i)
    local buflist = vim.fn.tabpagebuflist(i)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.bufname(bufnr)
    local label = vim.fn.fnamemodify(bufname, ':t')
    if label == '' then
      label = '[No Name]'
    end
    s = s .. '%' .. i .. 'T'
    if i == vim.fn.tabpagenr() then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end
    s = s .. ' ' .. label .. ' '
  end
  s = s .. '%#TabLineFill#'
  return s
end
