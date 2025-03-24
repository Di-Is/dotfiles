
# shell completion
eval "$(mise completion zsh)"

# alias
alias m='mise'
alias mr='mise run'
alias mt='mise task'
alias mi='mise install'
alias ml='mise list'

t() {
  if [ $# -eq 0 ]; then
    mise task
  else
    mise run "$@"
  fi
}

_t() {
  if (( CURRENT == 1 )); then
    return 0
  fi
  words=(mise run "${words[@]:1}")
  _mise
}

compdef _t t