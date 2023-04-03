local lsp = require('lspconfig')

local executable = function(fname)
 return vim.fn.executable(fname) == 1
end


local capabilities = require('cmp_nvim_lsp').default_capabilities()


--cmake --{{{
lsp.cmake.setup{
  capabilities = capabilities,
}
--}}}


-- lua --{{{
lsp.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = true,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  capabilities = capabilities,
  force_setup = true,
}
--}}}



-- c++
if executable('#ccls') then--{{{
  lsp.ccls.setup {
  init_options = {
    cache = {
      directory = ".ccls-cache";
    },
    highlight = { 
      lsRanges = false 
    }     
  }
}
elseif executable('clangd') then
  lsp.clangd.setup {
    capabilities = capabilities,
  }
end--}}}

-- python
lsp.pylsp.setup{}

-- lsp bindings
vim.api.nvim_set_keymap("n", "<leader>K", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rf", "<cmd>lua vim.lsp.buf.format()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>rr", "<cmd>LspRestart<CR>", {noremap = true})--}}}
