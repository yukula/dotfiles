-- Set <space> as the leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.termguicolors = true

vim.o.mouse = ""       -- disable the mouse
vim.o.updatetime = 250 -- decrease update time for CursorHold
vim.o.fileencoding = "utf-8"

vim.opt.matchpairs:append("<:>")                 -- add "<>" to '%'
vim.o.cmdheight = 1                              -- cmdline heirequire('gitsigns.config').config.baseght
vim.o.cmdwinheight = math.floor(vim.o.lines / 2) -- 'q:' window height
vim.o.scrolloff = 3                              -- min number of lines to keep between cursor and screen edge
vim.o.textwidth = 99                             -- max inserted text width for paste operations
vim.o.number = true                              -- show absolute line nvim.o. at the cursor pos
vim.o.cursorline = false                         -- Show a line where the current cursor is
vim.o.signcolumn = "yes"                         -- Show sign column as first column
vim.o.colorcolumn = "100"                        -- mark column 100
vim.o.breakindent = true                         -- start wrapped lines indented
vim.o.linebreak = true                           -- do not break words on line wrap
vim.o.relativenumber = true                      -- otherwise, show relative numbers in the ruler
vim.opt.numberwidth = 5
_G.StatusCol = function()
    local winid = vim.g.statusline_winid or vim.api.nvim_get_current_win()
    local col = vim.api.nvim_win_get_position(winid)[2]
    local is_leftmost = (col == 0)

    local border = is_leftmost and "%#WinSeparator#█%*" or ""

    local gs = ""
    local ok, gitsigns = pcall(require, "gitsigns")
    if ok and gitsigns.statuscolumn then
        gs = gitsigns.statuscolumn()
    end

    local n = (vim.v.relnum == 0) and vim.v.lnum or vim.v.relnum
    local w = vim.o.numberwidth
    local num = string.format("%" .. w .. "d", n)
    local num_hl = (vim.v.relnum == 0) and "%#CursorLineNr#" or "%#LineNr#"

    return table.concat({
        border,
        " ",         -- <padding>
        num_hl, num, -- <line_number>
        "%*",        -- reset highlight
        " ",         -- <padding>
        gs,
        "  ",        -- at least 2 spaces before text
    })
end

vim.opt.statuscolumn = "%!v:lua.StatusCol()"
-- Characters to display on ':set list',explore glyphs using:
-- `xfd -fa "InputMonoNerdFont:style:Regular"` or
-- `xfd -fn "-misc-fixed-medium-r-semicondensed-*-13-*-*-*-*-*-iso10646-1"`
-- input special chars with the sequence <C-v-u> followed by the hex code
vim.opt.listchars = {
    tab = "▏ ",
    trail = "·",
    extends = "»",
    precedes = "«",
}
vim.o.list = true
vim.o.showbreak = "↪ "


vim.o.fillchars = "vert:█,horiz:█,horizup:█,horizdown:█,vertleft:█,vertright:█,verthoriz:█"

vim.o.laststatus = 3

-- show menu even for one item do not auto select/insert
vim.opt.completeopt = {
    "noselect",
    "menu",
    "menuone",
    "popup"
}

vim.o.pumheight = 10     -- completion menu max height

vim.o.joinspaces = true  -- insert spaces after '.?!' when joining lines
vim.o.smartindent = true -- add <tab> depending on syntax (C/C++)

vim.o.tabstop = 4        -- Tab indentation levels every two columns
vim.o.shiftwidth = 0     -- Use `tabstop` value for auto-indent
vim.o.shiftround = true  -- Always indent/outdent to nearest tabstop
vim.o.expandtab = true   -- Convert all tabs that are typed into spaces

vim.opt.formatoptions = vim.opt.formatoptions
    - "a"                 -- auto-formatting
    - "t"                 -- auto-wrap text using 'textwidth'
    + "c"                 -- auto-wrap comments using 'textwidth'
    + "q"                 -- allow formatting comments w/ `gq`
    - "o"                 -- auto-continue comments on pressing `o|O`
    + "r"                 -- auto-continue comments on pressing `enter`
    + "n"                 -- recognize 'formatlistpat' while formatting
    + "j"                 -- auto-remove comments when joining lines
    - "2"                 -- disable heuristics in paragraph formatting

vim.o.splitbelow = true   -- ':new' ':split' below current
vim.o.splitright = true   -- ':vnew' ':vsplit' right of current

vim.o.foldenable = true   -- enable folding
vim.o.foldlevelstart = 99 -- open all folds by default
vim.o.foldmethod = "expr" -- use treesitter for folding
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.o.undofile = false                   -- no undo file
vim.o.hidden = true                      -- do not unload buffer when abandoned
vim.o.confirm = true                     -- confirm before loss of data with `:q`

vim.o.ignorecase = true                  -- ignore case on search
vim.o.smartcase = true                   -- case sensitive when search includes uppercase
vim.o.showmatch = true                   -- highlight matching [{()}]
vim.o.cpoptions = vim.o.cpoptions .. "x" -- stay on search item when <esc>

vim.o.writebackup = false                -- do not backup file before write
vim.o.swapfile = false                   -- no swap file

--[[
  ShDa (viminfo for vim): session data history
  --------------------------------------------
  ! - Save and restore global variables (their names should be without lowercase letter).
  ' - Specify the maximum number of marked files remembered. It also saves the jump list and the change list.
  < - Maximum of lines saved for each register. All the lines are saved if this is not included, <0 to disable pessistent registers.
  % - Save and restore the buffer list. You can specify the maximum number of buffer stored with a number.
  / or : - Number of search patterns and entries from the command-line history saved. vim.o.history is used if it’s not specified.
  f - Store file (uppercase) marks, use 'f0' to disable.
  s - Specify the maximum size of an item’s content in KiB (kilobyte).
      For the viminfo file, it only applies to register.
      For the shada file, it applies to all items except for the buffer list and header.
  h - Disable the effect of 'hlsearch' when loading the shada file.

  :oldfiles - all files with a mark in the shada file
  :rshada   - read the shada file (:rviminfo for vim)
  :wshada   - write the shada file (:wrviminfo for vim)
]]
vim.o.shada = [[!,'100,<0,s100,h]]
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize"

-- use ':grep' to send resulsts to quickfix
-- use ':lgrep' to send resulsts to loclist
if vim.fn.executable("rg") == 1 then
    vim.o.grepprg = "rg --vimgrep --no-heading --smart-case --hidden"
    vim.o.grepformat = "%f:%l:%c:%m"
end

-- Disable providers we do not care a about
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Disable some in built plugins completely
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    -- 'matchit',
    -- 'matchparen',
}

vim.g.markdown_fenced_languages = {
    "vim",
    "lua",
    "cpp",
    "sql",
    "python",
    "bash=sh",
    "console=sh",
    "javascript",
    "typescript",
    "js=javascript",
    "ts=typescript",
    "yaml",
    "json",
}

-- OSC52 clipboard over ssh
if vim.env.SSH_TTY then
    vim.g.clipboard = {
        name = "OSC 52",
        copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
            ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
        },
        paste = {
            ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
            ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
        },
    }
end

-- default fzf plugin layout
vim.g.fzf_layout = { window = "enew" }
