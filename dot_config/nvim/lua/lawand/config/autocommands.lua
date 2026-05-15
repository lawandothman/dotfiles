-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set conceallevel for JS/TS files
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

-- Workaround for Neovim 0.12 bug where vim.lsp.enable attaches to artificial
-- buffers (diffview://, fugitive://) and sends "file://." as workspace URI.
-- See: https://github.com/neovim/neovim/issues/33061
vim.lsp.config('*', {
  before_init = function(params)
    local bad = 'file://.'
    if type(params.rootUri) == 'string' and params.rootUri:find(bad, 1, true) then
      params.rootUri = vim.uri_from_fname(vim.fn.getcwd())
    end
    if type(params.workspaceFolders) == 'table' then
      for i, folder in ipairs(params.workspaceFolders) do
        if type(folder.uri) == 'string' and folder.uri:find(bad, 1, true) then
          local cwd = vim.fn.getcwd()
          params.workspaceFolders[i] = { uri = vim.uri_from_fname(cwd), name = cwd }
        end
      end
    end
  end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})
