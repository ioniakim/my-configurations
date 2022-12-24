local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Update cmp_nvim_lsp capabilities
local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_cmp_ok then
    M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
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


-- Set keymap functions from config.keymaps
local lsp_keymaps = require("config.keymaps").lsp_keymaps
local jdtls_keymaps = require("config.keymaps").jdtls_keymaps


M.on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    lsp_keymaps(bufnr)

    if client.name == "sumneko_lua" then
        -- resolved_capabilities was deprecated
        -- client.resolved_capabilities.document_formatting = false
        client.server_capabilities.document_formatting = false
    end

    if client.name == "jdtls" then
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
