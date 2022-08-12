local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
    return
end

local servers = {
    "sumneko_lua",
    "rust_analyzer",
}

mason.setup()

mason_lspconfig.setup({
    ensure_installed = servers
})



local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("lsp.handlers").on_attach,
        capabilities = require("lsp.handlers").capabilities,
    }

    if server == "sumneko_lua" then
        local sumneko_opts = require("lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server == "rust_analyzer" then
    end

    lspconfig[server].setup(opts)
end
