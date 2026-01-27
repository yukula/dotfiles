local utils = require('utils')

-- LSP icons
local icons = {
    Text          = "󰊄", -- 
    Method        = "󰊕",
    Function      = "",
    Constructor   = "", -- 
    Field         = "", -- 󰆧 
    Variable      = "󰆧", -- 󰆧  󰈜
    Class         = "󰌗", --   󰠱  
    Interface     = "", --  󰜰
    Module        = "󰅩",
    Property      = "",
    Unit          = "󰜫", -- 󰆧      󰑭
    Value         = "󰎠",
    Enum          = "󰘨", -- 󰘨   󰕘
    EnumMember    = "",
    Keyword       = "󰌆", -- 󰌋
    Snippet       = "󰘍", --󰅱 󰈙
    Color         = "󰏘", -- 󰌁 󰏘 
    File          = "",
    Folder        = "",
    Reference     = "󰆑", -- 󰀾 󰈇
    Constant      = "󰏿", -- 󰝅 󰔆    󰐀 󰏿 π
    Struct        = "󰙅", -- 
    Event         = "",
    Operator      = "󰒕", -- 󰆕
    TypeParameter = "",
}

for kind, symbol in pairs(icons) do
    local kinds = vim.lsp.protocol.CompletionItemKind
    local index = kinds[kind]

    if index ~= nil then
        kinds[index] = symbol
    end
end


vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Configure LSP keymaps',
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local map = vim.keymap.set

        map('n', ']d', function() vim.diagnostic.jump({ count = -1 }) end, { desc = 'Previous Diagnostic' })

        map('n', '[d', function()
            vim.diagnostic.jump({ count = 1 })
        end, { desc = 'Previous Diagnostic' })

        require('fidget').setup {}
    end
})


vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities(nil, true) })

local RETURN_ALL_MATCHES = true;
local configs = utils.map(vim.api.nvim_get_runtime_file('lsp/*.lua', RETURN_ALL_MATCHES),
    function(path)
        return vim.fn.fnamemodify(path, ':t:r')
    end)
vim.lsp.enable(configs)
