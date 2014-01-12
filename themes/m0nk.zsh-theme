# Name:   m0nk zsh theme
# Author: municher <xxx@xxx.com>
#
# This theme needs a terminal supporting 256 colors as well as unicode.
#
autoload -U add-zsh-hook
autoload -Uz vcs_info

local c0=$( printf "\e[m")
local c1=$( printf "\e[38;5;245m")
local c2=$( printf "\e[38;5;250m")
local c3=$( printf "\e[38;5;242m")
local c4=$( printf "\e[38;5;197m")
local c5=$( printf "\e[38;5;225m")
local c6=$( printf "\e[38;5;240m")
local c7=$( printf "\e[38;5;242m")
local c8=$( printf "\e[38;5;244m")
local c9=$( printf "\e[38;5;162m")
local c10=$(printf "\e[1m")
local c11=$(printf "\e[38;5;208m\e[1m")
local c12=$(printf "\e[38;5;142m\e[1m")
local c13=$(printf "\e[38;5;196m\e[1m")


# We dont want to use the extended colorset in the TTY / VC.
if [ "$TERM" = "linux" ]; then
    c1=$( printf "\e[34;1m")
    c2=$( printf "\e[35m")
    c3=$( printf "\e[31m")
    c4=$( printf "\e[31;1m")
    c5=$( printf "\e[32m")
    c6=$( printf "\e[32;1m")
    c7=$( printf "\e[33m")
    c8=$( printf "\e[33;1m")
    c9=$( printf "\e[34m")

    c11=$(printf "\e[35;1m")
    c12=$(printf "\e[36m")
    c13=$(printf "\e[31;1m")
fi

zstyle ':vcs_info:*' actionformats \
    "%{$c8%}(%f%s)%{$c7%}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f "

zstyle ':vcs_info:*' formats \
    "%{$c8%}%s%{$c7%}(%{$c9%}%{$c1%}%b%{$c7%})%{$reset_color%}%f "

zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git

dir_status="%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$c0%}:%{$fg[green]%}%0~%{$reset_color%}"
ret_code="%{$fg[red]%}%(?.. [%?])%{$reset_color%}"

PROMPT='%{$fg[green]%}%p%{$reset_color%}${dir_status}${ret_code}%{$reset_color%} %{$c1%}$%{$reset_color%} '

add-zsh-hook precmd rprompt_precmd

rprompt_precmd () {
  vcs_info
  if [ "${vcs_info_msg_0_}" = "" ]; then
    RPROMPT='${vcs_info_msg_0_}'
# modified, to be commited
  elif [[ $(git diff --cached --name-status 2>/dev/null ) != "" ]]; then
    RPROMPT='${vcs_info_msg_0_}%{$30%} %{$fg_bold[blue]%}c%{$fg_bold[cyan]%}omm%{$fg_bold[black]%}it%{$reset_color%}'

  elif [[ $(git diff --name-status 2>/dev/null ) != "" ]]; then
    RPROMPT='${vcs_info_msg_0_}%{$fg_bold[blue]%}d%{$fg_bold[cyan]%}ir%{$fg_bold[black]%}ty%{$reset_color%}'
  else
    RPROMPT='${vcs_info_msg_0_}'
fi
}
