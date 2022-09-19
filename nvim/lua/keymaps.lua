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


local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end


local wk_opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use 'silent' when creating keymaps
    noremap = true, -- use 'noremap' when creating keymaps
    nowait = true, -- use 'nowait' when creating keymaps
}

local wk_mappings = {
    ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
    -- ["c"] = { "<cmd>Bdelete!<cr>", "Close Buffer" },
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    ["h"] = { "<cmd>nohlsearch<cr>", "No Highlight" },
    ["v"] = { "<cmd>vsplit<cr>", "vsplit" },
    ["s"] = { "<cmd>split<cr>", "split" },

    b = {
        name = "Buffer",
        b = { "<cmd>Telescope buffers<cr>", "Buffers" },
        a = { "<cmd>buffer #<cr>", "Alternate Buffer" },
        n = { "<cmd>bnext<cr>", "Next Buffer" },
        p = { "<cmd>bprevious<cr>", "Previous Buffer" },
        f = { "<cmd>bfirst<cr>", "First Buffer" },
        l = { "<cmd>blast<cr>", "Last Buffer" },
    },

    g = {
        name = "Git",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescop git_commits<cr>", "Checkout commit" },
        o = { "<cmd>Telescope git_status<cr>", "Open changed files" },
        g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },

        --     The below keymaps are defined in gitsigns
        -- d = { gitsigns.diffthis("HEAD"), "Diff" },
    --     j = { gitsigns.next_hunk, "Next Hunk" },
    --     k = { gitsigns.prev_hunk, "Prev Hunk" },
    --     s = { gitsigns.stage_hunk, "Stage Hunk" },
    --     r = { gitsigns.reset_hunk, "Reset Hunk" },
    --     S = { gitsigns.stage_buffer, "Stage Buffer" },
    --     R = { gitsigns.reset_buffer, "Reset Buffer" },
    --     u = { gitsigns.undo_stage_hunk, "Undo Stage Hunk" },
    --     p = { gitsigns.preview_hunk, "Preview Hunk" },
    --
    --     -- git-blame.nvim installed 
    --     B = { "<cmd>GitBlameToggle<cr>", "Blame" },
    },

    P = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    o = {
        name = "Options",
        c = { '<cmd>lua vim.g.cmp_active=false<cr>', "Completion off" },
        C = { '<cmd>lua vim.g.cmp_active=true<cr>', "Completion on" },

        w = { "<cmd>set wrap!<cr>", "Toggle Wrap Lines" },
        W = { "<cmd>set wrapscan!<cr>", "Toggle Wrap Scan" },
    },

    f = {
        name = "Find",
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = { "<cmd>Telescope find_files<cr>", "Find files" },
        g = { "<cmd>Telescope live_grep<cr>", "Find Text" },
        s = { "<cmd>Telescope grep_string<cr>", "Find String" },
        h = { "<cmd>Telescope help_tags<cr>", "Help" },
        H = { "<cmd>Telescope highlights<cr>", "Highlights" },
        -- i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
        j = { "<cmd>Telescope jumplist<cr>", "Jump List"},
        l = { "<cmd>Telescope resume<cr>", "Last Search" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
    },

    l = {
        name = "LSP",
        i = { "<cmd>LspInfo<cr>", "Lsp Info" },
        I = { "<cmd>Mason<cr>", "Installer Info" },
    },

    t = {
        name = "Terminal",
        ["1"] = { "<cmd>1ToggleTerm<cr>", "1" },
        ["2"] = { "<cmd>2ToggleTerm<cr>", "2" },
        ["3"] = { "<cmd>3ToggleTerm<cr>", "3" },
        ["4"] = { "<cmd>4ToggleTerm<cr>", "4" },
        -- n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
        -- u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
        t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
        -- p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
        f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
        h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
        v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    },
}

local wk_vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use 'silent' when creating keymaps
    noremap = true, -- use 'noremap' when creating keymaps
    nowait = true, -- use 'nowait' when creating keymaps
}

local wk_vmappings = {
    -- This is defined in gitsigns config as it is here. 
    -- g = {
    --     name = "Git",
    --     s = { gitsigns.stage_hunk, "Stage Hunk" },
    --     r = { gitsigns.reset_hunk, "Reset Hunk" },
    -- },
}

which_key.register(wk_mappings, wk_opts)
