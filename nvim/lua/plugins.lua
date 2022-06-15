-- Return require for use in 'config' parameter of packer's use
local function get_config(name)
    return string.format('require("config/%s")', name)
end

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
        tag = 'nightly',  -- optional, updated every week
        config = get_config('nvim-tree')
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = get_config('telescope')
    }

    -- Highlighting
    use { 
        'nvim-treesitter/nvim-treesitter', 
        requires = {
          'nvim-treesitter/nvim-treesitter-refactor',
          'RRethy/nvim-treesitter-textsubjects',
        },
        config = get_config('treesitter'),
        run = ':TSUpdate',
    }

    -- [[ Theme ]]
    use { 'mhinz/vim-startify' }                    -- start screen
    use { 'Mofiqul/dracula.nvim'}                   -- colorscheme
    use {
        'nvim-lualine/lualine.nvim',                 -- statusline
        requires = { 'kyazdani42/nvim-web-devicons', opt = true},
        config = get_config('lualine'),
    }

end)
