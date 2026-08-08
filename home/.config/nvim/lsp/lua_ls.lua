---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = { checkThirdParty = false },
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
}
