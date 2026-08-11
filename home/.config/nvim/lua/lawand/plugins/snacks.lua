return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    bigfile = { enabled = true },
    -- select stays with telescope-ui-select; snacks only owns the text prompt.
    input = { enabled = true },
  },
}
