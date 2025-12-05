vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

map('n', '<C-h>', '<C-w>h', { remap = true })
map('n', '<C-j>', '<C-w>j', { remap = true })
map('n', '<C-k>', '<C-w>k', { remap = true })
map('n', '<C-l>', '<C-w>l', { remap = true })

map('i', '<Tab>', function()
    return vim.fn.pumvisible() == 1 and '<Down>' or '<Tab>'
end, { expr = true, desc = 'Next completion or tab' })

map('i', '<S-Tab>', function()
    return vim.fn.pumvisible() == 1 and '<Up>' or '<S-Tab>'
end, { expr = true, desc = 'Previous completion or shift-tab' })

map('i', '<C-Space>', function()
    if vim.fn.pumvisible() == 1 then
        return ''
    end
    return '<C-n>'
end, { expr = true, desc = 'Trigger completion menu' })

map({ 'i', 'v', 'n' }, '<esc>', function()
    if vim.v.hlsearch == 1 then
        vim.cmd('noh')
    end
    return '<esc>'
end, { expr = true, desc = 'Escape and clear highlights' })
