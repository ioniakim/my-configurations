local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
    return
end

local servers = {
    "lua_ls",
    "rust_analyzer",
    "jdtls",
    "clangd",
}
local settings = {
    ui = {
        border = "rounded",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

mason.setup(settings)

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

    if server == "lua_ls" then
        local lua_ls_opts = require("lsp.settings.lua_ls")
        opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)
    end

    -- if server == "rust_analyzer" then
    -- end

    if server == "clangd" then
        opts.capabilities.offsetEncoding = "utf-8"
        local clangd_opts = require("lsp.settings.clangd")
        opts = vim.tbl_deep_extend("force", clangd_opts, opts)
    end

    if server == "jdtls" then
        goto continue
    end

    lspconfig[server].setup(opts)
    ::continue::
end
