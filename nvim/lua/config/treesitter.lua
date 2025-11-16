require("nvim-treesitter.configs").setup({
	ensure_installed = { "bash", "c", "cpp", "rust", "html", "javascript", "lua", "luadoc", "markdown", "vim", "vimdoc" },
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "ruby" },
	},
	indent = { enable = true, disable = { "ruby" } },
})
