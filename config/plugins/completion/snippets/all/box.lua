local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function box(opts)
    local function box_width()
        return opts.box_width or vim.opt.textwidth:get()
    end

    local function padding(cs, input_text)
        local spaces = box_width() - (2 * #cs)
        spaces = spaces - #input_text
        return spaces / 2
    end

    local comment_string = function()
        return require("luasnip.util.util").buffer_comment_chars()[1]
    end

    return {
        f(function()
            local cs = comment_string()
            return string.rep(string.sub(cs, 1, 1), box_width())
        end, { 1 }),
        t({ "", "" }),
        f(function(args)
            local cs = comment_string()
            return cs .. string.rep(" ", math.floor(padding(cs, args[1][1])))
        end, { 1 }),
        i(1, "placeholder"),
        f(function(args)
            local cs = comment_string()
            return string.rep(" ", math.ceil(padding(cs, args[1][1]))) .. cs
        end, { 1 }),
        t({ "", "" }),
        f(function()
            local cs = comment_string()
            return string.rep(string.sub(cs, 1, 1), box_width())
        end, { 1 }),
    }
end

require("luasnip").add_snippets("all", {
    -- https://github.com/L3MON4D3/LuaSnip/wiki/Cool-Snippets#box-comment-like-ultisnips
    s({ trig = "box" }, box({ box_width = 24 })),
    s({ trig = "bbox" }, box({})),
})
