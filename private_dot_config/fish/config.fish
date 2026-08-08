set fish_greeting

set -gx EDITOR nvim
set -gx HUSKY 0

if test -x $HOME/.local/bin/mise
    $HOME/.local/bin/mise activate fish | source
end
