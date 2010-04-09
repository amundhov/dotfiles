export LC_ALL="nb_NO.UTF-8"

# Ikke fortsett hvis vi ikke kjører interaktiv
[ -z "$PS1" ] && return

alias samfundet='ssh login.samfundet.no'
alias ntnu='ssh login.stud.ntnu.no'
alias admin='ssh root@einhov.dyndns.org'
alias vi='vim'
alias boka='sudo sshfs root@einhov.dyndns.org:/home/data/ /mnt/boka/ -o allow_other'
alias mplaylist='mplayer -playlist'

export PATH=${PATH}:/usr/local/bin:/usr/local/sbin:/usr/local/games

set -o vi

# Givf PATH med $HOME/bin
[ -d $HOME/bin ] && PATH="$HOME/bin:${PATH};/usr/local/bin"


# Ingen duplikate linjer i historien, behold historie lenge.
export HISTCONTROL=ignoreboth
export HISTFILESIZE=9999
export HISTIGNORE="ls:l:cd:logout:exit:echo:"

# Oppdater størrelse på vinduet når vi resizer
shopt -s checkwinsize

# Bedre håndtering av ikke-tekst i less
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# sett navn på choot, hvis chroot.
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# Givf colorzing at Prompt!
PS1='${debian_chroot:+($debian_chroot)}\[\033[0;32m\]\u\[\033[00m\]@\[\033[33m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# sett tittel til user@host:dir - nå også inni screen!
case "$TERM" in
screen*)
    # Setter tittel i xterm/kompatible, og også for screen
    #PROMPT_COMMAND='echo -ne "\033k\033\134\033k${HOSTNAME}: ${PWD/$HOME/~}\033\134"'
    # Setter tittel for xterm/kompatible, og kjørende kommando for screen. Pass
    # på å putte denne i .screenrc: shelltitle '$ |'
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007\033k\033\\"'
    eval "`dircolors -b`"
    alias ls='ls --color=auto -F'
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

export EDITOR=vim


eval `keychain --eval --nogui -Q -q id_rsa`
