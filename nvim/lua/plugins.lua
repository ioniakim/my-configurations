vim.cmd [[packadd packer.nvim]]

vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        tag = 'nightly'  -- optional, updated every week
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Highlighting
    use { 
        'nvim-treesitter/nvim-treesitter', 
        requires = {
          'nvim-treesitter/nvim-treesitter-refactor',
          'RRethy/nvim-treesitter-textsubjects',
        },
        run = ':TSUpdate'
    }

    -- [[ Theme ]]
    use { 'mhinz/vim-startify' }                    -- start screen
    use { 'Mofiqul/dracula.nvim'}                   -- colorscheme
    use {
        'nvim-lualine/lualine.nvim',                 -- statusline
        requires = { 'kyazdani42/nvim-web-devicons', 
        opt = true}
    }

end)
