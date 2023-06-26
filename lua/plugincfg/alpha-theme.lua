local if_nil = vim.F.if_nil
local fnamemodify = vim.fn.fnamemodify
local filereadable = vim.fn.filereadable
local screen_high = vim.api.nvim_eval("&lines")

local default_terminal = {
    type = "terminal",
    command = nil,
    width = 69,
    height = 8,
    opts = {
        redraw = true,
        window_config = {},
    },
}

local function apply_gradient_hl(text)
    local gradient = require("utils").create_gradient("#DCA561", "#658594", #text)

    local lines = {}
    for i, line in ipairs(text) do
        local tbl = {
            type = "text",
            val = line,
            opts = {
                hl = "HeaderGradient" .. i,
                shrink_margin = false,
                position = "center",
            },
        }
        table.insert(lines, tbl)

        -- create hl group
        vim.api.nvim_set_hl(0, "HeaderGradient" .. i, { fg = gradient[i] })
    end

    return {
        type = "group",
        val = lines,
        opts = { position = "center" },
    }
end

local header_assic = require("headers").showdow
local default_header = apply_gradient_hl(header_assic)
--local default_header = {
    --type = "text",
    --val = header_assic,
    --opts = {
        --position = "center",
        --hl = "Type",
        ---- wrap = "overflow";
    --},
--}

---@param name string
---@return string
local function getGreeting(name)
    local tableTime = os.date("*t")
    local hour = tableTime.hour
    local greetingsTable = {
        [1] = "  Sleep well",
        [2] = "  Good morning",
        [3] = "  Good afternoon",
        [4] = "  Good evening",
        [5] = "望 Good night",
    }
    local greetingIndex = 0
    if hour == 23 or hour < 7 then
        greetingIndex = 1
    elseif hour < 12 then
        greetingIndex = 2
    elseif hour < 18 then
        greetingIndex = 3
    elseif hour < 22 then
        greetingIndex = 4
    elseif hour >= 22 then
        greetingIndex = 5
    end
    return greetingsTable[greetingIndex] .. ", " .. name
end

local function generate_footer()
    local loaded_plugins = #vim.fn.globpath(vim.fn.stdpath("data") .. "/site/pack/packer/start", "*", 0, 1)
    ---@diagnostic disable-next-line: undefined-global
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local plugins_state_str = loaded_plugins .. "/" .. total_plugins .. " plugins loaded"

    local datetime = os.date(" %d-%m-%Y   %H:%M:%S")

    local version = vim.version()
    local nvim_version_info = "  v" .. version.major .. "." .. version.minor .. "." .. version.patch

    return getGreeting("zachary") .. "   " .. plugins_state_str .. nvim_version_info
end

local footer = {
    type = "text",
    val = generate_footer(),
    opts = {
        position = "center",
        hl = "Number",
    },
}

local leader = "SPC"

--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 3,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, {
            noremap = true,
            silent = true,
            nowait = true,
        })
        opts.keymap = {"n", sc_, keybind, keybind_opts}
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

--[[
--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
        position = "center",
        shortcut = "[" .. sc .. "] ",
        cursor = 1,
        -- width = 50,
        align_shortcut = "left",
        hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } },
        shrink_margin = false,
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end
]]

local nvim_web_devicons = {
    enabled = true,
    highlight = true,
}

local function get_extension(fn)
    local match = fn:match("^.+(%..+)$")
    local ext = ""
    if match ~= nil then
        ext = match:sub(2)
    end
    return ext
end

local function icon(fn)
    local nwd = require("nvim-web-devicons")
    local ext = get_extension(fn)
    return nwd.get_icon(fn, ext, {
        default = true,
    })
end

