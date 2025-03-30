# alias
alias d="docker"
alias dr="docker run"
alias db="docker build"
alias dp="docker pull"
# WARNING: override dc command
alias dc="docker compose"
alias dcb="docker compose build"
alias dcu="docker compose up"
alias dcd="docker compose down"

# shell completion
if ! command -v docker >/dev/null 2>&1; then
    on_demand_completion docker
fi
