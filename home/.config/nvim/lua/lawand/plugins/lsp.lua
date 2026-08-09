return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
    { 'j-hui/fidget.nvim', opts = {} },
  },

  config = function()
    -- Servers we want Mason to install AND that we enable via the native LSP API.
    -- Per-server settings live in ~/.config/nvim/lsp/<server>.lua and are merged
    -- on top of the defaults shipped by nvim-lspconfig.
    local servers = {
      'biome',
      'gopls',
      'jsonls',
      'lua_ls',
      'prismals',
      'rust_analyzer',
      'sqls',
      'tailwindcss',
      'taplo',
      'terraformls',
      'yamlls',
    }

    -- Shared client capabilities (extended by blink.cmp).
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Apply capabilities to every LSP client. Merges with any other `*`
    -- defaults (see config/autocommands.lua for the workspace-URI workaround).
    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    -- TypeScript 7 native LSP: `tsc --lsp --stdio` from a global
    -- `npm install -g typescript` (typescript >= 7; the tsgo binary is gone in
    -- stable). Overrides the cmd function in nvim-lspconfig's bundled
    -- lsp/tsgo.lua, which still spawns the old `tsgo` binary.
    vim.lsp.config('tsgo', {
      cmd = { 'tsc', '--lsp', '--stdio' },
    })

    require('mason').setup()

    -- Mason installs the LSP binaries plus formatters/linters.
    require('mason-tool-installer').setup {
      ensure_installed = vim.list_extend(vim.deepcopy(servers), {
        'stylua', -- Lua formatter
        'oxfmt', -- JS/TS formatter
      }),
    }

    -- We enable servers explicitly below, so disable mason-lspconfig's
    -- automatic enable behaviour for full predictability.
    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_enable = false,
    }

    -- Start each server, plus tsgo (the TypeScript 7 native LSP). tsgo stays
    -- out of the Mason list because Mason's registry still ships the
    -- superseded @typescript/native-preview build; the binary comes from a
    -- global `npm install -g typescript` instead.
    vim.lsp.enable(vim.list_extend({ 'tsgo' }, servers))

    vim.diagnostic.config {
      severity_sort = true,
      update_in_insert = false,
      float = {
        border = 'rounded',
        source = 'if_many',
      },
      underline = true,
      virtual_text = {
        spacing = 2,
        source = 'if_many',
        prefix = '●',
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = 'E',
          [vim.diagnostic.severity.WARN] = 'W',
          [vim.diagnostic.severity.INFO] = 'I',
          [vim.diagnostic.severity.HINT] = 'H',
        },
      },
    }

    -- Buffer-local LSP keymaps and document highlight on attach.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lawand-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local builtin = require 'telescope.builtin'

        map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
        map('gr', builtin.lsp_references, '[G]oto [R]eferences')
        map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
        map('<leader>bs', builtin.lsp_document_symbols, '[B]uffer [S]ymbols')
        map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('gh', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_group = vim.api.nvim_create_augroup('lawand-lsp-highlight-' .. event.buf, { clear = true })

          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_group,
            callback = function()
              if client.connected then
                local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
                client:request('textDocument/documentHighlight', params, nil, event.buf)
              end
            end,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_group,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })
  end,
}
