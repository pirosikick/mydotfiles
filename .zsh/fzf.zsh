# http://qiita.com/ysk_1031/items/8cde9ce8b4d0870a129d
setopt hist_ignore_all_dups

function fzf_select_history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | fzf --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N fzf_select_history
bindkey '^r' fzf_select_history

function fzf-src () {
    local selected_dir=$(ghq list -p | fzf --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-src
bindkey '^]' fzf-src

function fzf-kill-process () {
    ps -ef | fzf | awk '{ print $2 }' | xargs kill
    zle clear-screen
}
zle -N fzf-kill-process
bindkey '^xk' fzf-kill-process   # C-x k

function fzf-open-app () {
    ls | fzf | xargs open
    zle clear-screen
}
zle -N fzf-open-app
bindkey '^xo' fzf-open-app 

# http://qiita.com/fmy/items/b92254d14049996f6ec3
function agvim () {
  vim $(ag $@ | fzf --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}
