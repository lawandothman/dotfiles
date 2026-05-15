---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(fname, { 'pnpm-workspace.yaml', 'package.json' })
    if root then
      on_dir(root)
    end
  end,
  settings = {
    tailwindCSS = {
      experimental = {
        configFile = 'packages/design-system/src/globals.css',
        classRegex = {
          { 'cva\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
          { 'cx\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
          { 'cn\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
          { 'clsx\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
          { 'twMerge\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
        },
      },
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
      },
    },
  },
}
