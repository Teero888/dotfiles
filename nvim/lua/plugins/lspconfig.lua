return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		{ "folke/lazydev.nvim", ft = "lua", opts = {} },
	},
	config = function()
		require("config.lspconfig")
	end,
}
