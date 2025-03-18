# aliases
alias uvr="uv run"
alias uvs="uv sync"
alias uvl="uv lock"
alias uvtl="uv tool"
alias uvtr="uv tree"
alias uvb="uv build"
alias uvp="uv publish"
alias uva="uv add"
alias uvrm="uv remove"
alias upsu="uv self update"

# shell completion
# uv shell completion tips (See. https://github.com/astral-sh/uv/issues/10707)
autoload -Uz compinit && compinit
eval "$(uv generate-shell-completion zsh)"
