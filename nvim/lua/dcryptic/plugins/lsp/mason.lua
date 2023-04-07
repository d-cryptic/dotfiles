local mason_status, mason = pcall(require,"mason")
if not mason_status then
    return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
    return
end



mason.setup()

mason_lspconfig.setup({
    ensure_installed = {
        "bashls",
        "clangd",
        "cssls",
        "cssmodules_ls",
        "unocss",
        "dotls",
        "eslint",
        "emmet_ls",
        "golangci_lint_ls",
        "gopls",
        "graphql",
        "html",
        "jsonls",
        "quick_lint_js",
        "tsserver",
        "vtsls",
        "lua_ls",
        "marksman",
        "prosemd_lsp",
        "remark_ls",
        "zk",
        "spectral",
        "prismals",
        "jedi_language_server",
        "pyre",
        "pyright",
        "sourcery",
        "pylsp",
        "sqlls",
        "sqls",
        "stylelint_lsp",
        "tailwindcss",
        "yamlls"
    }
})

