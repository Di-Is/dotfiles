
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias root='cd "$(git rev-parse --show-toplevel)"'

fcd(){
    local dir
    dir=$(fd --type d . ${1:-.} --hidden 2> /dev/null | fzf +m) && cd "$dir"
} 