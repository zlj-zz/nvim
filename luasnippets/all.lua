local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node

return {
    s('snip', {
        t('snippet '), i(1, 'trigger'), t(' "'), i(2, 'description'), t('" '), i(3, 'bw'),
        t({ '', '' }), i(0),
    }),
}
