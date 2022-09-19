--"call plug#begin()
--" Plug 'https://github.com/rafi/awesome-vim-colorschemes'
--" Plug 'preservim/nerdtree'
--" Plug 'ryanoasis/vim-devicons'
--" Plug 'mhinz/vim-startify'
--" Plug 'vim-airline/vim-airline'
--" Plug 'https://github.com/tpope/vim-commentary' " For commenting gcc & gc
--" Plug 'neovim/nvim-lspconfig'
--" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
--" Plug 'tpope/vim-surround'
--"call plug#end()


require "plugins"
require "options"
require "autocmd"
require "colorscheme"
-- require "win32yank"
require "config.whichkey"
require "config.dial"
require "config.nvim-tree"
require "config.lualine"
require "config.toggleterm"
require "config.cmp"
require "config.telescope"
require "config.treesitter"
require "config.autopairs"
require "config.illuminate"
require "lsp"
require "config.dap"
require "config.dap-virtual-text"
require "config.gitsigns"
require "config.git-blame"
require "config.registers"
require "keymaps"
