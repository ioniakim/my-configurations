local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
    return
end

-- Default settings
gitsigns.setup {
    signs                        = {
        add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    },
    signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
        interval = 1000,
        follow_files = true
    },
    attach_to_untracked          = true,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil, -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
    preview_config               = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm                         = {
        enable = false
    },

    on_attach = function(bufnr)
        local status_wk_ok, which_key = pcall(require, "which-key")
        if not status_wk_ok then
            return
        end


        local opts = {
            mode = "n", -- NORMAL mode
            prefix = "<leader>",
            buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use 'silent' when creating keymaps
            noremap = true, -- use 'noremap' when creating keymaps
            nowait = true, -- use 'nowait' when creating keymaps
        }

        local mappings = {
            g = {
                name = "Git",
                d = { gitsigns.diffthis("HEAD"), "Diff" },
                j = { gitsigns.next_hunk, "Next Hunk" },
                k = { gitsigns.prev_hunk, "Prev Hunk" },
                s = { gitsigns.stage_hunk, "Stage Hunk" },
                r = { gitsigns.reset_hunk, "Reset Hunk" },
                S = { gitsigns.stage_buffer, "Stage Buffer" },
                R = { gitsigns.reset_buffer, "Reset Buffer" },
                u = { gitsigns.undo_stage_hunk, "Undo Stage Hunk" },
                p = { gitsigns.preview_hunk, "Preview Hunk" },
            }
        }

        local vopts = {
            mode = "v", -- Visual mode
            prefix = "<leader>",
            buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use 'silent' when creating keymaps
            noremap = true, -- use 'noremap' when creating keymaps
            nowait = true, -- use 'nowait' when creating keymaps
        }

        local vmappings = {
            g = {
                name = "Git",
                s = { gitsigns.stage_hunk, "Stage Hunk" },
                r = { gitsigns.reset_hunk, "Reset Hunk" },
            }
        }

        which_key.register(mappings, opts)
        which_key.register(vmappings, vopts)

        local status_gb_ok, git_blame = pcall(require, "gitblame")
        if status_gb_ok then
            local gb_mappings = {
                g = {
                    name = "Git",
                    B = { "<cmd>GitBlameToggle<cr>", "Blame" },
                }
            }

            which_key.register(gb_mappings, opts)
        end
    end
}
