#!/usr/bin/env bash
set -e

cp "$ACTION_DIR/package.json.template" "$GITHUB_WORKSPACE/package.json"
cp "$ACTION_DIR/package-lock.json.template" "$GITHUB_WORKSPACE/package-lock.json"

