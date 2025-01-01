local function biome_lsp_or_prettier(bufnr)
  local biome_lsp_client = vim.lsp.get_clients({
    bufnr = bufnr,
    name = 'biome',
  })[1]

  if biome_lsp_client then
    return { 'biome-check', 'biome' } -- Use LSP formatting when Biome LSP is active
  end

  local prettier_config = vim.fs.find({
    -- Prettier configuration files
    '.prettierrc',
    '.prettierrc.json',
    '.prettierrc.yml',
    '.prettierrc.yaml',
    '.prettierrc.json5',
    '.prettierrc.js',
    '.prettierrc.cjs',
    '.prettierrc.toml',
    'prettier.config.js',
    'prettier.config.cjs',
  }, { upward = true })[1]

  if prettier_config then
    return { 'prettier' } -- Use Prettier if config is found
  end

  print 'No Prettier configuration found, falling back to Biome LSP'
  return { 'biome-check', 'biome' } -- Fallback to Biome CLI tools
end

return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
      vim.keymap.set('', '<leader>f', function()
        require('conform').format { async = true, lsp_fallback = true }
      end),
    },
    formatters = {
      prettierd = {
        require_cwd = true,
      },
    },
    formatters_by_ft = {
      javascript = biome_lsp_or_prettier,
      typescript = biome_lsp_or_prettier,
      javascriptreact = biome_lsp_or_prettier,
      typescriptreact = biome_lsp_or_prettier,
      json = { 'biome-check', 'biome' },
      jsonc = { 'biome-check', 'biome' },
      blade = { 'blade-formatter' },
      rust = { 'rustfmt' },
      lua = { 'stylua' },
      php = { 'pint' },
    },
  },
}
