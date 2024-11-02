---- statusline.lua
--vim.o.statusline = '%f %y %m %= %p%% %l:%c'
--
---- Tabline configuration
--vim.o.showtabline = 2  -- Always show tabline
--vim.o.tabline = '%!v:lua.Tabline()'
--
--function Tabline()
--  local s = ''
--  for i = 1, vim.fn.tabpagenr('$') do
--    local winnr = vim.fn.tabpagewinnr(i)
--    local buflist = vim.fn.tabpagebuflist(i)
--    local bufnr = buflist[winnr]
--    local bufname = vim.fn.bufname(bufnr)
--    local label = vim.fn.fnamemodify(bufname, ':t')
--    if label == '' then
--      label = '[No Name]'
--    end
--    s = s .. '%' .. i .. 'T'
--    if i == vim.fn.tabpagenr() then
--      s = s .. '%#TabLineSel#'
--    else
--      s = s .. '%#TabLine#'
--    end
--    s = s .. ' ' .. label .. ' '
--  end
--  s = s .. '%#TabLineFill#'
--  return s
--end

local M = {}

function M.statusline()
    local mode_color = {
        n = '%#StatusLineModeNormal#',
        i = '%#StatusLineModeInsert#',
        v = '%#StatusLineModeVisual#',
        V = '%#StatusLineModeVisual#',
        c = '%#StatusLineModeCommand#',
        no = '%#StatusLineModeNormal#',
        s = '%#StatusLineModeSelect#',
        S = '%#StatusLineModeSelect#',
        ic = '%#StatusLineModeInsert#',
        R = '%#StatusLineModeReplace#',
        Rv = '%#StatusLineModeReplace#',
    }

    local mode = mode_color[vim.fn.mode()] or '%#StatusLine#'

    -- Get the filename and file icon
    local filename = vim.fn.expand('%:t') ~= '' and vim.fn.expand('%:t') or '[No Name]'
    local filetype = vim.bo.filetype

    -- Get diagnostics
    local diagnostics = ''
    local error = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warn = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if #error > 0 then diagnostics = diagnostics .. '%#DiagnosticError# E:' .. #error end
    if #warn > 0 then diagnostics = diagnostics .. '%#DiagnosticWarn# W:' .. #warn end

    return table.concat({
        mode,
        ' ', filename,  -- Filename
        diagnostics,  -- Diagnostics
        '%=',  -- Align to right
        '[', filetype, ']',  -- Filetype indicator
        '%#StatusLine#'
    })
end

function M.setup()
    vim.opt.statusline = "%!v:lua.require'config.statusline'.statusline()"
end

return M

