return {
  {
    -- NOTE: jump between diffs with ]c and [c (vim built in), see :h jumpto-diffs
    'sindrets/diffview.nvim',
    lazy = true,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
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
      },
    },

    config = function(_, opts)
      require('diffview').setup(opts)
    end,
    -- Flat namespace: every <leader>g* entry is a leaf, so none of them stall
    -- waiting to see whether a longer sequence is coming.
    keys = {
      { '<leader>gd', ':DiffviewOpen<CR>', desc = 'Diff view (working copy)' },
      { '<leader>gc', ':DiffviewClose<CR>', desc = 'Close diff view' },
      { '<leader>gh', ':DiffviewFileHistory %<CR>', desc = 'File history (current)' },
      { '<leader>gH', ':DiffviewFileHistory<CR>', desc = 'File history (repo)' },
      { '<leader>go', ':DiffviewOpen main', desc = 'Diff against a ref' },
      { '<leader>gp', ':DiffviewOpen origin/main...HEAD --imply-local', desc = 'Review current PR' },
      {
        '<leader>gP',
        ':DiffviewFileHistory --range=origin/main...HEAD --right-only --no-merges --reverse',
        desc = 'Review current PR (per commit)',
      },
    },
  },
}
