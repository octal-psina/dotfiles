return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
    -- There'are some of your pluggins down there
    -- Colorscheam
	use "rebelot/kanagawa.nvim"
    use "folke/tokyonight.nvim"
	use { "bluz71/vim-nightfly-colors", as = "nightfly" }
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'Mofiqul/dracula.nvim'
    -- Nvim tree
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional
		},
		config = function()
			require("nvim-tree").setup {}
		end
	}
      -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
            end,
    }
    --- Lsp
    use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'
	use 'neovim/nvim-lspconfig'
    -- Autocmplite  
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    -- Autocmplite snipets
    use { 'saadparwaiz1/cmp_luasnip' }
    use({
	    "L3MON4D3/LuaSnip",
	    -- follow latest release.
	    tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	    -- install jsregexp (optional!:).
	    run = "make install_jsregexp"
    })
    --autoclose brackets
    use {
	    "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    -- Lualine 
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
        }
    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    --colorizer
	use {
		'NvChad/nvim-colorizer.lua',
		config = function()
			require("colorizer").setup {}
		end
	}
    use {
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
    }
end)
