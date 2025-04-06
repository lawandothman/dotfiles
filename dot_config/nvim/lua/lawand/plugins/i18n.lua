return {
  'nabekou29/js-i18n.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    translation_source = { '**/i18n/**/*.json' },
    primary_language = { 'en-GB' },
    virt_text = {
      enabled = true,
      conceal_key = true,
    },
  },
}
