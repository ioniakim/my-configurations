require 'nvim-tree'.setup{
}

-- keymaps
local map = vim.keymap.set

map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { noremap = true })
map('n', '<leader>r', '<cmd>NvimTreeRefresh<CR>', { noremap = true })
map('n', '<leader>n', '<cmd>NvimTreeFindFile<CR>', { noremap = true })

