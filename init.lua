-- init.lua

-- Set up Lazy.nvim path and load it first
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable", -- latest stable release
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load general configurations
require('options')
require('keymaps')
require('theme')
require('statusline')

-- Load plugins
require('plugins.lazy')
