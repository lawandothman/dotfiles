return {
  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },

  -- GitHub Copilot
  { 'github/copilot.vim' },

  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  { 'windwp/nvim-ts-autotag', opts = {} },
  {
    'stevearc/dressing.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
    config = function()
      require('dressing').setup()
    end,
  },
  {
    'mbbill/undotree',
    keys = {
      {
        '<leader>gu',
        ':UndotreeToggle<CR>',
        desc = 'Toggle UndoTree',
      },
    },
  },
}
