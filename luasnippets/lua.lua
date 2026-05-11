local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt

local linelen = 88

local function dash_count(args, _, user_args)
    local text = args[1][1] or ''
    local rem = linelen - 8 - #text
    if user_args == 'floor' then
        return string.rep('-', math.floor(rem / 2))
    else
        return string.rep('-', math.ceil(rem / 2))
    end
end

return {
    s('fhead', fmt(
        [[
------------------------------------
-- [name]       : {}
-- [func]       : {}
-- [param]      : {}
-- [return]     : {}
------------------------------------{}]],
        { i(1, 'fname'), i(2, 'desc'), i(3, 'params'), i(4, 'return'), i(0) }
    )),

    s('fmodule', fmt(
        [[
------------------------------------
-- [module] : {}
-- [create] : {}
-- [modify] : {}

-- {}

-- Licensed under the MIT License (the "License");
------------------------------------{}]],
        { i(1, 'fname'), i(2, 'desc'), i(3, 'modify'), i(4, 'copyright'), i(0) }
    )),

    s('line', fmt(
        '--{}\\ {} /{}--{}',
        {
            f(dash_count, { 1 }, { user_args = 'floor' }),
            i(1, 'text'),
            f(dash_count, { 1 }, { user_args = 'ceil' }),
            i(0),
        }
    )),

    s('map', fmt(
        "{{'{}', '{}', '{}'}},",
        { i(1, 'mod'), i(2, 'keys'), i(3, 'contents') }
    )),

    s('tfun', fmt(
        [[function {}.{}({})
	{}
end
{}]],
        { i(1, 'table_name'), i(2, 'func_name'), i(3, '...'), i(4, '--context'), i(0) }
    )),

    s('sfun', fmt(
        [[function {}:{}({})
	{}
end
{}]],
        { i(1, 'table_name'), i(2, 'func_name'), i(3, '...'), i(4, '--context'), i(0) }
    )),
}
