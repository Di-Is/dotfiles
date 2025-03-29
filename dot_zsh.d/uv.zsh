# aliases
alias uvr="uv run"
alias uvrp="uv run python"
alias uvi="uv init"
alias uvs="uv sync"
alias uvl="uv lock"
alias uvtl="uv tool"
alias uvtr="uv tree"
alias uvb="uv build"
alias uvpu="uv publish"
alias uvpip="uv pip"
alias uvpy="uv python"
alias uva="uv add"
alias uvrm="uv remove"
alias uvsu="uv self update"

# shell completion
on_demand_completion "uv" "uv generate-shell-completion zsh"
on_demand_completion "uvx" "uvx --generate-shell-completion zsh"
