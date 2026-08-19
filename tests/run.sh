#!/usr/bin/env bash
# Smoke test entrypoint for cloche-lts. See tests/README.md for scope and
# the list of unverified paths to confirm before trusting this in CI.

set -uo pipefail

UTILS_DIR="${CLOCHE_UTILS_DIR:-../cloche-utils}"
# shellcheck source=../../cloche-utils/testing/test-lib.sh
source "$UTILS_DIR/testing/test-lib.sh"

IMAGE="${1:-cloche-lts-test}"
BUILD_METHOD="bluebuild"
RECIPE="./recipes/cloche-pro-minimal.yml"

EXPECTED_BASE_IMAGE="ghcr.io/cloche-project/cloche"

test_base_image() {
    exec_in_image "cat /usr/lib/os-release" | grep -q "$EXPECTED_BASE_IMAGE" \
        || exec_in_image "rpm-ostree status" | grep -q "$EXPECTED_BASE_IMAGE"
}

main() {
    build_image || { echo "Build failed, aborting tests."; exit 1; }

    echo ""
    echo "=== Smoke tests ==="
    run_check "recipe builds"        true
    run_check "expected base image"  test_base_image

    print_summary
}

main
