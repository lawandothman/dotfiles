echo Hello Lawand 👋 I will be setting up your MacBook For Development 👨‍💻
echo 💻  Installing Command Line Tools 💻
xcode-select --install
echo 🍺 Installing HomeBrew 🍺
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
source ~/.zshrc
echo 🍺 Updating HomeBrew 🍺
brew update
echo 🚀 Installing GUI Applications 🚀
brew install --cask \
	visual-studio-code \
	google-chrome \
	iterm2 \
	spotify \
	postman \
	discord \
	figma \
	notion \
	tableplus \
	alfred \
	kap \
	docker
echo 🔃 Installing Git 🔃
brew install git
echo 📟 Installing Oh My Zsh 📟
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo ▲ Installing Vercel Zsh Theme ▲
curl https://raw.githubusercontent.com/vercel/zsh-theme/master/vercel.zsh-theme -Lo ~/.oh-my-zsh/custom/themes/vercel.zsh-theme
echo 🌐 Installing Node.js 🌐
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.zshrc
nvm install node
nvm use node
npm install -g yarn
echo 🔗 Creating Symbolic Links For Your Dotfiles 🔗
ln -s .zshrc ~/.zshrc
ln -s .vimrc ~/.vimrc
ln -s .gitconfig ~/.gitconfig
