return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  event = 'VeryLazy',
  keys = {
    -- { '<leader>e', ':Neotree toggle float<CR>', silent = true, desc = 'Float File Explorer' },
    { '<leader><Tab>', ':Neotree toggle right<CR>', silent = true, desc = 'Right File Explorer' },
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      popup_border_style = 'single',
      enable_git_status = true,
      enable_modified_markers = true,
      enable_diagnostics = true,
      sort_case_insensitive = true,
      default_component_configs = {
        indent = {
          with_markers = true,
          with_expanders = true,
        },
        modified = {
          symbol = ' ',
          highlight = 'NeoTreeModified',
        },
        git_status = {
          symbols = {
            -- Change type
            added = '',
            deleted = '',
            modified = '',
            renamed = '',
            -- Status type
            untracked = '',
            ignored = '',
            unstaged = '',
            staged = '',
            conflict = '',
          },
        },
      },
      window = {
        position = 'right',
        width = 35,
      },
      filesystem = {
        use_libuv_file_watcher = true,
        hijack_netrw_behavior = 'disabled',
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            'node_modules',
            '.git',
          },
          never_show = {
            '.DS_Store',
            'thumbs.db',
          },
        },
      },
      source_selector = {
        winbar = true,
        sources = {
          { source = 'filesystem', display_name = '   Files ' },
          { source = 'buffers', display_name = '   Bufs ' },
          { source = 'git_status', display_name = '   Git ' },
        },
      },
      event_handlers = {
        {
          event = 'neo_tree_window_after_open',
          handler = function(args)
            if args.position == 'left' or args.position == 'right' then
              vim.cmd 'wincmd ='
            end
          end,
        },
        {
          event = 'neo_tree_window_after_close',
          handler = function(args)
            if args.position == 'left' or args.position == 'right' then
              vim.cmd 'wincmd ='
            end
          end,
        },
      },
    }
  end,
}
