-- macOS: leave Insert → ABC; re-enter → restore previous IM
-- deps: brew tap daipeihust/tap && brew install im-select

local uv = vim.uv or vim.loop
if uv.os_uname().sysname ~= 'Darwin' then
    return
end

local im = 'im-select'
if vim.fn.executable(im) == 0 then
    return
end

local default_im = 'com.apple.keylayout.ABC'
local last_im = default_im

local function set_im(id)
    vim.fn.jobstart({ im, id }, { detach = true })
end

local function get_im(cb)
    local out = {}
    vim.fn.jobstart({ im }, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data then vim.list_extend(out, data) end
        end,
        on_exit = function()
            cb(table.concat(out, ''):gsub('%s+$', ''))
        end,
    })
end

local grp = vim.api.nvim_create_augroup('IMSelect', { clear = true })
vim.api.nvim_create_autocmd('InsertLeave', {
    group = grp,
    callback = function()
        get_im(function(current)
            if current ~= default_im then last_im = current end
            set_im(default_im)
        end)
    end,
})
vim.api.nvim_create_autocmd('InsertEnter', {
    group = grp,
    callback = function()
        if last_im ~= default_im then set_im(last_im) end
    end,
})
vim.api.nvim_create_autocmd({ 'VimEnter', 'FocusGained' }, {
    group = grp,
    callback = function() set_im(default_im) end,
})
