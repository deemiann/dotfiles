local status, luasnip = pcall(require, "luasnip")
if (not status) then return end

-- require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
require("luasnip").config.setup({ store_selection_keys = "<A-p>" })

vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]) --}}}

-- Virtual Text{{{
local types = require("luasnip.util.types")
luasnip.config.set_config({
  history = true, --keep around last snippet local to jump back
  updateevents = "TextChanged,TextChangedI", --update changes as you type
  enable_autosnippets = true,
}) --}}}

-- Key Mapping --{{{

vim.keymap.set({ "i", "s" }, "<TAB>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<a-l>", function()
  if luasnip.jumpable(1) then
    luasnip.jump(1)
  end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<a-h>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<a-k>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)
vim.keymap.set({ "i", "s" }, "<a-j>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(-1)
  end
end) --}}}

-- More Settings --

vim.cmd([[autocmd BufEnter */snippets/*.lua nnoremap <silent> <buffer> <CR> /-- End Refactoring --<CR>O<Esc>O]])
