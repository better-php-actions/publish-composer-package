#!/usr/bin/env bash
set -e

# Check if package.json exists
if [ ! -f package.json ]; then
  echo "available=no" > "$GITHUB_OUTPUT"
  exit 0
fi

echo "available=yes" > "$GITHUB_OUTPUT"
exit 0
