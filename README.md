# dotfiles

Personal macOS dotfiles, symlinked into `$HOME` with [GNU Stow](https://www.gnu.org/software/stow/).

## Restore on a fresh machine

Only two things have to happen by hand, because nothing exists yet:

```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git clone https://github.com/lawandothman/dotfiles.git ~/.dotfiles
~/.dotfiles/dot init
```

`dot init` runs every step below, in order. Each one checks before acting, so
re-running it is safe.

| Step | Does |
|---|---|
| Homebrew | installs it if missing |
| Brewfile | `brew bundle` — formulae, casks, fonts |
| Stow dotfiles | symlinks `home/` into `$HOME` |
| mise tools | `mise install` — node, bun, pnpm, go, terraform |
| TypeScript LSP | global `typescript` 7, which nvim runs as `tsc --lsp` |
| fish login shell | adds fish to `/etc/shells`, then `chsh` |
| SSH key | ed25519, and prints where to paste the public half |

Skip the interactive steps with `--skip-ssh` and `--skip-shell`.

`dot doctor` reports what is present and what is missing without changing
anything.

### Two things `dot` cannot do

**Secrets.** `~/.config/fish/conf.d/secrets.fish` sources
`~/.local/share/secrets/env.fish`, which sets `NPM_TOKEN` and
`LOTTIE_GITHUB_PACKAGES_TOKEN` with `set -gx`. Restore it from your password
manager. The sourcing is guarded, so a missing file is not an error.

**Berkeley Mono.** Paid, so it cannot be automated — install it from
<https://berkeleygraphics.com/>. Ghostty also wants Symbols Nerd Font Mono,
which *is* in the Brewfile.

### First Neovim launch

`lazy.nvim` clones the plugins on first start. Then:

```vim
:Lazy sync       " install and update plugins
:Mason           " mason-tool-installer fetches the LSP servers + stylua
:checkhealth     " verify nvim + lsp are healthy
```

## Day-to-day

Edit any config in place — it is a symlink into this repo, so the change is
already there for `git diff`. Commit and push from `~/.dotfiles`.

A new file created inside an already-stowed directory (`~/.config/fish`,
`~/.config/nvim`, `~/.config/ghostty`) lands in this repo automatically. To
track a path that is not yet stowed, add it under `home/` and run `dot stow`.

`~/.config/herdr` is deliberately *not* folded — the running server keeps
sockets and logs there, so only `config.toml` and `bin/` are symlinked and the
runtime files stay out of the repo.

After installing or removing tools, refresh the Brewfile snapshot:

```sh
brew bundle dump --force --file=~/.dotfiles/Brewfile
```

Then **review the diff** — this repo is public, so strip anything
work-specific or private before committing.
