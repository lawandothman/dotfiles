return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        theme = 'rose-pine',
        icons_enabled = true,
        always_divide_middle = true,
        globalstatus = true,
        component_separators = '|',
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'dashboard', 'NvimTree', 'neo-tree' },
        },
        ignore_focus = { 'NvimTree', 'NeoTree', 'neo-tree' },
        refresh = {
          statusline = 1000,
        },
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = { { 'filename', file_status = false, path = 1 }, 'branch' },
        lualine_c = { 'diff' },
        lualine_x = { { 'copilot', 'diagnostics', sources = { 'nvim_diagnostic', 'coc' } } },
        lualine_y = { 'filetype', '%p%%/%L' },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {},
      tabline = {},
      extensions = {
        'nvim-tree',
        'neo-tree',
        'fugitive',
        'toggleterm',
      },
    }
    vim.opt.showmode = false
  end,
}
