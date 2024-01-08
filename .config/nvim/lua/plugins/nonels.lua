return {
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"jay-babu/mason-null-ls.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "stylua" },
			})

			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
				},
			})
		end,
	},
}
