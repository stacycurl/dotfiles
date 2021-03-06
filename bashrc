export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagaced

source ~/.bash_aliases
source ~/dev/projects/boost-tools/init.sh

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
 
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
 
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
else
  color_prompt=
fi
 
function parse_git_branch {
  local branch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'` 
  local ansi=36 # Blue
 
  echo -n '\[\e[01;'"$ansi"'m\]'"$branch"
}

function _prompt_command {
  # Can't set PS1 directly, otherwise ANSI stuff in parse_git_branch is ignored
  PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]"`parse_git_branch`"\[\033[00m\] \$ "
}
 
if [ "$color_prompt" = yes ]; then
    PROMPT_COMMAND=_prompt_command
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
 
unset color_prompt force_color_prompt


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.bin"

function title {
    echo -ne "\033]0;"$*"\007"
}

_my_cd () {
  declare CDPATH=
  _cd "$@" 
}
complete -F _my_cd cd

eval "$(thefuck --alias fu)"

