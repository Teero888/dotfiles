local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.loop.fs_stat(lazypath)) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.dap"),
	require("plugins.transparent"),
	require("plugins.comment"),
	require("plugins.gitsigns"),
	require("plugins.telescope"),
	require("plugins.lspconfig"),
	require("plugins.conform"),
	require("plugins.cmp"),
	require("plugins.mini"),
	require("plugins.treesitter"),
	require("plugins.perfanno"),
	require("plugins.todo-comments"),
	"sindrets/diffview.nvim",
})
