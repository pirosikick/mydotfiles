##
## .bashrc
##
## Hiroyuki Anai
##
umask 022

if [[ "$PS1" ]]; then
    PS1="\[\033[36m\][\u@\h \w]\[\033[0m\]\\n\$ "
fi

export PAGER=less
export LESS="-X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]"
export RSYNC_RSH=ssh

alias ll="ls -alh"

