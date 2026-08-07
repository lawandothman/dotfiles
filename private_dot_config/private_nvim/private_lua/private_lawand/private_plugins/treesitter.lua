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

    -- On the main branch, treesitter indentation is opt-in (and flagged
    -- experimental upstream) — without setting indentexpr, `=`, `o` and paste
    -- fall back to Vim's bundled per-filetype indent scripts. Only enable it
    -- where a parser and an `indents` query both exist, so filetypes without
    -- one keep the builtin indentexpr rather than losing indentation entirely.
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('lawand-treesitter', { clear = true }),
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)

        if not vim.treesitter.get_parser(args.buf, nil, { error = false }) then
          return
        end

        local language = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if not language then
          return
        end

        local ok, query = pcall(vim.treesitter.query.get, language, 'indents')
        if ok and query then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
