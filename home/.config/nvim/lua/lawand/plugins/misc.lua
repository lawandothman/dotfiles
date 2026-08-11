return {
  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },

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
  { 'windwp/nvim-ts-autotag', event = { 'BufReadPre', 'BufNewFile' }, opts = {} },
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
