return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			      "mason.nvim",
			      "williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require'lspconfig'.lua_ls.setup{}
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				-- "flake8",
			},
		},
	},

}
