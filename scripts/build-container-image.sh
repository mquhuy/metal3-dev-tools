#!/usr/bin/env bash

# This script is meant to be used by CI, to build and push container images to the container hub.
# However, it can be used by human on a linux environment, with the following requirements:
#  - An existing credentials towards the hub, with push and delete permissions.
#  - Needed tools (git, docker, curl, etc. are installed)

set -eu

set -o pipefail

HUB="${CONTAINER_IMAGE_HUB:-quay.io}"
HUB_ORG="${CONTAINER_IMAGE_HUB_ORG:-metal3-io}"
BRANCH_NAME=${BUILD_CONTAINER_IMAGE_BRANCH:-main}
KEEP_TAGS=${BUILD_CONTAINER_IMAGE_KEEP_TAGS:-3}
REPO_LOCATION="/tmp/metal3-io"
NEEDED_TOOLS=("git" "curl" "docker" "jq")
__dir__=$(realpath "$(dirname "$0")")
IMAGE_NAME=${IMAGE_NAME}
echo "IMAGE_NAME=${IMAGE_NAME}"
echo "BUILD_CONTAINER_REPO=${BUILD_CONTAINER_REPO}"
echo "BUILD_CONTAINER_DOCKERFILE_LOC=${BUILD_CONTAINER_DOCKERFILE_LOC}"
echo "IMAGE_GIT=${BUILD_CONTAINER_IMAGE_GIT_REFERENCE}"
