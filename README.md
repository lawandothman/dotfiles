# Dotfiles
This repository includes a `install.sh` script to set up my development environment on a fresh MacOS install, it also includes my dotfiles.

## Usage
1) Clone the repository by running: 
``` shell
git clone https://github.com/lawandothman/dotfiles.git
```

2) Run the `install.sh` script from the repository in the terminal by running:
```shell
bash install.sh
```

3) Set up SSH keys to communicate with GitHub:
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
