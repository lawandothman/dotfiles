return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'tailwind-tools',
    'onsails/lspkind-nvim',
  },
  config = function()
    local cmp = require 'cmp'
    local lspkind = require 'lspkind'
    local tailwind_tools = require 'tailwind-tools.cmp'

    local kind_icons = {
      Text = '',
      Method = '󰆧',
      Function = '󰊕',
      Constructor = '',
      Field = '󰇽',
      Variable = '󰂡',
      Class = '󰠱',
      Interface = '',
      Module = '',
      Property = '󰜢',
      Unit = '',
      Value = '󰎠',
      Enum = '',
      Keyword = '󰌋',
      Snippet = '',
      Color = '󰏘',
      File = '󰈙',
      Reference = '',
      Folder = '󰉋',
      EnumMember = '',
      Constant = '󰏿',
      Struct = '',
      Event = '',
      Operator = '󰆕',
      TypeParameter = '󰅲',
    }

    cmp.setup {
      snippet = {},
      completion = { completeopt = 'menu,menuone,noinsert' },
      mapping = cmp.mapping.preset.insert {
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = {
        { name = 'copilot' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
      },
      formatting = {
        format = lspkind.cmp_format {
          mode = 'symbol_text',
          maxwidth = 50,
          before = tailwind_tools.lspkind_format, -- Integration with Tailwind highlighting
          symbol_map = kind_icons,
        },
      },
    }
  end,
}
