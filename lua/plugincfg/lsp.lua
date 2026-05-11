local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function on_attach(client, bufnr)
    -- Disable coc for this buffer to avoid conflicts
    vim.b.coc_enabled = 0

    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>qf', vim.lsp.buf.code_action, opts)

    -- Format on save
    if client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
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

-- Neovim 0.11+ uses vim.lsp.config, older versions use lspconfig
if vim.lsp.config then
    vim.lsp.config('gopls', gopls_config)
    vim.lsp.enable('gopls')
else
    require('lspconfig').gopls.setup(gopls_config)
end
