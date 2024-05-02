set -g fish_prompt_pwd_dir_length 3
function fish_prompt
  set -l username $USER
  set -l pwd_prompt (prompt_pwd)
  set -l git_branch (git branch --show-current 2> /dev/null)

  set -l pwd_format (set_color brwhite)$pwd_prompt(set_color white)
  set -l git_branch_format '('(set_color -o brred)$git_branch(set_color white -b black)')'
  set -l command_separator_format (set_color -o brmagenta)'> '(set_color white)

  echo -n $pwd_format $git_branch_format $command_separator_format 
end

set -g fish_color_nornal white
set -g fish_color_command blue 
set -g fish_color_param brblue
set -g fish_color_error blue # syntax error 
set -g fish_color_autosuggestion brwhite
set -g fish_color_operator -o red

set -g fish_color_keyword red
set -g fish_color_quote brgreen 
set -g fish_color_redirection red

set -g fish_color_comment -o white
set -g fish_color_escape -o white -b green
set -g fish_color_selection black -b white
set -g fish_color_cancel -o brblack -b red
