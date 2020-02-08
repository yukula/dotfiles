# bright
# https://coolors.co/16171e-f4f1de-e87761-74bca4-fcd894

set -l bg	16171e
set -l fg	f4f1de
set -l red	e87761
set -l green	74bca4
set -l yellow	fcd894


# dark
# https://coolors.co/131319-c8c6b6-be6250-5f9a87-cfb17a

set -l bg_	111116
set -l fg_	b2b0a2
set -l red_	a95748
set -l green_	558978
set -l yellow_	b89e6c



# https://fishshell.com/docs/current/index.html#variables-color
#
set fish_color_normal		$fg
set fish_color_command		$fg
set fish_color_quote		$green -i
set fish_color_redirection	$red 		# the color for IO redirections
set fish_color_end		$red 		# the color for process separators like ';' and '&'
set fish_color_error		999 $fg		# the color used to highlight potential errors
set fish_color_param		$yellow	-i	# the color for regular command parameters
set fish_color_comment		$yellow_	
set fish_color_match		$yellow
# https://stackoverflow.com/questions/28444740/how-to-use-vi-mode-in-fish-shell
set fish_color_selection	$fg_ --background=555 brblack # the color used when selecting text (in vi visual mode)
set fish_color_search_match	$fg_ --background=555 brblack # used to highlight history search matches and the selected pager item (must be a background)
set fish_color_operator		$red		# the color for parameter expansion operators like '*' and '~'
set fish_color_escape		$red_		# the color used to highlight character escapes like '\n' and '\x70'
set fish_color_cwd		$fg
set fish_color_autosuggestion	555 brblack
set fish_color_cancel		$red_		# the color for the '^C' indicator on a canceled command
set fish_pager_color_prefix	$yellow
