local M = {}

local keymap = vim.keymap.set
local status_wk_ok, which_key = pcall(require, "which-key")

-- Default Keymappings
M.setup = function()
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

    -- which_key keymappings
    if not status_wk_ok then
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
            --     Refer to gitsigns_keymaps function for more keymaps
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
            j = { "<cmd>Telescope jumplist<cr>", "Jump List" },
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
end


-- ---------------------------------
-- Keymappings for LSP
-- ---------------------------------
M.lsp_keymaps = function(bufnr)

    local status_lsp_ok, _ = pcall(require, "lspconfig")

    if not status_wk_ok and not status_lsp_ok then
        return
    end

    local gopts = {
        mode = "n", -- NORMAL mode
        prefix = "g",
        buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use 'silent' when creating keymaps
        noremap = true, -- use 'noremap' when creating keymaps
        nowait = true, -- use 'nowait' when creating keymaps
    }

    local gmappings = {
        d = { "<cmd>Telescope lsp_definitions<cr>", "Definitions" },
        D = { "<cmd>Telescope lsp_type_definitions<cr>", "Declarations" },
        I = { "<cmd>Telescope lsp_implementations<cr>", "Implementations" },
        r = { "<cmd>Telescope lsp_references<cr>", "References" },
        l = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Show Diagnostics" },
        k = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show Description" },
    }


    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use 'silent' when creating keymaps
        noremap = true, -- use 'noremap' when creating keymaps
        nowait = true, -- use 'nowait' when creating keymaps
    }


    local mappings = {
        l = {
            name = "LSP",
            a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
            C = { "<cmd>lua require('lsp').server_capabilities()<cr>", "Get Capabilities" },
            -- d = {
            --     "<cmd>Telescope lsp_document_diagnostics<cr>",
            --     "Document Diagnostics",
            -- },
            -- w = {
            --     "<cmd>Telescope lsp_workspace_diagnostics<cr>",
            --     "Workspace Diagnostics",
            -- },
            f = { "<cmd>lua vim.lsp.buf.format({async=true})<cr>", "Format" },
            h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
            j = {
                "<cmd>lua vim.diagnostic.goto_next()<CR>",
                "Next Diagnostic",
            },
            k = {
                "<cmd>lua vim.diagnostic.goto_prev()<cr>",
                "Prev Diagnostic",
            },
            l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
            R = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "CodeLens Refresh" },
            q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
            r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
            s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
            S = {
                "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                "Workspace Symbols",
            },

            w = {
                a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add Workspace Folder" },
                r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove Workspace Folder" },
                l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "List Workspace Folders" }
            },
        },

        d = {
            name = "Debug",
            b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint" },
            B = { "<cmd>lua require('dap').set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
            l = { "<cmd>lua require('dap').list_breakpoints()<cr>", "List Breakpoints" },
            v = { "<cmd>lua require('dapui').eval()<cr>", "Evaluate" },
            V = { "<cmd>lua require('dapui').eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
            h = { "<cmd>lua require('dap.ui.widgets').hover()<cr>", "Hover Variables" },
            -- s = { "<cmd>lua require('dap.ui.widgets').scopes()<cr>", "Scopes" }, -- scopes is not callable, but an entity
            c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
            i = { "<cmd>lua require('dap').step_into()<cr>", "Step Into" },
            o = { "<cmd>lua require('dap').step_over()<cr>", "Step Over" },
            O = { "<cmd>lua require('dap').step_out()<cr>", "Step Out" },
            r = { "<cmd>lua require('dap').run_to_cursor()<cr>", "Run to Cursor" },
            R = { "<cmd>lua require('dap').repl.toggle()<cr>", "Toggle REPL" },
            -- r = { "<cmd>lua require('dap').run_last()<cr>", "Run Last" },
            u = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle DAPUI" },
            x = { "<cmd>lua require('dap').terminate()<cr>", "Terminate" },
        },
    }

    which_key.register(gmappings, gopts)
    which_key.register(mappings, opts)
end


-- ---------------------------------
-- Keymappings for jdtls
-- ---------------------------------
M.jdtls_keymaps = function(bufnr)

    local status_jdtls_ok, _ = pcall(require, "jdtls")
    if not status_wk_ok and not status_jdtls_ok then
        return
    end

    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- Use 'silent' when creating keymaps
        noremap = true, -- Use 'noremap' when creating keymaps
        nowait = true, -- Use 'nowait' when creating keymaps
    }

    local mappings = {
        l = {
            name = "LSP",
            o = { "<Cmd>lua require('jdtls').organize_imports()<CR>", "Organize Imports" },
            v = { "<Cmd>lua require('jdtls').extract_variable()<CR>", "Extract Variable" },
            c = { "<Cmd>lua require('jdtls').extract_constant()<CR>", "Extract Constant" },
            u = { "<Cmd>JdtUpdateConfig<CR>", "Update Config" },
        },

        d = {
            -- Requires java-debug and vscode-java-test bundles
            t = { "<Cmd>lua require('jdtls').test_nearest_method()<CR>", "Test Method" },
            T = { "<Cmd>lua require('jdtls').test_class()<CR>", "Test Class" },
        }
    }

    local vopts = {
        mode = "v", -- VISUAL mode
        prefix = "<leader>",
        buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- Use 'silent' when creating keymaps
        noremap = true, -- Use 'noremap' when creating keymaps
        nowait = true, -- Use 'nowait' when creating keymaps
    }

    local vmappings = {
        l = {
            name = "LSP",
            J = {
                name = "Java",
                v = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable" },
                c = { "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", "Extract Constant" },
                m = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method" },
            },
        }
    }

    which_key.register(mappings, opts)
    which_key.register(vmappings, vopts)
end


-- ---------------------------------
-- Keymappings for gitsigns and gitblame
-- ---------------------------------
M.gitsigns_keymaps = function(bufnr)
    local status_gs_ok, gitsigns = pcall(require, "gitsigns")

    if not status_wk_ok and not status_gs_ok then
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

    local status_gb_ok, _ = pcall(require, "gitblame")
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


return M
