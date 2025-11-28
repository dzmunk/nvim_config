local o  = vim.o
local wo = vim.wo
local bo = vim.bo
local g  = vim.g

o.winborder = "rounded"
o.laststatus = 3
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.splitkeep = "screen"
o.winminwidth = 5
o.smoothscroll = true

wo.number = true
wo.relativenumber = false
wo.cursorline = true
wo.wrap = false
wo.linebreak = false
wo.list = true

o.mouse = "a"
o.scrolloff = 4
o.sidescrolloff = 8
o.confirm = true
o.updatetime = 500

o.ignorecase = true
o.smartcase = true
o.inccommand = "nosplit"

o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep --smart-case"

o.autocomplete = false
o.completeopt = "popup,menu,menuone,noinsert,fuzzy"
o.completefuzzycollect = "keyword,files"
o.complete = ".,w^5,b^5,o^5"
o.pumheight = 10

bo.tabstop = 4
bo.shiftwidth = 4
bo.expandtab = true
bo.smartindent = true

o.shiftround = true

o.undofile = false
o.virtualedit = "block"

g.autocompletedelay = 120
g.autocompletetimeout = 120

 --g.clipboard = "osc52"
o.clipboard = "unnamedplus"

o.jumpoptions = "view"
