local map = vim.keymap.set

-- Disable arrow keys
map('', '<Up>', '<Nop>', { noremap = true })
map('', '<Down>', '<Nop>', { noremap = true })
map('', '<Left>', '<Nop>', { noremap = true })
map('', '<Right>', '<Nop>', { noremap = true })
-- noremap <Up> <Nop>
-- noremap <Down> <Nop>
-- noremap <Left> <Nop>
-- noremap <Right> <Nop>


-- Buffer key mappings
map('n', ':bprevious<CR>', '[b', { noremap = true, silent = true })
map('n', ':bnext<CR>', ']b', { noremap = true, silent = true })
map('n', ':bfirst<CR>', '[B', { noremap = true, silent = true })
map('n', ':blast<CR>', ']B', { noremap = true, silent = true })
-- nnoremap <silent> [b :bprevious<CR>
-- nnoremap <silent> ]b :bnext<CR>
-- nnoremap <silent> [B :bfirst<CR>
-- nnoremap <silent> ]B :blast<CR>

