set fish_greeting

set -gx EDITOR nvim
set -gx HUSKY 0

if command -q mise
    mise activate fish | source
end
