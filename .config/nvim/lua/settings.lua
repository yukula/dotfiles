vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.conceallevel = 2

vim.o.completeopt = 'menuone,noselect,noinsert'
vim.o.pumheight = 15

vim.o.clipboard = 'unnamedplus'

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

vim.o.mouse = 'a'
vim.o.mousescroll = 'ver:3,hor:0'


vim.o.linebreak = true

vim.o.foldcolumn = '1'
vim.o.foldlevelstart = 99
vim.wo.foldtext = ''

vim.o.winborder = 'none'

vim.opt.shortmess:append {
    w = true,
    s = ture,
}

vim.o.laststatus = 3
vim.o.cmdheight = 1


vim.diagnostic.config({
    virtual_lines = {
        severity = { min = vim.diagnostic.severity.ERROR }
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✗",
            [vim.diagnostic.severity.WARN]  = "▲",
            [vim.diagnostic.severity.INFO]  = "∙",
            [vim.diagnostic.severity.HINT]  = "∴"
        },
        severity = { min = vim.diagnostic.severity.INFO }
    },

    severity_sort = true
})
