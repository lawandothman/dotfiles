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
    -- Oil already sends willRenameFiles/didRenameFiles; this writes the buffers
    -- the LSP edits in response, but only those with nothing unsaved.
    lsp_file_methods = {
      autosave_changes = 'unmodified',
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
