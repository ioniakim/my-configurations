require 'nvim-tree'.setup{
}

-- keymaps
local map = vim.keymap.set

map('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true })
map('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true })
map('n', '<leader>n', ':NvimTreeFindFile<CR>', { noremap = true })

