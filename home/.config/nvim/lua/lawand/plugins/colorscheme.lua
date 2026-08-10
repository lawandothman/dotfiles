return {
  'rose-pine/neovim',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    local bg = '#0D1017'
    local border = '#1F2329'
    require('rose-pine').setup {
      variant = 'main', -- auto, main, moon, or dawn
      dark_variant = 'main', -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
      },

      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },

      -- Rose Pine blends every tinted background against base, so overriding it
      -- here rather than repainting afterwards keeps those blends in gamut.
      palette = {
        main = { base = bg },
      },

      groups = {
        border = 'muted',
        link = 'iris',
        panel = 'surface',

        error = 'love',
        hint = 'iris',
        info = 'foam',
        note = 'pine',
        todo = 'rose',
        warn = 'gold',

        git_add = 'foam',
        git_change = 'rose',
        git_delete = 'love',
        git_dirty = 'rose',
        git_ignore = 'muted',
        git_merge = 'iris',
        git_rename = 'pine',
        git_stage = 'iris',
        git_text = 'rose',
        git_untracked = 'subtle',

        h1 = 'iris',
        h2 = 'foam',
        h3 = 'rose',
        h4 = 'gold',
        h5 = 'pine',
        h6 = 'foam',
      },

      highlight_groups = {
        NormalFloat = { bg = bg },
        NormalSB = { bg = bg },
        FloatBorder = { bg = bg, fg = border },
        FloatTitle = { bg = bg, fg = 'foam' },

        TelescopeBorder = { bg = bg, fg = border },
        TelescopePromptBorder = { bg = bg, fg = border },
        TelescopeResultsBorder = { bg = bg, fg = border },
        TelescopePreviewBorder = { bg = bg, fg = border },

        -- highlight_med for the selected row: the menu sits on the editor
        -- background, so the selection needs its own elevation to be legible.
        Pmenu = { bg = bg, fg = 'subtle' },
        PmenuSel = { bg = 'highlight_med', fg = 'text' },
        PmenuSbar = { bg = bg },
        PmenuThumb = { bg = 'highlight_med' },
        BlinkCmpMenu = { bg = bg },
        BlinkCmpMenuBorder = { bg = bg, fg = border },
        BlinkCmpMenuSelection = { bg = 'highlight_med', fg = 'text' },
        BlinkCmpDoc = { bg = bg },
        BlinkCmpDocBorder = { bg = bg, fg = border },
        BlinkCmpSignatureHelp = { bg = bg },
        BlinkCmpSignatureHelpBorder = { bg = bg, fg = border },

        DiffviewNormal = { bg = bg },
        DiffviewWinSeparator = { bg = bg, fg = 'muted' },
      },
    }
    vim.cmd.colorscheme 'rose-pine'
  end,
}
