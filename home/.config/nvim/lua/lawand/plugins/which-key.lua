return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    -- Must stay below timeoutlen (300), or the pending sequence is abandoned
    -- before the popup is due.
    delay = 200,
  },
}
