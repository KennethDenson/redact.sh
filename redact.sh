#!/usr/bin/env bash

# Simple config redactor
# Redacts full values for matching keys listed in .redact-patterns

RED='\033[0;31m'
RESET='\033[0m'
CONFIG_FILE=".redact-patterns"

# Load patterns from config file into an array
SENSITIVE_KEYS=()
if [[ -f "$CONFIG_FILE" ]]; then
  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    SENSITIVE_KEYS+=("$line")
  done < "$CONFIG_FILE"
else
  echo "Warning: $CONFIG_FILE not found. Using default patterns." >&2
  SENSITIVE_KEYS=(KEY TOKEN PASSWORD SECRET USER)
fi

# Convert list into regex pattern like: "KEY|TOKEN|PASSWORD"
PATTERN=$(IFS='|'; echo "${SENSITIVE_KEYS[*]}")

# Validate input
if [[ -z "$1" || ! -f "$1" ]]; then
  echo "Usage: $0 path/to/file" >&2
  exit 1
fi

# Process line by line
while IFS= read -r line; do
  original="$line"

  # Redact full values for matching keys
  if echo "$line" | grep -Eq "^($PATTERN)="; then
    line=$(echo "$line" | sed -E "s/^($PATTERN)=.*/\1=REDACTED/")
    echo -e "${RED}${line}${RESET}"
  else
    echo "$line"
  fi
done < "$1"