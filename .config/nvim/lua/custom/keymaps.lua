-- Insert lines without leaving normal mode
vim.keymap.set('n', '<leader>o', 'o<Esc>0_Dk')
vim.keymap.set('n', '<leader>O', 'O<Esc>0_Dj')

-- Save on CRTL-s
vim.keymap.set({ 'n', 'i' }, '<C-s>', '<cmd>w<CR>')

-- Close current buffer
vim.keymap.set('n', '<leader>x', '<cmd>bd<CR>', { desc = "Close current buffer" })

-- Move in insert mode
vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Move left' })
vim.keymap.set('i', '<C-j>', '<Down>', { desc = 'Move down' })
vim.keymap.set('i', '<C-k>', '<Up>', { desc = 'Move up' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Move right' })

-- Center view after jump
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Jump half page down and center view' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Jump half page up and center view' })

-- Move lines in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Dont copy replaced text
vim.keymap.set('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Paste without copy" })

-- New Buffer
vim.keymap.set('n', '<leader>b', '<cmd>enew<CR>', { desc = 'New Buffer' })

-- Fix curser Position
vim.keymap.set('n', 'J', 'mzJ`z')

-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Git status
vim.keymap.set('n', '<leader>gs', '<cmd>Git<CR>', { desc = '[G]it [S]tatus' })
