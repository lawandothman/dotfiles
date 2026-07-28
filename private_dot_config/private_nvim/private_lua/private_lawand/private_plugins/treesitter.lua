return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup {}

    require('nvim-treesitter').install {
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
    }

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
