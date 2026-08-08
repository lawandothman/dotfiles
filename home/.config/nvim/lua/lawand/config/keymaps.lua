-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Remap jj and jk to escape in insert mode
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, desc = 'Exit insert mode with jj' })
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, desc = 'Exit insert mode with jk' })

-- Keep the cursor centered on every large jump. Normal mode only: mapping these
-- in operator-pending would turn `d}` into `d}zz`. The search keys use `zzzv`
-- so a match inside a closed fold opens it instead of landing on the fold line.
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })
vim.keymap.set('n', '*', '*zzzv', { desc = 'Search word under cursor forward (centered)' })
vim.keymap.set('n', '#', '#zzzv', { desc = 'Search word under cursor backward (centered)' })
vim.keymap.set('n', 'gg', 'ggzz', { desc = 'Start of file (centered)' })
vim.keymap.set('n', 'G', 'Gzz', { desc = 'End of file (centered)' })
vim.keymap.set('n', '{', '{zz', { desc = 'Previous paragraph (centered)' })
vim.keymap.set('n', '}', '}zz', { desc = 'Next paragraph (centered)' })
vim.keymap.set('n', '%', '%zz', { desc = 'Matching bracket (centered)' })
vim.keymap.set('n', '<C-o>', '<C-o>zz', { desc = 'Jump back (centered)' })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { desc = 'Jump forward (centered)' })

-- Move selected line / block of text in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- On S rather than <leader>s so the <leader>s search namespace has no leaf
-- competing with it. Word-anchored, unlike the usual version of this mapping.
vim.keymap.set('n', 'S', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[S]ubstitute word under cursor' })
vim.keymap.set('x', '<leader>p', [["_dP]])

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps. goto_prev/goto_next are deprecated and removed in 0.13;
-- vim.diagnostic.jump replaces them but does not default `float` to true, so it
-- is passed explicitly to keep the popup on arrival.
local function diagnostic_jump(count)
  return function()
    vim.diagnostic.jump { count = count, float = true }
    vim.cmd 'normal! zz'
  end
end

vim.keymap.set('n', '[d', diagnostic_jump(-1), { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', diagnostic_jump(1), { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', ']q', '<cmd>cnext<CR>zz', { desc = 'Next [Q]uickfix item' })
vim.keymap.set('n', '[q', '<cmd>cprevious<CR>zz', { desc = 'Previous [Q]uickfix item' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open Oil' })

vim.keymap.set('n', '<leader>t', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 5)
end, { desc = 'Open [T]erminal split' })

vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })
