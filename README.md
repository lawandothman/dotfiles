# dotfiles

Personal macOS dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Restore on a fresh machine

### 1. Prerequisites

```sh
# Xcode CLT (for git, compilers)
xcode-select --install

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Set up an SSH key and add it to GitHub (the repo uses `git@github.com:`):

```sh
ssh-keygen -t ed25519 -C "lwnd@pm.me"
# add ~/.ssh/id_ed25519.pub to https://github.com/settings/keys
```

### 2. Pull the dotfiles

```sh
brew install chezmoi
chezmoi init --apply git@github.com:lawandothman/dotfiles.git
```

That places everything tracked in this repo (`~/.config/nvim`, `~/.config/ghostty`,
`~/.config/herdr`, `~/.config/fish`, `~/.gitconfig`, ...) into `$HOME`.

### 3. Tools used by the configs

A snapshot of every installed formula, cask, and tap lives in
[`Brewfile`](./Brewfile). Restore everything in one shot:

```sh
brew bundle install --file=~/.local/share/chezmoi/Brewfile
```

`~/.config/herdr/bin/herdr-sessionizer` is the repo picker bound to
`prefix+o`. It needs `fd` and `fzf`, both in the Brewfile.

After updating tools on the running machine, refresh the snapshot:

```sh
brew bundle dump --force --file=~/.local/share/chezmoi/Brewfile
```

Then `chezmoi cd`, **review the diff** (this repo is public — strip anything
work-specific or private before committing), and commit.

Make fish the login shell (it must be registered first):

```sh
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
```

Completions need no setup: Homebrew installs fish completions to
`/opt/homebrew/share/fish/vendor_completions.d`, which fish already searches.

### 4. Fonts

Ghostty config references:

- **Berkeley Mono** — paid, install manually from <https://berkeleygraphics.com/>
- **Symbols Nerd Font Mono** — `brew install --cask font-symbols-only-nerd-font`

### 5. Secrets (not in this repo)

`~/.config/fish/conf.d/secrets.fish` sources
`$HOME/.local/share/secrets/env.fish`, which sets `NPM_TOKEN` and
`LOTTIE_GITHUB_PACKAGES_TOKEN` with `set -gx`. Restore it from your password
manager before opening a new shell; the sourcing is guarded, so a missing file
is not an error.

### 6. TypeScript native LSP (`tsgo`)

Not installed by Mason, whose registry still ships the superseded
`@typescript/native-preview` build. `lsp.lua` runs `tsc --lsp --stdio`, so the
binary comes from a global TypeScript 7:

```sh
npm install -g typescript
```

### 7. First Neovim launch

`lazy.nvim` will clone all plugins on first startup. Then:

```vim
:Lazy sync       " ensure all plugins are at locked commits
:Mason           " mason-tool-installer auto-installs the LSP servers + stylua
:checkhealth     " verify nvim + lsp are healthy
```

## Day-to-day workflow

```sh
chezmoi cd                # cd into the source repo (~/.local/share/chezmoi)
chezmoi diff              # preview pending changes
chezmoi apply             # write source → home
chezmoi re-add <path>     # pull a live edit back into source
chezmoi add <path>        # start tracking a new file
chezmoi forget <path>     # stop tracking (keeps the live file)
```

After editing in source, commit and push from `chezmoi cd`.
