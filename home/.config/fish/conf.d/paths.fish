/opt/homebrew/bin/brew shellenv fish | source

fish_add_path $HOME/.dotfiles $HOME/.local/bin $HOME/.cargo/bin

fish_add_path /opt/homebrew/opt/llvm/bin
set -gx LDFLAGS -L/opt/homebrew/opt/llvm/lib
set -gx CPPFLAGS -I/opt/homebrew/opt/llvm/include

fish_add_path /opt/homebrew/opt/postgresql@16/bin

set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx JAVA_HOME "/Applications/Android Studio.app/Contents/jbr/Contents/Home"
fish_add_path $JAVA_HOME/bin
fish_add_path --append $ANDROID_HOME/emulator $ANDROID_HOME/platform-tools
