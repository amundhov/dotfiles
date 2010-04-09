# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export LC_ALL="nb_NO.UTF-8"

eval `keychain --eval --nogui -Q -q id_rsa`
