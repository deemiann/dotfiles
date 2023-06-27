local keymap = vim.keymap

-- keymap.set('n', 'x', '"_x')

local opts = { noremap = true, silent = true }
-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')
keymap.set('n', ';w', ':w<CR>', opts)
keymap.set('n', ';q', ':q<CR>', opts)
keymap.set('n', ';bd', ':bd<CR>', opts)
keymap.set('n', ';bn', ':bn<CR>', opts)
keymap.set('n', 'gR', '<Plug>RestNvim', opts)
keymap.set('n', ';so', ':so ~/.config/nvim/init.lua<CR>', opts)
keymap.set('n', 'tr', ':TSToggle rainbow<CR>', opts)
keymap.set('n', 'ti', ':IndentBlanklineToggle<CR>', opts)
keymap.set('i', 'jk', '<Esc>')
keymap.set('n', 'J', '10<C-e>')
keymap.set('n', 'K', '10<C-y>')


vim.keymap.set({ "i", "s" }, "<a-o>", "<Esc>o", { silent = true })
vim.keymap.set({ "i", "s" }, "<a-a>", "<Esc>A", { silent = true })

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap.set('n', 'te', ':tabedit<CR>')
-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
-- Move window
keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')
