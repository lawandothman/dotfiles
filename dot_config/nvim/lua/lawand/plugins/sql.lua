local sql_ft = { 'sql', 'mysql', 'plsql' }

return {
  {
    'jsborjesson/vim-uppercase-sql',
    lazy = true,
    ft = sql_ft,
  },

  {
    'tpope/vim-dadbod',
    lazy = true,
    dependencies = {
      'kristijanhusak/vim-dadbod-ui',
      { 'kristijanhusak/vim-dadbod-completion', ft = sql_ft, lazy = true },
    },
    config = function()
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_save_location = '~/dbui/saved_queries'
      vim.g.db_ui_tmp_query_location = '~/dbui/queries'
    end,
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
  },
}
