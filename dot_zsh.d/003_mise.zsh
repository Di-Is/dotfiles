
# activation
cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}
cache_file="$cache_dir/mise.zsh"
if [[ ! -r "$cache_file" ]]; then
  echo "A"
  mkdir -p $cache_dir
  mise activate zsh > $cache_file
fi
source "$cache_file"
unset cache_dir cache

# eval "$(mise activate zsh)"

# shell completion
on_demand_completion "mise" "mise completion zsh"

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