local function file_button(fn, sc, short_fn, autocd)
    short_fn = if_nil(short_fn, fn)
    local ico_txt
    local fb_hl = {}
    if nvim_web_devicons.enabled then
        local ico, hl = icon(fn)
        local hl_option_type = type(nvim_web_devicons.highlight)
        if hl_option_type == "boolean" then
            if hl and nvim_web_devicons.highlight then
                table.insert(fb_hl, {hl, 0, #ico})
            end
        end
        if hl_option_type == "string" then
            table.insert(fb_hl, {nvim_web_devicons.highlight, 0, #ico})
        end
        ico_txt = ico .. "  "
    else
        ico_txt = ""
    end
    local cd_cmd = (autocd and " | cd %:p:h" or "")
    local file_button_el = button(sc, ico_txt .. short_fn, "<cmd>e " .. fn .. cd_cmd .. " <CR>")
    local fn_start = short_fn:match(".*[/\\]")
    if fn_start ~= nil then
        table.insert(fb_hl, {"Comment", #ico_txt, #fn_start + #ico_txt})
    end
    file_button_el.opts.hl = fb_hl
    return file_button_el
end

local default_mru_ignore = {"gitcommit"}

local mru_opts = {
    ignore = function(path, ext)
        return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
    end,
    autocd = false,
}

--- @param start number
--- @param cwd string? optional
--- @param items_number number? optional number of items to generate, default = 10
local function mru(start, cwd, items_number, opts)
    opts = opts or mru_opts
    items_number = if_nil(items_number, 10)
    local oldfiles = {}
    for _, v in pairs(vim.v.oldfiles) do
        if #oldfiles == items_number then
            break
        end
        local cwd_cond
        if not cwd then
            cwd_cond = true
        else
            cwd_cond = vim.startswith(v, cwd)
        end
        local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
        if (filereadable(v) == 1) and cwd_cond and not ignore then
            oldfiles[#oldfiles + 1] = v
        end
    end

    local tbl = {}
    for i, fn in ipairs(oldfiles) do
        local short_fn
        if cwd then
            short_fn = fnamemodify(fn, ":.")
        else
            short_fn = fnamemodify(fn, ":~")
        end
        local file_button_el = file_button(fn, tostring(i + start - 1), short_fn, opts.autocd)
        tbl[i] = file_button_el
    end
    return {
        type = "group",
        val = tbl,
        opts = {},
    }
end

local function mru_title()
    return "MRU " .. vim.fn.getcwd()
end

--[[
local buttons = {
    type = "group",
    val = {
        button("e", "  New file", "<cmd>ene <CR>"),
        button("SPC f f", "󰈞  Find file"),
        button("SPC f h", "󰊄  Recently opened files"),
        button("SPC f r", "  Frecency/MRU"),
        button("SPC f g", "󰈬  Find word"),
        button("SPC f m", "  Jump to bookmarks"),
        button("SPC s l", "  Open last session"),
    },
    opts = {
        spacing = 1,
    },
}
]]

local mru_cwd = {
    type = "group",
    val = {{
        type = "padding",
        val = 1,
    }, {
        type = "text",
        val = mru_title,
        opts = {
            hl = "SpecialComment",
            shrink_margin = false,
            position = "center",
        },
    }, {
        type = "padding",
        val = 1,
    }, {
        type = "group",
        val = function()
            -- Dynamically get the number of items.
            return {mru(0, vim.fn.getcwd(), math.floor((screen_high - #header_assic - 10) * 0.5))}
        end,
        opts = {
            shrink_margin = false,
        },
    }},
}

local bottom_buttons = {
    type = "group",
    val = {
        {
            type = "text",
            val = "Quick links",
            opts = {
                hl = "SpecialComment",
                position = "center",
            },
        },
        {type = "padding", val = 1}, 
        button("e", "  New file", "<cmd>ene<CR>"), button("s", "  Sync plugins", "<cmd>PackerSync<CR>"),
        button("c", "  Configuration", ":e $MYVIMRC | :cd %:p:h | pwd<CR>"),
        button("q", "󰅚  Quit", "<cmd>qa<CR>")
    },
    position = "center",
}
-- button("SPC f f", "󰈞  Find file"),
-- button("SPC f g", "󰊄  Live grep"),
-- button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),

local section = {
    terminal = default_terminal,
    header = default_header,
    -- note about MRU: currently this is a function,
    -- since that means we can get a fresh mru
    -- whenever there is a DirChanged. this is *really*
    -- inefficient on redraws, since mru does a lot of I/O.
    -- should probably be cached, or maybe figure out a way
    -- to make it a reference to something mutable
    -- and only mutate that thing on DirChanged
    -- mru = {
    --     type = "group",
    --     val = {
    --         { type = "padding", val = 1 },
    --         { type = "text", val = "MRU", opts = { hl = "SpecialComment" } },
    --         { type = "padding", val = 1 },
    --         {
    --             type = "group",
    --             val = function()
    --                 return { mru(10) }
    --             end,
    --         },
    --     },
    -- },
    mru_cwd = mru_cwd,
    bottom_buttons = bottom_buttons,
    footer = footer,
}

local config = {
    layout = {
        {type = "padding", val = 1},
        section.header,
        {type = "padding", val = 2},
        section.mru_cwd,
        -- section.mru,
        {type = "padding", val = 1},
        section.bottom_buttons,
        {type = "padding", val = 3},
        section.footer
    },
    opts = { margin = 5, },
}

return {
    button = button,
    section = section,
    config = config,
    -- theme config
    leader = leader,
    -- deprecated
    opts = config,
}

