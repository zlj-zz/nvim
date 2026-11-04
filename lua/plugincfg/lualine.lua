-- Statusline / tabline shaped like a segmented demo UI, colors follow nordfox.
vim.opt.laststatus = 3
vim.opt.showtabline = 2

require('lualine').setup({
    options = {
        theme = 'auto',
        globalstatus = true,
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = { 'dashboard', 'alpha' },
            winbar = {},
        },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
            {
                'filename',
                path = 1, -- relative path, closer to demo center path
                symbols = { modified = ' ●', readonly = ' ', unnamed = '[No Name]' },
            },
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'location' },
    },
    tabline = {
        lualine_a = {
            {
                'buffers',
                mode = 2,
                show_filename_only = true,
                max_length = vim.o.columns * 2 / 3,
                symbols = {
                    modified = ' ●',
                    alternate_file = '',
                    directory = '',
                },
            },
        },
        lualine_z = { 'branch' },
    },
})
