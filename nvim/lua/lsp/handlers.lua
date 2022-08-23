local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
    return
end


M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)


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

local function lsp_keymaps(bufnr)
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
        l = {
            name = "LSP",
            a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
            -- c = { "<cmd>lua require('lsp').server_capabilities()<cr>", "Get Capabilities" },
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
    }

    which_key.register(mappings, opts)
end

M.on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    if client.name == "sumneko_lua" then
        client.server_capabilities.document_formatting = false
    end

    lsp_keymaps(bufnr)

    if client.name == "jdt.ls" then
        vim.lsp.codelens.refresh()
        if JAVA_DAP_ACTIVE then
            require("jdtls").setup_dap { hotcodereplace = "auto" }
            require("jdtls.dap").setup_dap_main_class_configs()
        end
        client.server_capabilities.document_formatting = true
        client.server_capabilities.textDocument.completion.completionItem.snippetSupport = false
    end

end

return M
