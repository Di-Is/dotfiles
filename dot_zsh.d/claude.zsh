# Claude Code をメモリ制限付きで起動（Linux: 8GB上限・swap禁止、macOS: 制限なし）
claude() {
  local claude_bin
  claude_bin="$(command -v claude)"
  if [[ -z "$claude_bin" ]]; then
    echo "claude: コマンドが見つかりません" >&2
    return 1
  fi

  if [[ "$OSTYPE" == linux* ]] && command -v systemd-run &>/dev/null; then
    systemd-run --user --scope \
      -p MemoryMax=8G \
      -p MemorySwapMax=0 \
      --unit="claude-session-$$-$RANDOM" \
      "$claude_bin" "$@"
  else
    "$claude_bin" "$@"
  fi
}

alias c="claude"
alias ca="claude --allow-dangerously-skip-permissions"
alias ccu="ccusage"
