local M = {}

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
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local keymap = vim.keymap.set
    keymap("n", "gD", vim.lsp.buf.declaration, opts)
    keymap("n", "gd", vim.lsp.buf.definition, opts)
    keymap("n", "<space>D", vim.lsp.buf.type_definition, opts)
    keymap("n", "K", vim.lsp.buf.hover, opts)
    keymap("n", "gi", vim.lsp.buf.implementation, opts)
    keymap("n", "gr", vim.lsp.buf.references, opts)
    keymap("n", "gl", vim.diagnostic.open_float, opts)
    keymap("n", "<space>f", function()
        vim.lsp.buf.format { async = true }
    end, opts)
    keymap("n", "<space>li", "<cmd>LspInfo<cr>", opts)
    keymap("n", "<space>m", "<cmd>Mason<cr>", opts)
    keymap("n", "<space>ca", vim.lsp.buf.code_action, opts)
    keymap("n", "<space>gn", vim.diagnostic.goto_next, opts)
    keymap("n", "<space>gp", vim.diagnostic.goto_prev, opts)
    keymap("n", "<space>rn", vim.lsp.buf.rename, opts)
    keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    keymap("n", "<space>sl", vim.diagnostic.setloclist, opts)
    keymap("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    keymap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    keymap("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
end

M.on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if not status_cmp_ok then
        return
    end

    lsp_keymaps(bufnr)
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
        return
    end
    illuminate.on_attach(client)

    if client.name == "jdt.ls" then
        vim.lsp.codelens.refresh()
        if JAVA_DAP_ACTIVE then
            require("jdtls").setup_dap { hotcodereplace = "auto" }
            require("jdtls.dap").setup_dap_main_class_configs()
        end
        client.resolved_capabilities.document_formatting = true
        client.resolved_capabilities.textDocument.completion.completionItem.snippetSupport = false
    end

    M.capabilities = vim.lsp.protocol.make_client_capabilities()
    M.capabilities.textDocument.completion.completionItem.snippetSupport = true
    M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
end

return M
