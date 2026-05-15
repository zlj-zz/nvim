local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)

end

local gopls_config = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
}

local servers = {
    gopls = gopls_config,
    bashls = { on_attach = on_attach, capabilities = capabilities },
    jsonls = { on_attach = on_attach, capabilities = capabilities },
    html = { on_attach = on_attach, capabilities = capabilities },
    cssls = { on_attach = on_attach, capabilities = capabilities },
    basedpyright = { on_attach = on_attach, capabilities = capabilities },
    -- pyright = { on_attach = on_attach, capabilities = capabilities },
    yamlls = { on_attach = on_attach, capabilities = capabilities },
    vtsls = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            typescript = {
                preferences = {
                    importModuleSpecifier = 'relative',
                },
            },
        },
    },
    sourcekit = { on_attach = on_attach, capabilities = capabilities }, -- Swift / Objective-C
    lua_ls = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = { globals = { 'vim' } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            },
        },
    },
}

-- Neovim 0.11+ uses vim.lsp.config, older versions use lspconfig
if vim.lsp.config then
    for name, cfg in pairs(servers) do
        vim.lsp.config(name, cfg)
        vim.lsp.enable(name)
    end
else
    local lspconfig = require('lspconfig')
    for name, cfg in pairs(servers) do
        lspconfig[name].setup(cfg)
    end
end
