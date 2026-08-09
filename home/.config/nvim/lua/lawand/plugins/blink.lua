return {
  'saghen/blink.cmp',
  event = 'VeryLazy',
  version = '1.*',
  opts = {
    keymap = {
      preset = 'none',
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<Tab>'] = { 'select_and_accept', 'fallback' },
      ['<C-Space>'] = { 'show', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-c>'] = { 'cancel', 'fallback' },
    },

    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
    },

    -- Score offsets keep real LSP results above buffer-word noise: buffer and
    -- path can never outrank an LSP item, and buffer stays hidden until three
    -- characters have been typed.
    sources = {
      default = { 'lsp', 'path', 'buffer' },
      providers = {
        lsp = { score_offset = 1000 },
        path = { score_offset = 3 },
        buffer = { score_offset = -150, min_keyword_length = 3 },
      },
    },

    signature = {
      enabled = true,
      trigger = {
        show_on_trigger_character = false,
        show_on_insert_on_trigger_character = false,
      },
      window = {
        border = 'rounded',
        show_documentation = true,
      },
    },

    completion = {
      trigger = {
        show_on_trigger_character = true,
      },
      menu = {
        border = 'rounded',
        max_height = 10,
        auto_show = true,
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'source_name' },
          },
          components = {
            source_name = {
              text = function(ctx)
                local names = {
                  lsp = 'LSP',
                  buffer = 'Buffer',
                  path = 'Path',
                }
                return '[' .. (names[ctx.source_name] or ctx.source_name) .. ']'
              end,
              highlight = 'Comment',
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        window = { border = 'rounded' },
      },
      ghost_text = { enabled = true },
      list = {
        selection = { preselect = true },
      },
      accept = {
        auto_brackets = { enabled = true },
      },
    },
  },
}
