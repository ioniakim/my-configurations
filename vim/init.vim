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
require 'my-setting'
require 'win32yank'
--require 'colorscheme'
require 'keymap'
require 'nerdtree-config'
-- require 'nvim-treesitter.configs'.setup {
--   highlight = {
--     enable = true,              -- false will disable the whole extension
--     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--     -- Using this option may slow down your editor, and you may see some duplicate highlights.
--     -- Instead of true it can also be a list of languages
--     additional_vim_regex_highlighting = false,
--   },
--
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       init_selection = "gnn",
--       node_incremental = "grn",
--       scope_incremental = "grc",
--       node_decremental = "grm",
--     },
--   },
--
--   indent = {
--     enable = true
--   }
-- }

EOF

