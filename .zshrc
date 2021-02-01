#
# .zshrc
#
# maintained by pirosikick
#

OSTYPE=`uname`

umask 022

# export env
export EDITOR=vim
export SVN_EDITOR=vim
export PAGER=less
export GREP_OPTION='--color=auto'
export LANG=en_US.UTF-8
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'
export GOPATH=$HOME
export GO15VENDOREXPERIMENT=1
export RBENV_ROOT=/usr/local/var/rbenv
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

if builtin command -v go > /dev/null; then
  eval "$(go env)"
fi

# http://karur4n.hatenablog.com/entry/2016/01/18/100000
setopt no_global_rcs

typeset -U path PATH

path=(
./node_modules/.bin
$HOME/.nodenv/bin
$HOME/.rbenv/bin
$HOME/.phpenv/bin
$HOME/.exenv/bin
$GOPATH/bin
/Applications/MacVim.app/Contents/MacOS/
/usr/local/php5/bin
/usr/local/bin
/usr/sbin
$path
)

path=(
  # allow directories only (-/)
  # reject world-writable directories (^W)
  ${^path}(N-/^W)
)

fpath=(
$HOME/.zfunc
$HOME/.zsh/completion
$fpath
)
# alias
alias ls="ls -ahGF"
alias ll="ls -lahGF"
alias bi="bundle install --path vendor/bundle"
alias be="bundle exec"
alias re="rbenv exec"
alias mvim="/Applications/MacVim.app/Contents/MacOS/mvim"
alias gitvdiff='git difftool --tool=vimdiff --no-prompt'
alias vimgo='vim -u ~/.vimrc.go'
alias mvimgo='mvim -u ~/.vimrc.go'

# http://qiita.com/Kuniwak/items/b711d6c3e402dfd9356b
alias g='git'

alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
alias -g R='`git remote | peco --prompt "GIT REMOTE>" | head -n 1`'
alias -g H='`curl -sL https://api.github.com/users/pirosikick/repos | jq -r ".[].full_name" | peco --prompt "GITHUB REPOS>" | head -n 1`'
alias -g LR='`git branch -a | peco --query "remotes/ " --prompt "GIT REMOTE BRANCH>" | head -n 1 | sed "s/remotes\/[^\/]*\/\(\S*\)/\1 \0/"`'

# global alias
alias -g G='| grep'
alias -g L='| vim -R -'
alias -g ID='`id -u`'
alias -g HL='| pygments -f rtf "style=monokai,fontface=Ricty"'

autoload -U promptinit && promptinit
prompt pure

# RVM
[ -s ${HOME}/.rvm/scripts/rvm ] && source ${HOME}/.rvm/scripts/rvm

autoload -U compinit && compinit

compdef g=git

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# options
setopt share_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_no_functions
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_expire_dups_first
setopt auto_pushd 
setopt auto_cd
setopt pushd_ignore_dups
setopt cdable_vars
setopt auto_menu
setopt auto_param_keys
setopt no_beep
setopt no_list_types
setopt magic_equal_subst
setopt no_flow_control
setopt prompt_subst
setopt list_packed
setopt complete_aliases
setopt list_types
setopt transient_rprompt


# emacs like key bind
bindkey -e

# Ctrl+P, Ctrl+N
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match \
      '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word

function zshrc () { source $HOME/.zshrc }

function macvim () {
  local mvim="/Applications/MacVim.app/Contents/MacOS/mvim"

  if [[ ${#@} = 0 ]]; then
    $mvim
  else
    $mvim --remote-tab-silent $@
  fi
}

if builtin command -v nodenv > /dev/null; then
  eval "$(nodenv init -)"
fi

# if builtin command -v phpenv > /dev/null; then
#     eval "$(phpenv init -)"
# fi

if builtin command -v rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

if builtin command -v exenv > /dev/null; then
  eval "$(exenv init -)"
fi

if builtin command -v direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi

if builtin command -v hub > /dev/null; then
    eval "$(hub alias -s)"
fi

function light() {
    if [ -z "$2" ]; then
        src="pbpaste"
    else
        src="/bin/cat $2"
    fi

    ${=src} |  pygmentize -f rtf -l $1 -O "style=monokai,fontface=Ricty" | pbcopy
}

. ~/.zsh/peco.zsh
. ~/.zsh/npm.zsh
