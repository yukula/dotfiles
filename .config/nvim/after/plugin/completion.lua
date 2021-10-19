vim.o.completeopt = "menu,menuone,noselect"

local cmp = require'cmp'


cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp', priority = 10 },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
  mapping = {
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),

    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),

    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  },
  formatting = {
    format = require'lspkind'.cmp_format({with_text = true, max_width = 50}),
  },

  experimental = {
    ghost_text = true,
  },
})
