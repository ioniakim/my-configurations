local set = vim.opt

-- general
set.compatible = false
set.showmatch = true
set.mouse = 'a'
set.number = true
set.relativenumber = true
set.wildmode = 'full'
set.wildmenu = true
set.cc = '120'
vim.cmd('syntax on')
set.clipboard:append('unnamedplus')
set.cursorline = true
set.encoding = 'utf-8'
set.hidden = true
set.swapfile = false

-- search
set.ignorecase = true
set.smartcase = true
set.hlsearch = true
set.incsearch = true

-- indentation
vim.cmd('filetype plugin indent on')
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true
set.autoindent = true

-- window
set.splitbelow = true
set.splitright = true


-- mischellaneous
vim.cmd('runtime macros/matchit.vim')


