set fish_greeting ""

set -x EDITOR nvim

direnv hook fish | source 
set -g direnv_fish_mode eval_on_arrow  
set -g direnv_fish_mode eval_after_arrow
set -g direnv_fish_mode disable_arrow

function dotc --wraps git --description 'alias to manage dotfiles over git'
	git --git-dir=$HOME/.dotc/ --work-tree=$HOME $argv
end

alias ll="exa -la"
alias ls="exa -l"
