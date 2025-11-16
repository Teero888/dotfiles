-- ~/.config/nvim/colors/greyhome.lua
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "greyhome"

local hi = function(name, val)
	vim.api.nvim_set_hl(0, name, val)
end

local c = {
	bg = "#1a1a1a", -- Netrw background
	bg_alt = "#222222", -- statusline, pmenu
	bg_light = "#2a2a2a", -- cursorline
	fg = "#c0c0c0", -- main text
	fg_dim = "#888888", -- comments, line numbers
	fg_bright = "#e0e0e0", -- bright text

	grey1 = "#404040",
	grey2 = "#606060",
	grey3 = "#808080",
	grey4 = "#a0a0a0",
	grey5 = "#c0c0c0",

	cursor = "#505050",
	visual = "#404040",
	search = "#505050",
	incsearch = "#606060",
}

-- === ACCENTS ===
local a = {
	teal = "#88c0c0", -- keywords, types
	purple = "#b0a0d0", -- functions
	green = "#a0c0a0", -- strings
	blue = "#a0b0d0", -- constants, numbers
	orange = "#d0b090", -- special (optional)
}

-- === EDITOR ===
hi("Normal", { fg = c.fg, bg = c.bg })
hi("Visual", { bg = c.visual })
hi("Cursor", { fg = c.bg, bg = c.fg_bright })
hi("CursorLine", { bg = c.bg_light })
hi("CursorLineNr", { fg = c.fg_bright, bg = c.bg_light, bold = true })
hi("LineNr", { fg = c.fg_dim })
hi("SignColumn", { bg = c.bg })
hi("ColorColumn", { bg = c.grey1 })
hi("Conceal", { fg = c.fg_dim })

-- === SYNTAX ===
hi("Comment", { fg = c.fg_dim, italic = true })

hi("Constant", { fg = a.blue })
hi("String", { fg = a.green })
hi("Character", { fg = a.green })
hi("Number", { fg = a.blue })
hi("Boolean", { fg = a.blue, bold = true })
hi("Float", { fg = a.blue })

hi("Identifier", { fg = c.fg })
hi("Function", { fg = a.purple, bold = true })

hi("Statement", { fg = a.teal })
hi("Conditional", { fg = a.teal })
hi("Repeat", { fg = a.teal })
hi("Label", { fg = a.teal })
hi("Operator", { fg = c.fg })
hi("Keyword", { fg = a.teal, italic = true })
hi("Exception", { fg = a.orange })

hi("PreProc", { fg = a.orange })
hi("Include", { fg = a.orange })
hi("Define", { fg = a.orange })
hi("Macro", { fg = a.orange })

hi("Type", { fg = a.teal, italic = true })
hi("StorageClass", { fg = a.teal })
hi("Structure", { fg = a.teal })
hi("Typedef", { fg = a.teal })

hi("Special", { fg = a.orange })
hi("SpecialChar", { fg = a.orange })
hi("Tag", { fg = a.teal })
hi("Delimiter", { fg = c.fg })
hi("SpecialComment", { fg = c.fg_dim, bold = true })
hi("Debug", { fg = a.orange })

hi("Underlined", { fg = a.blue, underline = true })
hi("Error", { fg = c.fg, bg = c.grey1, bold = true })
hi("Todo", { fg = c.bg, bg = c.fg_dim, bold = true })

-- === TREESITTER ===
hi("@comment", { link = "Comment" })
hi("@variable", { fg = c.fg })
hi("@variable.builtin", { fg = a.teal, italic = true })
hi("@property", { fg = c.fg })
hi("@parameter", { fg = c.fg })

hi("@function", { link = "Function" })
hi("@function.builtin", { fg = a.purple, bold = true })
hi("@function.macro", { fg = a.orange })
hi("@method", { link = "Function" })

hi("@keyword", { fg = a.teal, italic = true })
hi("@keyword.function", { fg = a.teal, bold = true })
hi("@keyword.operator", { fg = a.teal })
hi("@operator", { fg = c.fg })

hi("@type", { link = "Type" })
hi("@type.builtin", { fg = a.teal, italic = true })
hi("@constructor", { fg = a.purple })

hi("@string", { link = "String" })
hi("@string.escape", { fg = a.orange })
hi("@number", { link = "Number" })
hi("@boolean", { link = "Boolean" })

hi("@constant", { fg = a.blue, bold = true })
hi("@constant.builtin", { fg = a.blue, bold = true })

hi("@punctuation.bracket", { fg = c.grey3 })
hi("@punctuation.delimiter", { fg = c.fg })

hi("@tag", { fg = a.teal })
hi("@tag.attribute", { fg = a.orange })

-- === LSP ===
hi("DiagnosticError", { fg = a.orange })
hi("DiagnosticWarn", { fg = a.blue })
hi("DiagnosticInfo", { fg = a.teal })
hi("DiagnosticHint", { fg = c.fg_dim })

hi("DiagnosticUnderlineError", { undercurl = true, sp = a.orange })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = a.blue })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = a.teal })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = c.fg_dim })

-- === UI ===
hi("Pmenu", { fg = c.fg, bg = c.bg_alt })
hi("PmenuSel", { fg = c.bg, bg = a.teal })
hi("PmenuSbar", { bg = c.bg_alt })
hi("PmenuThumb", { bg = c.grey2 })

hi("StatusLine", { fg = c.fg, bg = c.bg_alt })
hi("StatusLineNC", { fg = c.fg_dim, bg = c.bg_alt })
hi("WinSeparator", { fg = c.grey1, bg = c.bg })

hi("Search", { fg = c.bg, bg = c.search })
hi("IncSearch", { fg = c.bg, bg = c.incsearch })

hi("Directory", { fg = a.teal, bold = true })
hi("Title", { fg = c.fg_bright, bold = true })

-- === NETRW ===
hi("netrwDir", { fg = a.teal, bold = true })
hi("netrwClassify", { fg = c.grey2 })
hi("netrwExe", { fg = a.orange })

-- === GIT ===
hi("DiffAdd", { bg = "#1a2a1a" })
hi("DiffChange", { bg = "#2a2a1a" })
hi("DiffDelete", { bg = "#2a1a1a", fg = c.fg_dim })

hi("GitSignsAdd", { fg = a.green, bg = c.bg })
hi("GitSignsChange", { fg = a.blue, bg = c.bg })
hi("GitSignsDelete", { fg = a.orange, bg = c.bg })

-- === FINAL TOUCHES ===
hi("MatchParen", { fg = a.teal, bg = c.grey1, bold = true })
hi("ErrorMsg", { fg = c.fg, bg = c.grey1, bold = true })
hi("SpellBad", { undercurl = true, sp = a.orange })
