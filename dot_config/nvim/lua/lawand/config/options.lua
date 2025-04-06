-- [[Settings]] --
-- `:help vim.opt`
--  For more options, you can see `:help option-list`

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_netrw = 1 -- Disable netrw
vim.g.loaded_netrwPlugin = 1 -- Disable netrw

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Disable line wrapping
vim.opt.wrap = false

-- Enable mouse support
vim.opt.mouse = 'a'

-- Clipboard
vim.opt.clipboard = 'unnamedplus' -- `:help 'clipboard'`

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

-- Keep JSON files unconcealed
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'json',
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Search
--
-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Others
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.completeopt = 'menuone,noselect'
vim.opt.termguicolors = true

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Don't show the command keys in the bottom right corner
vim.opt.showcmd = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

vim.opt.backup = false -- Creates a backup file
vim.opt.swapfile = false
vim.opt.colorcolumn = '80'

vim.opt.fillchars = { eob = ' ' }

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

if vim.fn.getenv 'TERM_PROGRAM' == 'ghostty' then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end
