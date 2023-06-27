local status, indent = pcall(require, "indent_blankline")
if (not status) then return end

indent.setup {
  indent_blankline_char = '▏',
  space_char_blankline = " ",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
    "IndentBlanklineIndent7",
  },
}

--vim.cmd([[let g:indent_blankline_char = '▎']])
vim.cmd([[let g:indent_blankline_char = '▏']])
