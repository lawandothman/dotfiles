-- vim-herdr-navigation — Neovim side, from paulbkim-dev/vim-herdr-navigation.
--
-- Move between Neovim splits, and at a split edge hand off to Herdr so focus
-- crosses into the neighbouring pane. Lives in after/plugin so it wins over any
-- other <C-h/j/k/l> mapping.

local function nav(wincmd, dir)
  local prev = vim.api.nvim_get_current_win()
  vim.cmd('wincmd ' .. wincmd)
  if vim.api.nvim_get_current_win() ~= prev then
    return
  end

  if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= '' then
    local herdr = vim.env.HERDR_BIN_PATH
    if herdr == nil or herdr == '' then
      herdr = 'herdr'
    end
    -- --pane, not --current: --current resolves to the server's globally
    -- focused pane, which is not necessarily the one this Neovim is in.
    vim.fn.system { herdr, 'pane', 'focus', '--direction', dir, '--pane', vim.env.HERDR_PANE_ID }
  end
end

local function map(lhs, wincmd, dir, desc)
  vim.keymap.set('n', lhs, function()
    nav(wincmd, dir)
  end, { silent = true, noremap = true, desc = desc })
end

map('<C-h>', 'h', 'left', 'Navigate left (Vim/Herdr)')
map('<C-j>', 'j', 'down', 'Navigate down (Vim/Herdr)')
map('<C-k>', 'k', 'up', 'Navigate up (Vim/Herdr)')
map('<C-l>', 'l', 'right', 'Navigate right (Vim/Herdr)')
