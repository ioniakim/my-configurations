noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set smartcase               " override the ignorecase option if searching for capital letter.
set mouse=a                 " middle-click paste with mouse
set hlsearch                " highlight search results
set incsearch               " incremental search
set number                  " add line numbers
set relativenumber          " show the line number relative to the current line
" set wildmode=longest,list   " get bash-like tab completions
set wildmode=full           " get zsh-like tab completions
set wildmenu                " Enhanced completion in command-line mode
set cc=120                  " set an 120 column border for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " Syntax highlighting
set tabstop=4               " number of columns occupied by a tab character
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set autoindent              " indent a new line the same amount as the line just typed
set clipboard+=unnamedplus   " using system clipboard
set cursorline              " underline the line on which the cursor is
set encoding=utf-8          " use utf-8
" set autochdir
set hidden
set splitbelow
set splitright
set noswapfile
runtime macros/matchit.vim



call plug#begin()
" Plug 'dracula/vim'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'https://github.com/tpope/vim-commentary' " For commenting gcc & gc
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-surround'
call plug#end()

" buffer key mappings
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>


" color shcemes
if (has("termguicolors")) " check true colors support
    set termguicolors     " enable true colors support
endif
syntax enable
" colorscheme enening
colorscheme afterglow

""" NERDTree
"" The below key maps are conflict to autocompletion keys
" nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
" nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p

" Start NERDTree when Vim is started without file arguments
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Start NERDTree. If a file is specified, move the cursor to its window.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Exit vim if NERDTree is the only window remaining in the only tab
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && 
    \ b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and
" bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+'
    \ && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" |
    \ execute 'buffer'.buf | endif

" Clipboard with win32yank.exe
let g:clipboard = {
        \ 'name': 'win32yank-wsl',
        \ 'copy': {
        \       '+': 'win32yank.exe -i --crlf',
        \       '*': 'win32yank.exe -i --crlf',
        \ },
        \ 'paste': {
        \       '+': 'win32yank.exe -o --lf',
        \       '*': 'win32yank.exe -o --lf',
        \ },
        \ 'cache_enabled': 0,
        \}

" nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  indent = {
    enable = true
  }
}
EOF
