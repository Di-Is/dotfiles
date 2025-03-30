# alias
alias pu='pushd'
fpushd(){
    local dir
    dir=$(fd --type d . ${1:-.} --hidden --exclude .git --exclude .venv 2> /dev/null | fzf +m) && pushd "$dir"
} 
alias fpu='fpushd'
