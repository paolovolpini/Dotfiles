local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'})
Plug('nvim-lua/plenary.nvim')
Plug('catppuccin/nvim', { ['as'] = 'catppuccin' })
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-tree/nvim-tree.lua')
Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && npx --yes yarn install'})
Plug('HakonHarnes/img-clip.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('lervag/vimtex')
Plug('Mofiqul/dracula.nvim')
vim.call('plug#end')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("img-clip").setup( {
	default = {
		dir_path = function()
			return vim.fn.expand("%:p:h") .. "/!Images/" .. vim.fn.expand("%:t:r")
		end,
		extension = "png",
		file_name = "%Y-%m-%d-%H-%M-%S",
	},
})

require("telescope").setup()
vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').find_files, { desc = "Telescope find files" })
vim.keymap.set('n', '<leader>c', require('telescope.builtin').commands, { desc = "Telescope commands" })
vim.keymap.set('n', '<leader>l', ':buffer #<cr>', { desc = "Open last opened file" }) 
vim.keymap.set('n', '<leader>mp', ':MarkdownPreview <cr>', { desc = "Open Markdown Preview" })
vim.keymap.set('n', '<leader>h', ':NvimTreeToggle<cr>', { desc = "Hides NvimTree"})
require("lualine").setup( {
	options = {
		theme = "dracula-nvim",
	},
})

require("nvim-tree").setup( {
	update_focused_file = {
 		 enable = true,
	},	
})

require("nvim-treesitter.configs").setup( {
	highlight = {
		enable = true,
	},
})
require("dracula").setup({
	transparent_bg = true,
})



vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.cmd([[colorscheme dracula]])
vim.cmd([[NvimTreeOpen]])
