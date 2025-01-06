return {
  'luckasRanarison/tailwind-tools.nvim',
  name = 'tailwind-tools',
  build = ':UpdateRemotePlugins',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim',
    'neovim/nvim-lspconfig',
  },
  opts = {
    server = {
      override = true,
    },
    document_color = {
      enabled = true,
      kind = 'inline',
    },
    cmp = {
      highlight = 'foreground',
    },
    extension = {
      patterns = {
        javascript = { 'clsx%(([^)]+)%)' },
      },
    },
  },
  config = function(_, opts)
    require('tailwind-tools').setup(opts)
  end,
}
