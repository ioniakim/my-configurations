-- Disable arrow keys
vim.keymap.set('', '<Up>', '<Nop>', { noremap = true })
vim.keymap.set('', '<Down>', '<Nop>', { noremap = true })
vim.keymap.set('', '<Left>', '<Nop>', { noremap = true })
vim.keymap.set('', '<Right>', '<Nop>', { noremap = true })
-- noremap <Up> <Nop>
-- noremap <Down> <Nop>
-- noremap <Left> <Nop>
-- noremap <Right> <Nop>


-- Buffer key mappings
vim.keymap.set('n', ':bprevious<CR>', '[b', { noremap = true, silent = true })
vim.keymap.set('n', ':bnext<CR>', ']b', { noremap = true, silent = true })
vim.keymap.set('n', ':bfirst<CR>', '[B', { noremap = true, silent = true })
vim.keymap.set('n', ':blast<CR>', ']B', { noremap = true, silent = true })
-- nnoremap <silent> [b :bprevious<CR>
-- nnoremap <silent> ]b :bnext<CR>
-- nnoremap <silent> [B :bfirst<CR>
-- nnoremap <silent> ]B :blast<CR>

