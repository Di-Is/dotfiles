# zcompile
# Ref. https://zenn.dev/fuzmare/articles/zsh-source-zcompile-all
function source {
  ensure_zcompiled $1
  builtin source $1
}
function ensure_zcompiled {
  local compiled="$1.zwc"
  if [[ ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
    echo "Compiling $1"
    zcompile $1
  fi
}

ensure_zcompiled $0
ensure_zcompiled ~/.zshrc
