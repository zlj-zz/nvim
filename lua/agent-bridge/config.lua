local M = {}

M.defaults = {
    keymap = '<leader>ai',
    default_sender = 'auto',
    prompt_template = 'File: {filepath} (L{start}-{end})\n\n```{lang}\n{code}\n```\n\n{question}',
    capture_claude_output = true,
    claude_timeout_ms = 120000,
}

function M.merge(opts)
    return vim.tbl_deep_extend('force', M.defaults, opts or {})
end

return M
