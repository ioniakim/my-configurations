local fn = vim.fn

-- Return require for use in 'config' parameter of packer's use
-- local function get_config(name)
--     return string.format('require("config/%s")', name)
-- end

-- Packer.nvim Bootstrapping
-- Automatically install and set up packer.nvim on any machine you clone your configuration to
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth", "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path })
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

return packer.startup(function(use)
    use { "wbthomason/packer.nvim" } -- Have packer manage itself
    use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins

    -- Comment out
    -- gcc : comment out one line
    -- gc{Motion} : comment out {Motion}
    -- :Commentary  : ex command
    use { "tpope/vim-commentary" }

    -- Surround
    use { "tpope/vim-surround" }

    use { "tpope/vim-repeat" }

    use { "folke/which-key.nvim" }

    use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter

    use { "kyazdani42/nvim-web-devicons" } -- optional, for file icon

    use {
        "kyazdani42/nvim-tree.lua",
        tag = "nightly", -- optional, updated every week
    }

    use { "nvim-lualine/lualine.nvim" } -- statusline 
    -- Terminal
    use { "akinsho/toggleterm.nvim", tag = "v2.*" }

    -- [[ Theme ]]
    -- use { "mhinz/vim-startify" } -- start screen
    use { "goolord/alpha-nvim",
        config = function ()
            require"alpha".setup(require"alpha.themes.theta".config)
        end
    }
    use { "Mofiqul/dracula.nvim" } -- colorscheme
    use { "lunarvim/darkplus.nvim", branch = "neovim-0.7" }

    -- cmp plugins
    -- The completion plugin
    use { "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-buffer" } -- buffer completions
    use { "hrsh7th/cmp-path" } -- path completions
    use { "hrsh7th/cmp-cmdline" } -- cmdline completions
    use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-nvim-lua" }

    -- snippets
    use { "L3MON4D3/LuaSnip" } --snippet engine
    use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use


    -- LSP
    -- simple to use language server installer
    use { "williamboman/mason.nvim" }
    use { "williamboman/mason-lspconfig.nvim" }
    -- Enable lspconfig
    use { "neovim/nvim-lspconfig" }
    use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
    use { "RRethy/vim-illuminate" }


    -- Telescope
    use { "nvim-telescope/telescope.nvim" }

    -- Highlighting
    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    -- use { "nvim-treesitter/nvim-treesitter-refactor" }
    use { "nvim-treesitter/nvim-treesitter-textobjects" }

    -- DAP
    use { "mfussenegger/nvim-dap" }
    use { "rcarriga/nvim-dap-ui" }
    use { "ravenxrz/DAPInstall.nvim" }

    -- Java
    use { "mfussenegger/nvim-jdtls" }


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)

