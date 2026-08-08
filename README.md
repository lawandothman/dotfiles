# dotfiles

Personal macOS dotfiles, symlinked into `$HOME` with [GNU Stow](https://www.gnu.org/software/stow/).

Everything under `home/` mirrors `$HOME` exactly, so `home/.config/fish/config.fish`
becomes `~/.config/fish/config.fish`. Because the files are symlinks, editing a
config edits this repo directly — there is no apply step.

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

### 2. Clone and stow

```sh
git clone git@github.com:lawandothman/dotfiles.git ~/.dotfiles
brew install stow
stow -R -d ~/.dotfiles -t ~ home
```

Stow refuses to overwrite existing real files. If it reports a conflict, move
the offending file aside and re-run.

### 3. Tools used by the configs

A snapshot of every installed formula, cask, and tap lives in
[`Brewfile`](./Brewfile). Restore everything in one shot:

```sh
brew bundle install --file=~/.dotfiles/Brewfile
```

`~/.config/herdr/bin/herdr-sessionizer` is the repo picker bound to
`prefix+o`. It needs `fd` and `fzf`, both in the Brewfile.

### 4. Make fish the login shell

fish must be registered in `/etc/shells` before `chsh` will accept it:

```sh
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
```

This only affects newly started shells. Herdr names the shell explicitly in
`~/.config/herdr/config.toml`, so its panes do not depend on `$SHELL`.

Completions need no setup: Homebrew installs fish completions to
`/opt/homebrew/share/fish/vendor_completions.d`, which fish already searches.

### 5. Fonts

Ghostty config references:

- **Berkeley Mono** — paid, install manually from <https://berkeleygraphics.com/>
- **Symbols Nerd Font Mono** — `brew install --cask font-symbols-only-nerd-font`

### 6. Secrets (not in this repo)

`~/.config/fish/conf.d/secrets.fish` sources
`$HOME/.local/share/secrets/env.fish`, which sets `NPM_TOKEN` and
`LOTTIE_GITHUB_PACKAGES_TOKEN` with `set -gx`. Restore it from your password
manager before opening a new shell; the sourcing is guarded, so a missing file
is not an error.

### 7. TypeScript native LSP (`tsgo`)

Not installed by Mason, whose registry still ships the superseded
`@typescript/native-preview` build. `lsp.lua` runs `tsc --lsp --stdio`, so the
binary comes from a global TypeScript 7:

```sh
npm install -g typescript
```

### 8. First Neovim launch

`lazy.nvim` will clone all plugins on first startup. Then:

```vim
:Lazy sync       " ensure all plugins are at locked commits
:Mason           " mason-tool-installer auto-installs the LSP servers + stylua
:checkhealth     " verify nvim + lsp are healthy
```

## Day-to-day workflow

Edit any config in place — it is a symlink into this repo, so the change is
already staged for `git diff`. Commit and push from `~/.dotfiles`.

A new file created inside an already-stowed directory (`~/.config/fish`,
`~/.config/nvim`, `~/.config/ghostty`) lands in this repo automatically. To
track a path that is not yet stowed, add it under `home/` and re-run:

```sh
stow -R -d ~/.dotfiles -t ~ home
```

`~/.config/herdr` is deliberately *not* folded — the running server keeps
sockets and logs there, so only `config.toml` and `bin/` are symlinked and the
runtime files stay out of the repo.

After installing or removing tools, refresh the Brewfile snapshot:

```sh
brew bundle dump --force --file=~/.dotfiles/Brewfile
```

Then **review the diff** — this repo is public, so strip anything
work-specific or private before committing.
