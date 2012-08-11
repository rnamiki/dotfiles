##################
# .zshrc
# http://www.machu.jp/b/ZshRc.html
##################

# keymap
bindkey -e
bindkey "^?"    backward-delete-char
bindkey "^H"    backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# history
#screen �Ƕ�ͭ������
setopt append_history
HISTFILE=$HOME/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt extended_history
setopt share_history
function history-all { history -E 1 }
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt csh_null_glob
setopt magic_equal_subst
setopt prompt_subst
setopt autopushd
setopt nobeep


# ���ꤷ�����ޥ��̾���ʤ����ǥ��쥯�ȥ�̾�Ȱ��פ������ cd ����
setopt auto_cd
# 8 �ӥå��ܤ��̤��褦�ˤʤꡢ���ܸ�Υե�����̾�ʤɤ򸫤��褦�ˤʤ�
setopt print_eightbit
# ����ͤ� 0 �ʳ��ξ�罪λ�����ɤ�ɽ������
setopt print_exit_value
unsetopt promptcr

# color
local GRAY=$'%{\e[0;30m%}'
local LIGHT_GRAY=$'%{\e[0;37m%}'
local WHITE=$'%{\e[0;37m%}'
local LIGHT_BLUE=$'%{\e[0;36m%}'
local YELLOW=$'%{\e[0;33m%}'
local PURPLE=$'%{\e[0;35m%}'
local GREEN=$'%{\e[0;32m%}'
local BLUE=$'%{\e[0;34m%}'
local BLACK=$'%{\e[0;30m%}'
#local DEFAULT=$'%{\e[1;m%}'

# prompt
HOST_NAME=`echo $HOST | sed -e "s/\..*//g"`
PROMPT=$GREEN"${USER}@${HOST_NAME} $BLUE%(!.#.$) "$WHITE
RPROMPT=$BLUE"[%~]"$WHITE

# abbreviation

typeset -A myabbrev
myabbrev=(
"lg"    "| grep"
"tx"    "tar -xvzf"
"tc"    "tar -cvxf"
)

my-expand-abbrev() {
	local left prefix
	left=$(echo -nE "$LBUFFER" | sed -e "s/[_a-zA-Z0-9]*$//")
	prefix=$(echo -nE "$LBUFFER" | sed -e "s/.*[^_a-zA-Z0-9]\([_a-zA-Z0-9]*\)$/\1/")
	LBUFFER=$left${myabbrev[$prefix]:-$prefix}" "
}
zle -N my-expand-abbrev
bindkey     " "         my-expand-abbrev


# completion
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


