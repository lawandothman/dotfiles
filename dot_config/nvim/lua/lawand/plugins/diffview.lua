return {
  {
    -- NOTE: jump between diffs with ]c and [c (vim built in), see :h jumpto-diffs
    'sindrets/diffview.nvim',
    lazy = true,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      -- icons supported via mini-icons.lua
    },

    opts = {

      -- file_panel = {
      --   win_config = {
      --     position = "bottom",
      --   },
      -- },

      default = {
        disable_diagnostics = false,
      },
      view = {
        merge_tool = {
          disable_diagnostics = false,
          winbar_info = true,
        },
      },
      enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
      hooks = {
        -- do not fold
        diff_buf_win_enter = function(bufnr)
          vim.opt_local.foldenable = false
        end,

        -- TODO: jump to first diff: https://github.com/sindrets/diffview.nvim/issues/440
        -- TODO: enable diagnostics in diffview
      },
    },

    config = function(_, opts)
      local actions = require 'diffview.actions'

      require('diffview').setup(opts)
    end,
    keys = {
      { '<leader>gdc', ':DiffviewOpen origin/main...HEAD', desc = 'Compare commits' },
      { '<leader>gdq', ':DiffviewClose<CR>', desc = 'Close Diffview tab' },
      { '<leader>gdh', ':DiffviewFileHistory %<CR>', desc = 'File history' },
      { '<leader>gdH', ':DiffviewFileHistory<CR>', desc = 'Repo history' },
      { '<leader>gdm', ':DiffviewOpen<CR>', desc = 'Solve merge conflicts' },
      { '<leader>gdo', ':DiffviewOpen main', desc = 'DiffviewOpen' },
      { '<leader>gdt', ':DiffviewOpen<CR>', desc = 'DiffviewOpen this' },
      { '<leader>gdp', ':DiffviewOpen origin/main...HEAD --imply-local', desc = 'Review current PR' },
      {
        '<leader>gdP',
        ':DiffviewFileHistory --range=origin/main...HEAD --right-only --no-merges --reverse',
        desc = 'Review current PR (per commit)',
      },
    },
  },
}
