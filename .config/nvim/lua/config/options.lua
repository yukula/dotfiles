vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.clipboard = "unnamedplus"

vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.undofile = true
opt.showmode = false
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.autoindent = true
opt.smartindent = true
opt.hlsearch = true
opt.backup = false
opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 2
opt.expandtab = true
opt.scrolloff = 10
opt.shell = "fish"
opt.inccommand = "split"
opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
opt.smarttab = true
opt.breakindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.wrap = false -- No Wrap lines
opt.backspace = { "start", "eol", "indent" }
opt.path:append({ "**" }) -- Finding files - Search down into subfolders
opt.wildignore:append({ "*/node_modules/*" })
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.splitkeep = "cursor"
