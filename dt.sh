#!/usr/bin/env bash

# template is borrowed here:
#   https://betterdev.blog/minimal-safe-bash-script-template/

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-f] -p param_value arg1 [arg2...]

Simple script for polling changes in registered dotfiles and update it in git repo dir

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
# -f, --flag      Some flag description
# -p, --param     Some param description
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  # flag=0
  # param=''

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    # --no-color) NO_COLOR=1 ;;
    # -f | --flag) flag=1 ;; # example flag
    # -p | --param) # example named parameter
      # param="${2-}"
      # shift
      # ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")

  # check required params and arguments
  # [[ -z "${param-}" ]] && die "Missing required parameter: param"
  # [[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  return 0
}

# TODO: autodeclare that 
declare -A tracked_files 
tracked_files["${HOME}/.tmux.conf"]=".tmux.conf"
tracked_files["${HOME}/.config/tmux/theme.conf"]=".config/tmux/theme.conf"
tracked_files["${HOME}/.config/alacritty/alacritty.yml"]=".config/alacritty/alacritty.yml"
tracked_files["${HOME}/.config/alacritty/extracted_colors.txt"]=".config/alacritty/extracted_colors.txt"
tracked_files["${HOME}/.config/fish/config.fish"]=".config/fish/config.fish"
tracked_files["${HOME}/.config/fish/conf.d/theme.fish"]=".config/fish/conf.d/theme.fish"
tracked_files["${HOME}/.config/gtk-3.0/settings.ini"]=".config/gtk-3.0/settings.ini"
tracked_files["${HOME}/.config/nvim/init.lua"]=".config/nvim/init.lua"
tracked_files["${HOME}/.config/nvim/plugin/bindings.vim"]=".config/nvim/plugin/bindings.vim"
tracked_files["${HOME}/.config/nvim/plugin/options.lua"]=".config/nvim/plugin/options.lua"
tracked_files["${HOME}/.config/nvim/lua/config/plugin_manager_bootstrap.lua"]=".config/nvim/lua/config/plugin_manager_bootstrap.lua"
tracked_files["${HOME}/.config/nvim/lua/config/plugins.lua"]=".config/nvim/lua/config/plugins.lua"
tracked_files["${HOME}/.config/nvim/after/plugin/colorscheme.lua"]=".config/nvim/after/plugin/colorscheme.lua"
tracked_files["${HOME}/.config/nvim/after/plugin/cmp.lua"]=".config/nvim/after/plugin/cmp.lua"
tracked_files["${HOME}/.config/nvim/after/plugin/lspconfig.lua"]=".config/nvim/after/plugin/lspconfig.lua"
tracked_files["${HOME}/.config/nvim/after/plugin/lsp-status.lua"]=".config/nvim/after/plugin/lsp-status.lua"
tracked_files["${HOME}/.config/nvim/after/plugin/lualine.lua"]=".config/nvim/after/plugin/lualine.lua"
tracked_files["${HOME}/.config/nvim/after/plugin/telescope.lua"]=".config/nvim/after/plugin/telescope.lua"
tracked_files["${HOME}/.config/nvim/after/plugin/treesitter.lua"]=".config/nvim/after/plugin/treesitter.lua"
tracked_files["${HOME}/.config/nvim/after/plugin/trouble.lua"]=".config/nvim/after/plugin/trouble.lua"
tracked_files["${HOME}/.config/sway/conf.d/bindings"]=".config/sway/conf.d/bindings"
tracked_files["${HOME}/.config/sway/conf.d/theme"]=".config/sway/conf.d/theme"
tracked_files["${HOME}/.config/sway/config"]=".config/sway/config"
tracked_files["${HOME}/.config/waybar/config"]=".config/waybar/config"
tracked_files["${HOME}/.config/waybar/style.css"]=".config/waybar/style.css"



# poll registered files 
poll() {
  for file in "${!tracked_files[@]}";
  do
    src=$file
    dst="${tracked_files[$src]}"

    if [[ ! -e $src ]]; then 
      msg "'$src' ${RED}not found${NOFORMAT}"
    fi
    # if [[ !-e $dst ]]; then msg "'$dst' ${RED}not found${NOFORMAT}" fi

    if [[ $src -nt $dst ]]; then 
      echo "'$dst' --- updated"
      cp $src $dst
    fi
  done
}

parse_params "$@"
setup_colors
poll

# msg "${RED}Read parameters:${NOFORMAT}"
# msg "- flag: ${flag}"
# msg "- param: ${param}"
# msg "- arguments: ${args[*]-}"
