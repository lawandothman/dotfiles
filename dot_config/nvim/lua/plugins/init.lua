-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins, run :Lazy update
--
require('lazy').setup {

  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },
  --
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- GitHub Copilot
  { 'github/copilot.vim' },
  --
  -- Telescope
  { import = 'plugins.telescope' },

  { import = 'plugins.diffview' },
  --
  -- DAP (Debug Adapter Protocol)
  { import = 'plugins.dap' },

  -- LSP and Autocompletion
  { import = 'plugins.lsp' },
  { import = 'plugins.cmp' },

  -- Treesitter
  { import = 'plugins.treesitter' },

  -- Alpha Dashboard (Start Screen)
  { import = 'plugins.alpha' },

  -- File Tree
  -- { import = 'plugins.neotree' },

  -- Lua Line (Status Line)
  { import = 'plugins.lualine' },

  -- Colorscheme
  { import = 'plugins.colorscheme' },

  -- Formatting
  { import = 'plugins.conform' },
  --
  -- Git
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    config = function()
      require('gitsigns').setup()

      vim.keymap.set('n', '<leader>gt', ':Gitsigns toggle_current_line_blame<CR>', {})
    end,
  },
  {
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = false,
      float = {
        max_width = 150,
      },
      view_options = {
        show_hidden = true,
      },
    },
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  },
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      signs = false,
    },
  },

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
  {
    'joosepalviste/nvim-ts-context-commentstring',
    lazy = true,
  },
  {
    'stevearc/dressing.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
    config = function()
      require('dressing').setup()
    end,
  },
  {
    'sindrets/diffview.nvim',
    event = 'VeryLazy',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
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
  {
    'pmizio/typescript-tools.nvim',
    event = 'BufReadPre',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
    config = function()
      require('typescript-tools').setup {
        settings = {
          separate_diagnostic_server = true,
          expose_as_code_action = 'all',
          -- tsserver_plugins = {},
          tsserver_max_memory = 'auto',
          complete_function_calls = true,
          include_completions_with_insert_text = true,
          tsserver_file_preferences = {
            includeInlayParameterNameHints = 'all', -- "none" | "literals" | "all";
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            includeCompletionsForModuleExports = true,
            quotePreference = 'auto',
            -- autoImportFileExcludePatterns = { "node_modules/*", ".git/*" },
          },
          tsserver_path = './node_modules/typescript/lib/tsserver.js',
        },
      }
    end,
  },
  {
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
  },
  {
    'neoclide/coc.nvim',
    branch = 'release',
    ft = 'prisma',
  },
}
