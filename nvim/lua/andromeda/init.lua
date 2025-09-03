local config = require("andromeda.config")
local palette = require("andromeda.palette")

local colorscheme = {}

colorscheme.editorBackground = config.transparent and "none" or palette.background
colorscheme.mainText         = palette.foreground
colorscheme.cursor           = palette.cursor
colorscheme.commentText      = palette.color8
colorscheme.errorText        = palette.color9
colorscheme.successText      = palette.color10
colorscheme.warningText      = palette.color11
colorscheme.linkText         = palette.color12
colorscheme.stringText       = palette.color13
colorscheme.functionText     = palette.color4
colorscheme.keywordText      = palette.color1
colorscheme.operatorText     = palette.color7

vim.cmd("highlight clear")
vim.cmd("syntax reset")
vim.o.background = "dark"
vim.g.colors_name = "andromeda"

vim.api.nvim_set_hl(0, "Normal",       { fg = colorscheme.mainText, bg = colorscheme.editorBackground })
vim.api.nvim_set_hl(0, "Cursor",       { fg = colorscheme.editorBackground, bg = colorscheme.cursor })
vim.api.nvim_set_hl(0, "Comment",      { fg = colorscheme.commentText, italic = true })
vim.api.nvim_set_hl(0, "Error",        { fg = colorscheme.errorText })
vim.api.nvim_set_hl(0, "String",       { fg = colorscheme.stringText })
vim.api.nvim_set_hl(0, "Function",     { fg = colorscheme.functionText })
vim.api.nvim_set_hl(0, "Keyword",      { fg = colorscheme.keywordText })
vim.api.nvim_set_hl(0, "Operator",     { fg = colorscheme.operatorText })

return colorscheme
