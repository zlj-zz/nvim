local map = require('utils').map

require('pigit').setup({
    cd_scope = 'tcd',
    open_on_enter = 'none',
})

map('n', ',pp', '<cmd>PigitRepos<CR>')
map('n', ',ps', '<cmd>PigitStatus<CR>')
