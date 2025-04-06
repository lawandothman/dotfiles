return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'html',
        'javascript',
        'json',
        'lua',
        'markdown',
        'tsx',
        'hcl',
        'typescript',
        'rust',
        'toml',
        'terraform',
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
  end,
}
