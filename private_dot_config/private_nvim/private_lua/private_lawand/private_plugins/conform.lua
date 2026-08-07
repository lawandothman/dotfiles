-- Registered outside the lazy spec so format-on-save can be toggled off before
-- conform itself has loaded.
vim.api.nvim_create_user_command('ConformDisable', function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable format-on-save (! for the current buffer only)',
  bang = true,
})

vim.api.nvim_create_user_command('ConformEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable format-on-save',
})

-- Gate each web formatter on the project actually configuring it, so the chain
-- resolves to a single formatter per repo rather than running biome everywhere.
local function has_config(filenames)
  return function(_, ctx)
    return vim.fs.find(filenames, {
      path = ctx.filename,
      upward = true,
      stop = vim.uv.os_homedir(),
    })[1] ~= nil
  end
end

return {
  'stevearc/conform.nvim',
  -- BufWritePre is what actually loads conform on save; without it `keys` would
  -- be the only trigger and format_on_save would never fire on its own.
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      desc = 'Format buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    formatters_by_ft = {
      javascript = { 'oxfmt', 'biome-check', stop_after_first = true },
      javascriptreact = { 'oxfmt', 'biome-check', stop_after_first = true },
      typescript = { 'oxfmt', 'biome-check', stop_after_first = true },
      typescriptreact = { 'oxfmt', 'biome-check', stop_after_first = true },
      json = { 'biome-check' },
      jsonc = { 'biome-check' },
      rust = { 'rustfmt' },
      lua = { 'stylua' },
    },
    formatters = {
      oxfmt = {
        condition = has_config { '.oxfmtrc.json', '.oxfmtrc.jsonc' },
      },
      ['biome-check'] = {
        condition = has_config { 'biome.json', 'biome.jsonc', '.biome.json', '.biome.jsonc' },
      },
    },
  },
}
