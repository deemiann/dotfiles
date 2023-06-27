local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "toml",
    "fish",
    "php",
    "http",
    "json",
    "yaml",
    "swift",
    "css",
    "html",
    "lua"
  },
  autotag = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = { "#CC8888", "#CCCC88", "#88CC88", "#88CCCC", "#8888CC", "#CC88CC" }, -- table of hex strings
  }
}
local rainbow = {
  "#CC8888",
  "#CCCC88",
  "#88CC88",
  "#88CCCC",
  "#8888CC",
  "#CC88CC",
  "#888888",
}

require "nvim-treesitter.configs".setup {
  rainbow = { colors = rainbow, termcolors = rainbow }
}
for i, c in ipairs(rainbow) do -- p00f/rainbow#81
  --vim.cmd(("hi rainbowcol%d guifg=%s gui=bold"):format(i, c))
  vim.cmd(("hi rainbowcol%d guifg=%s"):format(i, c))
  vim.cmd(("hi IndentBlanklineIndent%d guifg=%s gui=nocombine"):format(i, c))
end

--local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
--parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
