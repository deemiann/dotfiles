local status, gruvbox = pcall(require, 'gruvbox')
if (not status) then return end

gruvbox.setup({
  contrast = "hard",
  overrides = {
    String = { italic = false },
    CursorLine = { bg = "#282828" },
    CursorColumn = { bg = "#282828" },
    ColorColumn = { bg = "#282828" },
    SignColumn = { bg = "#282828" },
    CursorLineNr = { bg = "#282828" },
    GruvboxRedSign = { bg = "#282828" },
    GruvboxGreenSign = { bg = "#282828" },
    GruvboxYellowSign = { bg = "#282828" },
    GruvboxBlueSign = { bg = "#282828" },
    GruvboxPurpleSign = { bg = "#282828" },
    GruvboxAquaSign = { bg = "#282828" },
    GruvboxOrangeSign = { bg = "#282828" },
  }
})

vim.cmd([[colorscheme gruvbox]])
