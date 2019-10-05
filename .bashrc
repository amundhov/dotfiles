
# Ikke fortsett hvis vi ikke kjører interaktiv
[ -z "$PS1" ] && return

if $(uname -s | grep -q 'Darwin'); then
    IS_MAC=true
else
    IS_MAC=false
	export LC_ALL="nb_NO.UTF-8"
	export LANGUAGE='en'
fi

export EDITOR=vim

alias samfundet='ssh amundhov@login.samfundet.no'
alias ntnu='ssh login.stud.ntnu.no'
alias admin='ssh root@einhov.dyndns.org'
alias vi='vim'
alias g='git'
alias cv='git cv'
alias sc='/Applications/Commander.app/Contents/MacOS/commander'
alias boka='sudo sshfs root@einhov.dyndns.org:/home/data/ /mnt/boka/ -o allow_other'
alias mplaylist='mplayer -playlist'
alias conflicts="git status --porcelain | grep UU | cut -f 2 -d ' ' | xargs -o $EDITOR && git status --porcelain | grep UU | cut -f 2 -d ' ' | xargs git add"
alias makeaur='makepkg -sri'

export PATH=/usr/local/bin:${PATH}:/usr/local/sbin:/usr/local/games:~/.local/bin

if $IS_MAC; then
    # MAC quirks
    export HOMEBREW_GITHUB_API_TOKEN='97a41f87fd1953cd6b634fb83f9bf4cff5c6fc05'
fi

set -o vi

unset HISTFILESIZE
HISTSIZE=10000
export HISTIGNORE="ls:l:cd:logout:exit:echo:"
PROMPT_COMMAND="history -a"
export HISTSIZE PROMPT_COMMAND
shopt -s histappend

# Oppdater størrelse på vinduet når vi resizer
shopt -s checkwinsize
export PROMPT_COMMAND='history -a'

# Bedre håndtering av ikke-tekst i less
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# sett navn på choot, hvis chroot.
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

alias vim='nvim'
if $IS_MAC; then
    alias vim='nvim'
    alias fixInkscape='wmctrl -r Inkscape -e 0,4000,2560,2880,1800'
    alias fixInkscapeExt='wmctrl -r Inkscape -e 0,0,0,2560,1300'
fi


# sett tittel til user@host:dir - nå også inni screen!
case "$TERM" in
screen*)
    # Setter tittel i xterm/kompatible, og også for screen
    #PROMPT_COMMAND='echo -ne "\033k\033\134\033k${HOSTNAME}: ${PWD/$HOME/~}\033\134"'
    # Setter tittel for xterm/kompatible, og kjørende kommando for screen. Pass
    # på å putte denne i .screenrc: shelltitle '$ |'
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007\033k\033\\"'
    $IS_MAC || eval "`dircolors -b`"
    alias ls='ls --color=auto -F'
    ;;
xterm*|rxvt*)
    #Setter tittel i xterm/kompatible
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    $IS_MAC || eval "`dircolors -b`"
    alias ls='ls --color=auto -F'
    ;;
*)
    ;;
esac
if [ "$TERM_PROGRAM" == "Apple_Terminal" ] ; then
    alias ls='ls -F -G'
fi
# cd til filnavn :p
alias cwd="pushd `echo $* | sed -n 's,\(.*\)/.*,\1,p'`"

# ls ala neergaar
alias sl='ls'
alias ll='ls -CA'
alias la='ls -a'
alias l='ls -lha'

# <3 the vim way
alias :q='exit'

# Use bash-completion, if available
if $IS_MAC; then
	bash_completion_prefix='/usr/local/opt/bash-completion@2'
	#[[ $PS1 && -f $bash_completion_prefix/etc/profile.d/bash_completion.sh ]] && \
	#	. $bash_completion_prefix/etc/profile.d/bash_completion.sh
	export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
	[[ $PS1 ]] && . /usr/local/Cellar/bash-completion@2/2.8/share/bash-completion/bash_completion
else
	. /usr/share/git/git-prompt.sh
fi

# Ingen bell
$IS_MAC || xset b off 2>/dev/null

# Don't exit straight away ^D
export IGNOREEOF=1

$IS_MAC || eval `keychain --eval --nogui -Q -q id_rsa`

PERL_MB_OPT="--install_base \"/Users/amhov/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/amhov/perl5"; export PERL_MM_OPT;

#[ -f $usr_prefix/etc/bash_completion.d/git-prompt.sh ] && PS1='\[\033[0;32m\]\u\[\033[00m\] \W$(__git_ps1 " \[\033[33m\](%s)\[\033[00m\]"):\$ '
PS1='\[\033[00m\]\W$(__git_ps1 " \[\033[33m\](%s)\[\033[00m\]"):\$ '
