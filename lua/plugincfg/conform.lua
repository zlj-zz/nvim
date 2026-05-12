local M = {}

M.enabled = false

require('conform').setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        vue = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        less = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        ['markdown.mdx'] = { 'prettier' },
        graphql = { 'prettier' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        zsh = { 'shfmt' },
        go = { 'gofumpt', 'goimports' },
    },
    format_on_save = function(bufnr)
        if not M.enabled then
            return
        end
        return {
            timeout_ms = 500,
            lsp_fallback = true,
        }
    end,
})

vim.api.nvim_create_user_command('Format', function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ['end'] = { args.line2, end_line:len() },
        }
    end
    require('conform').format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

vim.api.nvim_create_user_command('FormatToggle', function()
    M.enabled = not M.enabled
    vim.notify('Format on save: ' .. (M.enabled and 'ON' or 'OFF'))
end, {})

return M
