require('flutter-tools').setup({
    ui = {
        border = 'rounded',
        notification_style = 'plugin',
    },
    decorations = {
        statusline = {
            app_version = true,
            device = true,
            project_config = true,
        },
    },
    debugger = {
        enabled = false,
    },
    flutter_lookup_cmd = nil,
    fvm = false,
    widget_guides = {
        enabled = true,
    },
    closing_tags = {
        highlight = 'Comment',
        prefix = '// ',
        enabled = true,
    },
    dev_log = {
        enabled = true,
        notify_errors = false,
        open_cmd = 'tabedit',
    },
    dev_tools = {
        autostart = false,
        auto_open_browser = false,
    },
    outline = {
        open_cmd = '30vnew',
        auto_open = false,
    },
    lsp = {
        on_attach = function(client, bufnr)
            -- Enable document color via built-in LSP (Neovim 0.12+)
            vim.lsp.document_color.enable(true, bufnr, { style = 'virtual' })

            -- Reuse existing LSP keymaps
            local opts = { buffer = bufnr, silent = true }
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>qf', vim.lsp.buf.code_action, opts)

            if client:supports_method('textDocument/formatting') then
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr })
                    end,
                })
            end
        end,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        settings = {
            showTodos = true,
            completeFunctionCalls = true,
            analysisExcludedFolders = {},
        },
    },
})

-- Flutter-specific keymaps
local map = require('utils').map
map('n', '<leader>fr', ':FlutterRun<CR>')
map('n', '<leader>fR', ':FlutterRestart<CR>')
map('n', '<leader>fq', ':FlutterQuit<CR>')
map('n', '<leader>fR', ':FlutterReload<CR>')
map('n', '<leader>fo', ':FlutterOutlineToggle<CR>')
map('n', '<leader>fd', ':FlutterDevTools<CR>')
map('n', '<leader>fD', ':FlutterDevToolsActivate<CR>')
map('n', '<leader>fe', ':FlutterEmulators<CR>')
map('n', '<leader>fc', ':FlutterLogClear<CR>')
