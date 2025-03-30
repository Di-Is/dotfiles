# usage: on_demand_completion <command_name> [completion_command]
#   command_name:
#   completion_command: (default: "<command_name> completion zsh")
# Example:
#   on_demand_completion 'docker'
#   on_demand_completion 'gh' 'gh completion -s zsh'
on_demand_completion() {
  local cmd_name=$1
  local completion_command="${2:-${cmd_name} completion zsh}"
  local function_name="_${cmd_name}"

  if ! command -v "$cmd_name" &> /dev/null; then
    echo "Command '$cmd_name' not found. Skipping completion registration."
    return
  fi

  eval "function $function_name() {
    unfunction '$function_name'
    eval \"\$(eval $completion_command)\"
    \$_comps[$cmd_name]
  }"

  compdef $function_name $cmd_name
}
