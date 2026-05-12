local wk = require('which-key')

wk.setup({
    preset = 'modern',
    delay = 300,
    icons = {
        mappings = false,
    },
    win = {
        border = 'rounded',
    },
    triggers = {
        { '<auto>', mode = 'nixsotc' },
        { 'b', mode = 'n' },
        { 'c', mode = 'n' },
        { 's', mode = 'n' },
        { 't', mode = 'n' },
        { ',', mode = 'n' },
    },
})

wk.add({
    -- <leader> prefixed
    { '<leader>c',  group = 'Comment' },
    { '<leader>cf', desc = 'Format buffer' },
    { '<leader>fc', desc = 'Find git conflict' },
    { '<leader>f',  group = 'Flutter' },
    { '<leader>g',  group = 'Git' },
    { '<leader>go', desc = 'Open on browser' },
    { '<leader>h',  group = 'Hunk' },
    { '<leader>hp', desc = 'Preview hunk' },
    { '<leader>hb', desc = 'Blame line' },
    { '<leader>hs', desc = 'Stage hunk' },
    { '<leader>hr', desc = 'Reset hunk' },
    { '<leader>hS', desc = 'Stage buffer' },
    { '<leader>hR', desc = 'Reset buffer' },
    { '<leader>hd', desc = 'Diff this' },
    { '<leader>pm', desc = 'Toggle paste mode' },
    { '<leader>q',  group = 'Quickfix' },
    { '<leader>r',  group = 'Rename' },
    { '<leader>s',  group = 'Search/Spell' },
    { '<leader>sc', desc = 'Toggle spell' },
    { '<leader>t',  group = 'Toggle/Terminal' },
    { '<leader>tm', desc = 'Toggle table mode' },
    { '<leader>tr', desc = 'Trim trailing space' },
    { '<leader>w',  group = 'Window' },
    { '<leader>x',  group = 'Trouble' },
    { '<leader>xx', desc = 'Diagnostics toggle' },
    { '<leader>xs', desc = 'Symbols toggle' },
    { '<leader>z',  desc = 'Toggle fullscreen' },
    { '<leader><leader>', desc = 'Jump to <++>' },
    { '<leader>ai', desc = 'Send to AI agent' },

    -- Single-key prefixes (from mappings.lua)
    { 'b', group = 'Buffer' },
    { 'c', group = 'Rotate window' },
    { 's', group = 'Split window' },
    { 't', group = 'Tab / Toggle / Jump' },
    { ',', group = 'Telescope' },
    { 'g', group = 'Goto' },
    { '[', group = 'Previous' },
    { ']', group = 'Next' },
})
