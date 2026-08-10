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

-- Diagnostic keymaps. goto_prev/goto_next were deprecated and are removed in
-- 0.13; vim.diagnostic.jump replaces them. No float on arrival —
-- tiny-inline-diagnostic renders the message at the cursor. <leader>d still
-- opens one on demand.
local function diagnostic_jump(count, severity)
  return function()
    vim.diagnostic.jump { count = count, severity = severity }
    vim.cmd 'normal! zz'
  end
end

local severity = vim.diagnostic.severity

vim.keymap.set('n', '[d', diagnostic_jump(-1), { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', diagnostic_jump(1), { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '[e', diagnostic_jump(-1, severity.ERROR), { desc = 'Go to previous [E]rror' })
vim.keymap.set('n', ']e', diagnostic_jump(1, severity.ERROR), { desc = 'Go to next [E]rror' })
vim.keymap.set('n', '[w', diagnostic_jump(-1, severity.WARN), { desc = 'Go to previous [W]arning' })
vim.keymap.set('n', ']w', diagnostic_jump(1, severity.WARN), { desc = 'Go to next [W]arning' })
vim.keymap.set('n', ']q', '<cmd>cnext<CR>zz', { desc = 'Next [Q]uickfix item' })
vim.keymap.set('n', '[q', '<cmd>cprevious<CR>zz', { desc = 'Previous [Q]uickfix item' })
vim.keymap.set('n', '<leader>d', function()
  vim.diagnostic.open_float { border = 'rounded' }
end, { desc = 'Show diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', 'H', '^', { desc = 'Jump to beginning of line' })
vim.keymap.set('n', 'L', '$', { desc = 'Jump to end of line' })
vim.keymap.set('x', 'H', '^', { desc = 'Move to beginning of line' })
-- $<Left> stops one short of the newline; a bare $ makes vLd join the next line.
vim.keymap.set('x', 'L', '$<Left>', { desc = 'Move to end of line' })

vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo last change' })

vim.keymap.set('n', '<leader>e', function()
  require('oil').toggle_float()
end, { desc = 'Open Oil' })

vim.keymap.set('n', '<leader>t', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 5)
end, { desc = 'Open [T]erminal split' })

vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })
