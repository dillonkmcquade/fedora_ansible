vim.cmd.packadd('packer.nvim')
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-fugitive'
    use 'rmehri01/onenord.nvim'
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use 'mbbill/undotree'
    use 'alvan/vim-closetag'
    use 'jiangmiao/auto-pairs'
    use 'luochen1990/rainbow'
    use 'tpope/vim-surround'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            {
                'hrsh7th/nvim-cmp',
                config = function()
                    require 'cmp'.setup {
                        snippet = {
                            expand = function(args)
                                require 'luasnip'.lsp_expand(args.body)
                            end
                        },

                        sources = {
                            { name = 'luasnip' },
                        },
                    }
                end
            },                          -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }
    use { 'saadparwaiz1/cmp_luasnip' }
    use 'rafamadriz/friendly-snippets'
    if packer_bootstrap then
        require('packer').sync()
    end
end)
