local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
    s('sec', fmt('# {} #', { i(1, 'Section Name') })),
    s('ssec', fmt('## {} ##', { i(1, 'Section Name') })),
    s('sssec', fmt('### {} ###', { i(1, 'Section Name') })),
    s('par', fmt('#### {} ####', { i(1, 'Paragraph Name') })),
    s('spar', fmt('##### {} #####', { i(1, 'Paragraph Name') })),
    s('detail', fmt(
        [[<details{}>
	<summary>{}</summary>{}
</details>]],
        { i(3, ' open=""'), i(2), i(0) }
    )),
}
