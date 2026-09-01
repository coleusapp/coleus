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

git add . && \
git commit -m "Update coleus packages to $VERSION" && \
git push origin main && \
docker buildx build --platform linux/amd64,linux/arm64 -t "coleus/coleus:$VERSION" -t "coleus/coleus:latest" --push .

echo "Deployed $VERSION"
