local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Update cmp_nvim_lsp capabilities
local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_cmp_ok then
    M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
end

M.setup = function()
    local signs = {

        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_text = false, -- disable virtual text
        signs = {
            active = signs, -- show signs
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

local status_wk_ok, which_key = pcall(require, "which-key")

local function lsp_keymaps(bufnr)

    if not status_wk_ok then
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
            h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help"},
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
            s = { "<cmd>lua require('dap.ui.widgets').scopes()<cr>", "Scopes" },
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

local function jdtls_keymaps(bufnr)

    if not status_wk_ok then
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

M.on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    lsp_keymaps(bufnr)

    if client.name == "sumneko_lua" then
        -- resolved_capabilities was deprecated
        -- client.resolved_capabilities.document_formatting = false
        client.server_capabilities.document_formatting = false
    end

    if client.name == "jdt.ls" then
        if JAVA_DAP_ACTIVE then
            require("jdtls").setup_dap { hotcodereplace = "auto" }
            require("jdtls.dap").setup_dap_main_class_configs()
        end
        -- resolved_capabilities was deprecated
        -- client.resolved_capabilities.document_formatting = true
        client.server_capabilities.document_formatting = true
        vim.lsp.codelens.refresh()
        -- set in java.lua
        -- client.server_capabilities.textDocument.completion.completionItem.snippetSupport = false
        jdtls_keymaps(bufnr)
    end


    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
        return
    end
    illuminate.on_attach(client)

end

return M
