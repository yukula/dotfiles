local opt = vim.opt

opt.wildignore = {'*.o', '*.a'}

opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1
opt.incsearch = true
opt.relativenumber = true
opt.number = true
opt.ignorecase = true
opt.smartcase = true
opt.hidden = true
opt.cursorline = true
opt.updatetime = 1000
opt.hlsearch = true
opt.scrolloff = 10
opt.signcolumn = "yes"
opt.colorcolumn = "120"

opt.equalalways = true
opt.splitright = true
opt.splitbelow = true


opt.autoindent = true
opt.cindent = true
opt.wrap = true

opt.tabstop = 2
opt.softtabstop = 4
opt.shiftwidth = 2
opt.expandtab = true

opt.breakindent = true
opt.showbreak = string.rep(" ", 3)
opt.linebreak = true

opt.foldmethod = "marker"
opt.foldlevel = 0
opt.modelines = 1

opt.belloff = "all"

opt.clipboard = "unnamedplus"

opt.inccommand = "split"
opt.swapfile = false
opt.shada = { "!", "'1000", "<50", "s10", "h" } -- do not completely undestand

opt.mouse = "n"

opt.joinspaces = false
