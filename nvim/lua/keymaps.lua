local keymap = vim.keymap.set



-- Remap space as leader key
local noopts = { noremap = true }
keymap("", "<Space>", "<Nop>", noopts)
vim.g.mapleader = " "

-- Disable arrow keys
keymap("", "<Up>", "<Nop>", noopts)
keymap("", "<Down>", "<Nop>", noopts)
keymap("", "<Left>", "<Nop>", noopts)
keymap("", "<Right>", "<Nop>", noopts)
-- noremap <Up> <Nop>
-- noremap <Down> <Nop>
-- noremap <Left> <Nop>
-- noremap <Right> <Nop>

-- Window
local opts = { silent = true }
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- Resize with arrows
keymap("n", "<C-Up>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)


-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
