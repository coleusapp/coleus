#!/usr/bin/env bash
#
# Usage: bin/deploy.sh <version>

set -e

DOCKER_IMAGE="coleus/coleus"

VERSION="${1:-patch}"

LATEST_TAG=$(git tag --list 'v*' --sort=-v:refname | head -n1)

if [[ "$VERSION" = 'patch' ]]; then
  VERSION="v$(./bin/semver bump "$VERSION" "$LATEST_TAG")"
fi

composer update 'coleus/*' --with-all-dependencies --no-interaction

git add composer.json composer.lock
git commit -m "Update coleus packages to $VERSION"
git push origin main

docker build -t "$DOCKER_IMAGE:$VERSION" -t "$DOCKER_IMAGE:latest" .

if [[ -n "$DOCKERHUB_USERNAME" && -n "$DOCKERHUB_TOKEN" ]]; then
    echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin
fi

docker push "$DOCKER_IMAGE:$VERSION"
docker push "$DOCKER_IMAGE:latest"

echo "Deployed $VERSION"
