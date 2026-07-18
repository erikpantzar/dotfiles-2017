#!/bin/bash
# Claude Code statusLine script
# Shows: model name | context window usage | session token budget remaining
# Reads the JSON payload Claude Code passes on stdin.

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Claude"')

# --- Context window usage -------------------------------------------------
ctx_used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_used_tok=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')

if [ -n "$ctx_used_pct" ] && [ "$ctx_used_pct" != "null" ]; then
  ctx_str=$(awk -v p="$ctx_used_pct" 'BEGIN { printf "Ctx %.0f%%", p }')
elif [ -n "$ctx_used_tok" ] && [ -n "$ctx_size" ] && [ "$ctx_size" != "0" ] && [ "$ctx_size" != "null" ]; then
  ctx_str=$(awk -v u="$ctx_used_tok" -v s="$ctx_size" 'BEGIN { printf "Ctx %.0f%% (%d/%dk)", (u/s)*100, u/1000, s/1000 }')
else
  ctx_str="Ctx n/a"
fi

# --- Session token budget remaining (5h / 7d rate-limit windows) ----------
five_used=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_used=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

if [ -n "$five_used" ] && [ "$five_used" != "null" ]; then
  session_str=$(awk -v u="$five_used" 'BEGIN { printf "5h %.0f%% left", 100 - u }')
  if [ -n "$week_used" ] && [ "$week_used" != "null" ]; then
    session_str=$(awk -v u="$week_used" -v s="$session_str" 'BEGIN { printf "%s, 7d %.0f%% left", s, 100 - u }')
  fi
else
  session_str="Session n/a"
fi

# Dimmed output (status line is rendered dim by the terminal already, but
# we mark it explicitly so it stays readable across themes).
printf "\033[2m%s | %s | %s\033[0m" "$model" "$ctx_str" "$session_str"
