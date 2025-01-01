return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'bash',
        'c',
        'css',
        'gleam',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'graphql',
        'html',
        'blade',
        'javascript',
        'json',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'rust',
        'toml',
        'terraform',
        'proto',
        'prisma',
        'yaml',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = { enable = true },
      -- Add this
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      },
    }

    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = 'https://github.com/EmranMR/tree-sitter-blade',
        files = { 'src/parser.c' },
        branch = 'main',
      },
      filetype = 'blade',
    }

    vim.filetype.add {
      pattern = {
        ['.*%.blade%.php'] = 'blade',
      },
    }
  end,
}
