local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
    s('init', fmt(
        [[def __init__(self{}):
	{}]],
        { i(1, ',arg'), i(2, '# TODO') }
    )),

    s('nie', fmt(
        [[def {}(self):
	raise NotImplementedError("{}"){}]],
        { i(1, 'fname'), i(2, 'tip'), i(0) }
    )),
}
