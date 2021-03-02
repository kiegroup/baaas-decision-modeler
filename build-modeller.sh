#!/usr/bin/env bash
set -e

YARN_VERSION="1.19.1"
NODE_VERSION="v12.16.3"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REGISTRY_LOCATION=quay.io/rblake/baaas-modeller

function check_node() {
  NODE=$(which node)
  if [ "NODE" = "" ] ; then
    printf "node is required. please install it at version '%s'.\n" "$NODE_VERSION"
    exit 1
  fi

  VERSION=$($NODE -v)
  if [ "$VERSION" != "$NODE_VERSION" ] ; then
    printf "node is installed, but at version '%s'. Version '%s' is required.\n" "$VERSION" "$NODE_VERSION"
    exit 1
  fi

}

function check_yarn() {
  YARN=$(which yarn)
  if [ "$YARN" = "" ] ; then
    printf "yarn is required. please install it at version '%s'.\n" "$YARN_VERSION"
    exit 1
  fi

  VERSION=$($YARN -v)
  if [ "$VERSION" != "$YARN_VERSION" ] ; then
    printf "yarn is installed, but at version '%s'. Version '%s' is required.\n" "$VERSION" "$YARN_VERSION"
    exit 1
  fi
}

check_node
check_yarn

cd "$SCRIPT_DIR/kogito-tooling/" && yarn run init
cd "$SCRIPT_DIR/kogito-tooling/" && yarn run build:fast -- -- --mode production --devtool none
GIT_SHA=$(cd "$SCRIPT_DIR/kogito-tooling" && git rev-parse HEAD )
DOCKER_IMAGE="$REGISTRY_LOCATION:$GIT_SHA"
cd "$SCRIPT_DIR" && docker build -t "$DOCKER_IMAGE" .
docker push "$DOCKER_IMAGE"
