local fn = vim.fn

-- Return require for use in 'config' parameter of packer's use
local function get_config(name)
    return string.format('require("config/%s")', name)
end

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
end

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icon
        },
        tag = "nightly", -- optional, updated every week
        config = get_config("nvim-tree")
    }

    use {
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
        config = get_config("telescope")
    }

    -- Highlighting
    use {
        "nvim-treesitter/nvim-treesitter",
        requires = {
            "nvim-treesitter/nvim-treesitter-refactor",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = get_config("treesitter"),
        run = ":TSUpdate",
    }

    -- [[ Theme ]]
    use { "mhinz/vim-startify" } -- start screen
    use { "Mofiqul/dracula.nvim" } -- colorscheme
    use {
        "nvim-lualine/lualine.nvim", -- statusline
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = get_config("lualine"),
    }

    -- Comment out
    -- gcc : comment out one line
    -- gc{Motion} : comment out {Motion}
    -- :Commentary  : ex command
    use { "tpope/vim-commentary" }

    -- Surround
    use { "tpope/vim-surround" }

    use { "tpope/vim-repeat" }

    -- Terminal
    use { "akinsho/toggleterm.nvim",
        tag = "v2.*",
        config = get_config("toggleterm")
    }

    -- cmp plugins
    -- The completion plugin
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer", -- buffer completions
            "hrsh7th/cmp-path", -- path completions
            "saadparwaiz1/cmp_luasnip", -- snippet completions
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
        },
        config = get_config("cmp"),
    }

    -- LSP
    -- simple to use language server installer
    use { "williamboman/mason.nvim" }
    use { "williamboman/mason-lspconfig.nvim" }
    -- Enable lspconfig
    use { "neovim/nvim-lspconfig" }
    use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
    use {
        "RRethy/vim-illuminate",
        config = get_config("illuminate")
    }

    -- DAP
    use {
        "mfussenegger/nvim-dap",
        requires = {
            "rcarriga/nvim-dap-ui",
            "ravenxrz/DAPInstall.nvim",
        },
        config = get_config("dap"),
    }

    -- Java
    use { "mfussenegger/nvim-jdtls" }


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
