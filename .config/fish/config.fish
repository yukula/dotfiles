set fish_greeting ""

set -x EDITOR nvim


function dotc --wraps git --description 'alias to manage dotfiles over git'
	git --git-dir=$HOME/.dotc/ --work-tree=$HOME $argv
end
