#!/bin/bash

NEXT_VERSION=$1
CURRENT_VERSION=$(grep version < composer.json | head -1 | awk -F= "{ print $2 }" | sed 's/[version:,\",]//g' | tr -d '[:space:]')

sed -i "s/\"version\": \"$CURRENT_VERSION\"/\"version\": \"$NEXT_VERSION\"/g" composer.json
echo "$NEXT_VERSION" > "/tmp/next_version"
zip -r "/tmp/release.zip" composer.json README.md CHANGELOG.md src
