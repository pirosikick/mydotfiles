# http://qiita.com/ysk_1031/items/8cde9ce8b4d0870a129d
setopt hist_ignore_all_dups

function peco_select_history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco_select_history
bindkey '^r' peco_select_history

function peco-src () {
#    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    local selected_dir=$(ls -d ~/src/*/*/*  | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

function peco-kill-process () {
    ps -ef | peco | awk '{ print $2 }' | xargs kill
    zle clear-screen
}
zle -N peco-kill-process
bindkey '^xk' peco-kill-process   # C-x k

function peco-open-app () {
    ls | peco | xargs open
    zle clear-screen
}
zle -N peco-open-app
bindkey '^xo' peco-open-app 

# http://qiita.com/fmy/items/b92254d14049996f6ec3
function agvim () {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}
