require("base")
require("highlights")
require("maps")
require("plugins")

vim.opt.clipboard:append { 'unnamedplus' }

vim.o.background = "dark" -- or "light" for light mode

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx" },
  callback = function()
    vim.cmd('EslintFixAll')
  end
})
