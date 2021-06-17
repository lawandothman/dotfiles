# Dotfiles
This repository includes a `install.sh` script to set up my development environment on a fresh MacOS install, it also includes my dotfiles.

## Usage
1) Run the `install.sh` script in the terminal by running:
```shell
bash <(curl -s https://raw.githubusercontent.com/lawandothman/dotfiles/main/install.sh)
```

2) Set up SSH keys to communicate with GitHub:
* Create a new SSH key using the provided email as a label
```shell
ssh-keygen -t ed25519 -C "your_email@example.com"
```
* Start the ssh-agent in the background
```shell
eval "$(ssh-agent -s)"
```
* Create a config file to automatically load keys into the ssh-agent and store pass-phrases in your keychain.
```shell
touch ~/.ssh/config
```
Open your `~/.ssh/config` and modify it
```
Host *
	AddKeysToAgent yes
	UseKeychain yes
	IdentityFile ~/.ssh/id_ed25519
```

3) Install the dotfiles onto a new system
* Prior to the installation make sure you have committed the `config` alias to your `.zshrc`:
```shell
alias config='/opt/homebrew/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

* And that your source repository ignores the folder where you'll clone it, so that you don't create weird recursion problems:
```shell
echo ".cfg" >> .gitignore
```

* Now clone your dotfiles int a bare repository in a "dot" folder of your `$HOME`:
```shell
git clone --bare git@github.com:lawandothman/dotfiles.git $HOME/.cfg
```

* Checkout the actual content from the bare repository to your `$HOME`:
```shell
config checkout
```

This might fail because your `$HOME` folder might already have some stock configuration files which would be written by Git. Either back them up or remove if you don't care.

Set the flag `showUntrackedFiles` to `no`
```shell
config config --local status.showUntrackedFiles no
```

