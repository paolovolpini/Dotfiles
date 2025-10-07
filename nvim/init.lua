local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'})
Plug('nvim-lua/plenary.nvim')
Plug('catppuccin/nvim', { ['as'] = 'catppuccin' })
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-tree/nvim-tree.lua')
Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && npx --yes yarn install'})
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/vim-vsnip')
Plug('hrsh7th/nvim-cmp')
Plug('HakonHarnes/img-clip.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('lervag/vimtex')
Plug('Mofiqul/dracula.nvim')
Plug('ray-x/lsp_signature.nvim')
Plug('EdenEast/nightfox.nvim')
Plug('sainnhe/everforest')
Plug('ellisonleao/gruvbox.nvim')
Plug('shaunsingh/nord.nvim')
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

require("lsp_signature").setup()
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


-- Load nvim-cmp
local cmp = require('cmp')

cmp.setup({
	snippet = {
    	expand = function(args)
    		vim.fn["vsnip#anonymous"](args.body)  -- For vim-vsnip
    	end,
  	},
  	mapping = cmp.mapping.preset.insert({
    	['<C-Space>'] = cmp.mapping.complete(),
    	['<CR>'] = cmp.mapping.confirm({ select = true }),
    	['<Tab>'] = cmp.mapping.select_next_item(),
    	['<S-Tab>'] = cmp.mapping.select_prev_item(),
  	}),
  	sources = cmp.config.sources({
    	{ name = 'nvim_lsp' },
    	{ name = 'vsnip' },
  	}, {
    	{ name = 'buffer' },
    	{ name = 'path' },
  	})
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['ccls'].setup {
  capabilities = capabilities,
}

require('lspconfig')['pyright'].setup{
}

require('lspconfig')['gopls'].setup{
}

require("nightfox").setup({
	options = {
		transparent = true,
	},
})
require("dracula").setup({
	transparent_bg = true,
})
vim.g.nord_disable_background = true
vim.g.everforest_background = 'hard'
vim.g.everforest_transparent_background = 2

require("gruvbox").setup({
	transparent_mode = true,
})

require("config.colorscheme")

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})
vim.lsp.enable('ccls')
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.cmd([[ NvimTreeOpen ]])
