local keymap = vim.keymap.set


-- Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "

-- Disable arrow keys
keymap("", "<Up>", "<Nop>", { noremap = true })
keymap("", "<Down>", "<Nop>", { noremap = true })
keymap("", "<Left>", "<Nop>", { noremap = true })
keymap("", "<Right>", "<Nop>", { noremap = true })
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

-- Buffer key mappings
keymap("n", "[b", "<cmd>bprevious<CR>", { noremap = true, silent = true})
keymap("n", "]b", "<cmd>bnext<CR>", { noremap = true, silent = true })
keymap("n", "[B", "<cmd>bfirst<CR>", { noremap = true, silent = true })
keymap("n", "]B", "<cmd>blast<CR>", { noremap = true, silent = true })
-- nnoremap <silent> [b :bprevious<CR>
-- nnoremap <silent> ]b :bnext<CR>
-- nnoremap <silent> [B :bfirst<CR>
-- nnoremap <silent> ]B :blast<CR>

-- Telescope
-- Find files using Telescope command-line suger
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true })


-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
