-- theme switcher with persistence
local themes = { 'evergarden', 'silentium' }
local default_theme = 'evergarden'

-- state file to remember last chosen theme
local state_file = vim.fn.stdpath('state') .. '/theme.txt'

-- apply silentium's inlay hint fix
local function post_apply(name)
    if name == 'silentium' then
        vim.api.nvim_set_hl(0, 'LspInlayHint', { fg = '#737373', italic = true })
    end
end

-- apply a theme and persist it
local function apply_theme(name, persist)
    vim.cmd.colorscheme(name)
    post_apply(name)
    if persist then
        local f = io.open(state_file, 'w')
        if f then
            f:write(name)
            f:close()
        end
    end
end

-- on startup: restore last theme
local f = io.open(state_file, 'r')
if f then
    local saved = f:read('*l')
    f:close()
    if saved and vim.tbl_contains(themes, saved) then
        apply_theme(saved, false)
        vim.notify('Theme restored: ' .. saved, vim.log.levels.INFO)
    end
end

-- <leader>tc: cycle themes and persist choice
vim.keymap.set('n', '<leader>tc', function()
    local current = vim.g.colors_name or default_theme
    for i, name in ipairs(themes) do
        if name == current then
            local next_theme = themes[i % #themes + 1]
            apply_theme(next_theme, true)
            vim.notify('Theme: ' .. next_theme)
            return
        end
    end
    apply_theme(themes[1], true)
end, { desc = 'Cycle colorscheme' })
