local lsp = require('lspconfig')
vim.lsp.set_log_level("debug")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   -- Enable underline, use default values
   underline = true,
   -- Enable virtual text, override spacing to 4
   virtual_text = false,
   -- Disable a feature
   update_in_insert = false,
 }
 )
 vim.fn.sign_define("LspDiagnosticsSignError", {text = '', texthl = 'Error', numhl = ''})

 local executable = function(fname)
   return vim.fn.executable(fname) == 1
 end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- lua
local lua_ls_binary = '/usr/bin/lua-language-server' --{{{
local lua_ls_main = '/usr/share/lua-language-server/main.lua'
local lua_ls_runtime_path = vim.split(package.path, ';')
table.insert(lua_ls_runtime_path, "lua/?.lua")
table.insert(lua_ls_runtime_path, "lua/?/init.lua")
lsp.sumneko_lua.setup {
  cmd = {lua_ls_binary, "-E", lua_ls_main},
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = lua_ls_runtime_path,
      };
      diagnostics = {
        globals = {'vim'},
      };
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
} --}}}

-- c++
if executable('ccls') then--{{{
  lsp.ccls.setup {
    capabilities = capabilities,
    init_options = {
    --  compilationDatabaseDirectory = "",
      index = {
    threads = 2,
      },
    },
  }
elseif executable('clangd') then
  lsp.clangd.setup {
    capabilities = capabilities,
  }
end--}}}


-- lsp bindings
vim.api.nvim_set_keymap("i", "<c-space>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {noremap = true})--{{{
vim.api.nvim_set_keymap("n", "<leader>K", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>sd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})<CR>", {noremap = true})

vim.api.nvim_set_keymap("n", "<space>rr", "<cmd>LspRestart<CR>", {noremap = true})--}}}

-- vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", {noremap = true})


-- vim.api.nvim_set_keymap("n", "<space>dn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<space>dp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<space>sl", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", {noremap = true})

