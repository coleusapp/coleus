#!/usr/bin/env bash
#
# Usage: bin/deploy.sh <version>

set -e

VERSION="${1:-patch}"

LATEST_TAG=$(git tag --list 'v*' --sort=-v:refname | head -n1)

if [[ "$VERSION" = 'patch' ]]; then
  VERSION="v$(./bin/semver bump "$VERSION" "$LATEST_TAG")"
fi

composer update 'coleus/*' --with-all-dependencies --no-interaction

php artisan vendor:publish --all -n

git add composer.json composer.lock public/*
git commit -m "Update coleus packages to $VERSION"
git push origin main

if [[ -n "$DOCKERHUB_USERNAME" && -n "$DOCKERHUB_TOKEN" ]]; then
    echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin
fi

docker buildx build --platform linux/amd64,linux/arm64 -t "coleus/coleus:$VERSION" -t "coleus/coleus:latest" --push .

echo "Deployed $VERSION"
