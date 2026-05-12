local M = {}

-- Ctrl-V (block visual mode) is char code 22
local VISUAL_BLOCK = '\22'

function M.get_selection()
    local mode = vim.fn.mode()
    local start_line, end_line

    if mode == 'v' or mode == 'V' or mode == VISUAL_BLOCK then
        start_line = vim.fn.line("'<")
        end_line = vim.fn.line("'>")
    else
        local node = vim.treesitter.get_node()
        if node then
            local sr, _, er, _ = vim.treesitter.get_node_range(node)
            start_line = sr + 1
            end_line = er + 1
        else
            start_line = vim.fn.line('.')
            end_line = start_line
        end
    end

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

    return {
        filepath = vim.api.nvim_buf_get_name(0),
        start_line = start_line,
        end_line = end_line,
        code = table.concat(lines, '\n'),
        lang = vim.bo.filetype,
    }
end

return M
