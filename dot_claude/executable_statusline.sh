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

# Context usage calculation from session logs
context_percent=""
session_dir="$HOME/.claude/projects"

if [[ -d "$session_dir" ]]; then
  # Find the most recent JSONL file (compatible with both macOS and Linux)
  if [[ "$(uname)" == "Darwin" ]]; then
    # macOS: use stat -f
    latest_log=$(find "$session_dir" -name "*.jsonl" -type f -exec stat -f '%m %N' {} \; 2>/dev/null | sort -rn | head -1 | cut -d' ' -f2-)
  else
    # Linux: use -printf
    latest_log=$(find "$session_dir" -name "*.jsonl" -type f -printf '%T@ %p\n' 2>/dev/null | sort -rn | head -1 | cut -d' ' -f2-)
  fi

  if [[ -n "$latest_log" && -f "$latest_log" ]]; then
    # Get only the LAST usage entry (cumulative value)
    last_usage=$(grep '"usage"' "$latest_log" 2>/dev/null | tail -1)

    if [[ -n "$last_usage" ]]; then
      input_tokens=$(echo "$last_usage" | grep -o '"input_tokens":[0-9]*' | grep -o '[0-9]*')
      cache_create=$(echo "$last_usage" | grep -o '"cache_creation_input_tokens":[0-9]*' | grep -o '[0-9]*')
      cache_read=$(echo "$last_usage" | grep -o '"cache_read_input_tokens":[0-9]*' | grep -o '[0-9]*')

      input_tokens=${input_tokens:-0}
      cache_create=${cache_create:-0}
      cache_read=${cache_read:-0}

      total=$((input_tokens + cache_create + cache_read))

      # Add reserved tokens offset
      reserved=45000
      total=$((total + reserved))

      # Default context window: 200k tokens
      max_context=200000

      if [[ $total -gt 0 ]]; then
        percent=$((total * 100 / max_context))
        [[ $percent -gt 100 ]] && percent=100
        context_percent="${percent}%"
      fi
    fi
  fi
fi

# Output: starship + [model name] - [context usage: XX%]
echo "${starship_out} [model: ${model}] - [context usage: ${context_percent:-0%}]"
