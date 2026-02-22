return {
  'stevearc/conform.nvim',
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      desc = 'Format buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      javascript = { 'biome-check', 'biome' },
      typescript = { 'biome-check', 'biome' },
      javascriptreact = { 'biome-check', 'biome' },
      typescriptreact = { 'biome-check', 'biome' },
      json = { 'biome-check', 'biome' },
      jsonc = { 'biome-check', 'biome' },
      rust = { 'rustfmt' },
      lua = { 'stylua' },
    },
  },
}
