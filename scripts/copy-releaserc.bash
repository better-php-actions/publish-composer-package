#!/usr/bin/env bash

# MAIN_BRANCH='master'
# ACTION_DIR="."
# PACKAGE_SLUG=a
# PACKAGE_NAME=a
# GITHUB_WORKSPACE='.'

releaserc=$(cat "$ACTION_DIR/templates/.releaserc")

releaserc="${releaserc//GITHUB_ACTION_MAIN_BRANCH/$MAIN_BRANCH}"
releaserc="${releaserc//GITHUB_ACTION_PATH/$ACTION_DIR}"
releaserc="${releaserc//GITHUB_ACTION_PACKAGE_SLUG/$PACKAGE_SLUG}"
releaserc="${releaserc//GITHUB_ACTION_PACKAGE_NAME/$PACKAGE_NAME}"

echo "$releaserc" > "$GITHUB_WORKSPACE/.releaserc"
