return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'html',
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'tsx',
        'hcl',
        'typescript',
        'rust',
        'toml',
        'terraform',
        'prisma',
        'yaml',
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    }
  end,
}
