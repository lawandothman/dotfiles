return {
  'stevearc/oil.nvim',
  opts = {
    confirmation = {
      border = 'rounded',
    },
    float = {
      border = 'rounded',
      -- A fraction of the editor width; 0 would fill it edge to edge.
      max_width = 0.6,
    },
    view_options = {
      show_hidden = true,
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
