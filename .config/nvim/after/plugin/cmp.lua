vim.opt.completeopt = 'menu,menuone,noinsert'
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function (args)
      require('luasnip').lsp_expand(args.body)
    end
  },

  window = {
    -- completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  }),

  sources = {
    { name = 'async_path' },
    { name = 'nvim_lsp', keyword_length = 1 },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
  },

  experimental = {
    ghost_text = true,
  },
  
})
