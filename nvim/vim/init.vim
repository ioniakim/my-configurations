"call plug#begin()
" Plug 'https://github.com/rafi/awesome-vim-colorschemes'
" Plug 'preservim/nerdtree'
" Plug 'ryanoasis/vim-devicons'
" Plug 'mhinz/vim-startify'
" Plug 'vim-airline/vim-airline'
" Plug 'https://github.com/tpope/vim-commentary' " For commenting gcc & gc
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'tpope/vim-surround'
"call plug#end()


" lua settings
lua <<EOF
require 'plugins'
require 'my-setting'
require 'win32yank'
require 'colorscheme'
require 'basic-keymap'
require 'treesitter-config'
require 'nvim-tree-setup'
require 'lualine-setup'
require 'telescope-setup'
EOF

