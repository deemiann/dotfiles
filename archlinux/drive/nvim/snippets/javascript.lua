local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Javascript Snippets", { clear = true })
local file_pattern = "*.js"

local function cs(trigger, nodes, opts) --{{{
  local snippet = s(trigger, nodes)
  local target_table = snippets

  local pattern = file_pattern
  local keymaps = {}

  if opts ~= nil then
    -- check for custom pattern
    if opts.pattern then
      pattern = opts.pattern
    end

    -- if opts is a string
    if type(opts) == "string" then
      if opts == "auto" then
        target_table = autosnippets
      else
        table.insert(keymaps, { "i", opts })
      end
    end

    -- if opts is a table
    if opts ~= nil and type(opts) == "table" then
      for _, keymap in ipairs(opts) do
        if type(keymap) == "string" then
          table.insert(keymaps, { "i", keymap })
        else
          table.insert(keymaps, keymap)
        end
      end
    end

    -- set autocmd for each keymap
    if opts ~= "auto" then
      for _, keymap in ipairs(keymaps) do
        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = pattern,
          group = group,
          callback = function()
            vim.keymap.set(keymap[1], keymap[2], function()
              ls.snip_expand(snippet)
            end, { noremap = true, silent = true, buffer = true })
          end,
        })
      end
    end
  end

  table.insert(target_table, snippet) -- insert snippet into appropriate table
end --}}}

cs(
  "caf",
  fmt(
    "const {} = {} => {}",
    {
      i(1, ""),
      i(2, ""),
      i(3, "")
    }
  )
)
cs(
  "af",
  fmt(
    "{} => {}",
    {
      i(1, ""),
      i(2, "")
    }
  )
)
cs(
  "cafb",
  fmt(
    [[
const {} = {} => {{
  {}
}}
    ]],
    {
      i(1, ""),
      i(2, ""),
      i(3, "")
    }
  )
)
cs(
  "afb",
  fmt(
    [[
{} => {{
  {}
}}
    ]],
    {
      i(1, ""),
      i(2, "")
    }
  )
)
cs(
  "cod",
  fmt(
    [[
const {{ {2} }} = {1}
    ]],
    {
      i(1, ""),
      i(2, "")
    }
  )
)
cs(
  "im",
  fmt(
    [[
import {2} from '{1}'
    ]],
    {
      i(1, ""),
      c(2, {
        sn(1, {
          t("{ "),
          i(1, ""),
          t(" }")
        }),
        i(2, "")
      })
    }
  )
)
cs(
  "rfc",
  fmt(
    [[
import React from 'react'

function {}({}) {{
  return (
    <>
      {}
    </>
  )
}}

export default {}
    ]],
    {
      sn(1,
        f(function(_, snip)
          local name = vim.split(snip.snippet.env.TM_FILENAME, ".", true)
          return name[1]
        end)
      ),
      c(2, {
        i(1, ""),
        i(2, "props")
      }),
      i(3, ""),
      rep(1)
    }
  )
)
cs(
  "uS",
  fmt(
    [[
const [{}, {}] = useState({})
    ]],
    {
      i(1, ""),
      f(function(args)
        local name = args[1][1]
        local first = string.upper(string.sub(name, 1, 1))
        local rest = string.sub(name, 2, -1)
        return "set" .. first .. rest
      end, { 1 }
      ),
      i(2, "")
    }
  )
)
cs(
  "od",
  fmt(
    [[
{{ {2} }} = {1}
    ]],
    {
      i(1, ""),
      i(2, "")
    }
  )
)
cs(
  { trig = "for([%w_]+)", regTrig = true, hidden = true },
  fmt(
    [[
for (let {} = 0; {} < {}; {}++) {{
  {}
}}
    ]],
    {
      d(1, function(_, snip)
        return sn(1, i(1, snip.captures[1]))
      end),
      rep(1),
      c(2, {
        i(1, "num"),
        sn(1, {
          i(1, "arr"),
          t(".length")
        })
      }),
      rep(1),
      i(3, "// TODO:"),
    }
  )
)
cs(
  "re",
  fmt(
    [[
const {2} = require('{1}')
    ]],
    {
      i(1, ""),
      c(2, {
        sn(1, {
          t("{ "),
          i(1, ""),
          t(" }")
        }),
        i(1, "")
      })
    }
  )
)
cs(
  "tc",
  fmt(
    [[
try {{
  {}
}} catch (err) {{
  {}
}}
    ]],
    {
      i(1, ""),
      i(2, "")
    }
  )
)
cs(
  "wh",
  fmt(
    [[
while ({}) {{
  {}
}}
    ]],
    {
      i(1, ""),
      i(2, ""),
    }
  )
)
cs("cl", fmt("console.log({})", { i(1, "") })) -- console.log

return snippets, autosnippets
