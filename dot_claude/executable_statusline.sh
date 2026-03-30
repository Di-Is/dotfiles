#!/bin/bash

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name // "unknown"')
pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

if cd "$cwd" 2>/dev/null; then
  starship prompt | tr -d '%{%}' | head -1
fi

# colors
RESET='\033[0m'
DIM='\033[2m'
BG1='\033[48;5;238m'
BG2='\033[48;5;236m'
BG3='\033[48;5;234m'
WHITE='\033[97m'

# context usage color
if [ "$pct" -ge 90 ]; then
  CTX_FG='\033[91m'
elif [ "$pct" -ge 70 ]; then
  CTX_FG='\033[93m'
else
  CTX_FG='\033[92m'
fi

# progress bar
bar_width=15
filled=$((pct * bar_width / 100))
empty=$((bar_width - filled))

if [ "$pct" -ge 90 ]; then
  BG_FILL='\033[41m'
elif [ "$pct" -ge 70 ]; then
  BG_FILL='\033[43m'
else
  BG_FILL='\033[42m'
fi
BG_EMPTY='\033[100m'

filled_part=$(printf "%${filled}s")
empty_part=$(printf "%${empty}s")

# elapsed time
mins=$((duration_ms / 60000))
secs=$(((duration_ms % 60000) / 1000))

printf "${BG1}${WHITE} ${model} ${RESET}"
printf "${BG2}${WHITE} Cost: \$$(printf '%.2f' "$cost") ${RESET}"
printf "${BG3}${WHITE} ${BG_FILL}${filled_part}${RESET}${BG_EMPTY}${empty_part}${RESET}"
printf " ${CTX_FG}Ctx: ${pct}%%${RESET}"
printf "${DIM} ${mins}m${secs}s${RESET}"
echo
