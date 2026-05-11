local utils = require('utils')
local map = utils.map

-- Disable coc for Go files (built-in LSP takes over)
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'go',
    callback = function()
        vim.b.coc_enabled = 0
    end,
})

-- NOTE: only works in Neovim 0.7.0dev+.
-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

-- coc plugins
vim.g.coc_global_extensions = {
      'coc-flutter-tools',
      'coc-vetur',
      'coc-prettier',
      'coc-yaml',
      'coc-sourcekit',
      'coc-tsserver',
      'coc-tslint',
      'coc-tailwindcss',
      'coc-translator',
      --'coc-java',
      --'coc-ccls',
      --'coc-jedi',
    }

--[[Autocomplete]]
local function check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

--[[
Use Tab for trigger completion with characters ahead and navigate
NOTE: There's always a completion item selected by default, you may want to enable
no select by setting `"suggest.noselect": true` in your configuration file
NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
other plugins before putting this into your config
--]]
local opts = {silent = true, expr = true, replace_keycodes = false}
map("i", "<TAB>", function()
    if vim.fn['coc#pum#visible']() == 1 then
        return vim.fn['coc#pum#next'](1)
    elseif check_back_space() then
        return vim.api.nvim_replace_termcodes('<TAB>', true, false, true)
    else
        return vim.fn['coc#refresh']()
    end
end, opts)

map("i", "<S-TAB>", function()
    if vim.fn['coc#pum#visible']() == 1 then
        return vim.fn['coc#pum#prev'](1)
    end
    return vim.api.nvim_replace_termcodes('<C-h>', true, false, true)
end, opts)

-- Use <c-space> to trigger completion
map("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
map("i", "<cr>", function()
    if vim.fn['coc#pum#visible']() == 1 then
        return vim.fn['coc#pum#confirm']()
    end
    return vim.api.nvim_replace_termcodes('<C-g>u<CR><c-r>=coc#on_enter()<CR>', true, false, true)
end, opts)

--[[Navigate diagnostics (built-in LSP, works for all filetypes)--]]
map("n", "[g", function() vim.diagnostic.goto_prev() end, {silent = true})
map("n", "]g", function() vim.diagnostic.goto_next() end, {silent = true})

--[[GoTo code navigation]]
map("n", "gd", "<Plug>(coc-definition)", {silent = true})
map("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
map("n", "gi", "<Plug>(coc-implementation)", {silent = true})
map("n", "gr", "<Plug>(coc-references)", {silent = true})

--[[Use K to show documentation in preview window]]
local function show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
--map("n", "K", function() show_docs() end, {silent = true})

--[[Highlight the symbol and its references on a CursorHold event(cursor is idle)]]
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

-- Symbol renaming
map("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

-- Formatting selected code
map({"x", "n"}, "\\f", "<Plug>(coc-format-selected)", {silent = true})

-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
map({"x", "n"}, "\\F", ":Format<CR>")


-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
-- 获取并执行 language server 给出的当前选择区间内的可用操作。
opts = {silent = true, nowait = true}
map({"x", "n"}, "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
--map("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
--map("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
map("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
-- select all line include the func.
--map({"x", "n"}, "if", "<Plug>(coc-funcobj-i)", opts)
-- select all line in the func
--map({"x", "n"}, "af", "<Plug>(coc-funcobj-a)", opts)


-- Run the Code Lens actions on the current line
map("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

---- Remap keys for apply refactor code actions.
--map("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
--map("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
--map("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Open up coc-commands
map("n", "<c-c>", ":CocCommand<CR>")

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")


-- coc-translator 翻译
map("n", "ts", "<Plug>(coc-translator-p)")
map("v", "ts", "<Plug>(coc-translator-pv)")


