# dotfiles

Personal macOS dotfiles managed with [chezmoi](https://www.chezmoi.io/).

Tracks: `nvim`, `ghostty`, `tmux`, `zsh`, `git`.

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
`~/.tmux.conf`, `~/.zshrc`, `~/.gitconfig`, ...) into `$HOME`.

### 3. Tools used by the configs

```sh
brew install \
  neovim          `# 0.12+ required for the native LSP setup` \
  ghostty         `# terminal` \
  tmux \
  llvm            `# provides lldb-vscode used by nvim-dap (rust)` \
  bat ripgrep lsd `# aliased in .zshrc as cat / grep / ls` \
  fzf \
  node            `# needed for tsgo + several LSP servers Mason installs`

# oh-my-zsh + "vercel" theme (referenced in .zshrc)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# vercel theme: https://github.com/vercel-community/vercel-zsh
```

### 4. Fonts

Ghostty config references:

- **Berkeley Mono** — paid, install manually from <https://berkeleygraphics.com/>
- **Symbols Nerd Font Mono** — `brew install --cask font-symbols-only-nerd-font`

### 5. Secrets (not in this repo)

`.zshrc` sources `$HOME/.local/share/secrets/env.sh`. Restore that file from
your password manager / backup before opening a new shell, or comment the
line out temporarily.

### 6. TypeScript native LSP (`tsgo`)

Not installed by Mason — it's an npm package:

```sh
npm i -g @typescript/native-preview
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
