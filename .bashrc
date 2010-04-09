export LC_ALL="nb_NO.UTF-8"

# Check for an interactive session
[ -z "$PS1" ] && return
PS1='[\u@\h \W]\$ '

export HISTCONTROL=ignoreboth
export HISTFILESIZE=9999
export HISTIGNORE="ls:l:cd:logout:exit:echo:"

# Oppdater størrelse på vinduet når vi resizer
shopt -s checkwinsize

# Bedre håndtering av ikke-tekst i less
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# sett tittel til user@host:dir - nå også inni screen!
case "$TERM" in
screen*)
    # Setter tittel i xterm/kompatible, og også for screen
    #PROMPT_COMMAND='echo -ne "\033k\033\134\033k${HOSTNAME}: ${PWD/$HOME/~}\033\134"'
    # Setter tittel for xterm/kompatible, og kjørende kommando for screen. Pass
    # på å putte denne i .screenrc: shelltitle '$ |'
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007\033k\033\\"'
    eval "`dircolors -b`"
    #alias ls='ls --color=auto -F'
    ;;
xterm*|rxvt*)
    #Setter tittel i xterm/kompatible
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    eval "`dircolors -b`"
    alias ls='ls --color=auto -F'
    ;;
*)
    ;;
esac
# cd til filnavn :p
alias cwd="pushd `echo $* | sed -n 's,\(.*\)/.*,\1,p'`"

# ls ala neergaar
alias sl='ls'
alias ll='ls -CA'
alias la='ls -a'
alias l='ls -lha'

# <3 the vim way
alias :q='exit'

# Givf completion!
[ -f /etc/bash_completion ] && . /etc/bash_completion

# Ingen bell
xset b off 2>/dev/null
setterm -blength 0

alias ls='ls --color=auto'
export EDITOR=vim

