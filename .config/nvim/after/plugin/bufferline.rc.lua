local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

local fg = "#ebdbb2"
local fg4 = "#a89984"
local bg0 = "#282828"
local bg1 = "#3c3836"

bufferline.setup({
  options = {
    mode = "tabs",
    separator_style = 'slant',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true
  },
  highlights = {
    separator = {
      fg = bg1,
      bg = bg0,
    },
    separator_selected = {
      fg = bg1,
    },
    background = {
      fg = fg4,
      bg = bg0
    },
    buffer_selected = {
      fg = fg,
      bold = true,
    },
    fill = {
      bg = bg1
    },
    modified = {
      bg = bg0
    }
  },
})

vim.keymap.set('n', 'tn', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', 'tp', '<Cmd>BufferLineCyclePrev<CR>', {})
