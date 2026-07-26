#!/usr/bin/env bash
# UserPromptSubmit hook: inject response-style rules only when the session is
# running an Opus model, whose lean system prompt ships no writing guidance.
# Model detection reads the session transcript (assistant entries carry the
# model ID; /model switches leave a "Set model to ..." stdout record), falling
# back to the default model in settings.json. Fails open: if the model cannot
# be determined, nothing is injected.

RULES_FILE="$HOME/.claude/prompts/opus-rules.md"

input=$(cat)
model=""

transcript=$(printf '%s' "$input" | jq -r '.transcript_path // empty' 2>/dev/null)
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  line=$(tac "$transcript" 2>/dev/null | grep -m1 -e '"type":"assistant"' -e 'Set model to' || true)
  case "$line" in
    *'"type":"assistant"'*)
      model=$(printf '%s' "$line" | jq -r '.message.model // empty' 2>/dev/null)
      ;;
    *'Set model to'*)
      model=$(printf '%s' "$line" \
        | jq -r '.message.content | if type == "array" then map(.text // "") | join("") else . end' 2>/dev/null \
        | sed -e $'s/\x1b\\[[0-9;]*m//g' -e 's/.*Set model to //' -e 's/ and saved.*//')
      ;;
  esac
fi

if [ -z "$model" ]; then
  model=$(jq -r '.model // empty' "$HOME/.claude/settings.json" 2>/dev/null)
fi

case "$(printf '%s' "$model" | tr '[:upper:]' '[:lower:]')" in
  *opus*) cat "$RULES_FILE" ;;
esac
exit 0
