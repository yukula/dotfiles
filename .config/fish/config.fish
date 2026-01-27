set fish_greeting ""

set -x EDITOR nvim

# Add Nix daemon profile (multi-user) if present
if test -d /nix/var/nix/profiles/default/bin
    fish_add_path -g /nix/var/nix/profiles/default/bin
end

# Add user profile (works for nix profile installs)
if test -d $HOME/.nix-profile/bin
    fish_add_path -g $HOME/.nix-profile/bin
end

if test -d $HOME/.local/share/nvim/mason/bin
    fish_add_path -g /home/lima.linux/.local/share/nvim/mason/bin
end

direnv hook fish | source
set -g direnv_fish_mode eval_on_arrow
set -g direnv_fish_mode eval_after_arrow
set -g direnv_fish_mode disable_arrow

function dotc --wraps git --description 'alias to manage dotfiles over git'
	git --git-dir=$HOME/.dotc/ --work-tree=$HOME $argv
end

alias ll="eza -la"
alias ls="eza -l"
