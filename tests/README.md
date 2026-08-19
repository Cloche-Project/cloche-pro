# cloche-lts tests

Smoke test only — cloche-lts isn't part of the pro-workstation vs cloche-standard parity gap
analysis (see workspace-root `CLAUDE.md`), so this is intentionally lighter than those two suites.

Uses the shared harness — see [cloche-utils/testing/README.md](../../cloche-utils/testing/README.md)
for `test-lib.sh` details, local/CI usage, and the `CLOCHE_UTILS_DIR` env var.

Run: `./tests/run.sh [image-tag]` (`BUILD_METHOD=bluebuild`, builds `$RECIPE`).

## Checks

- Recipe builds successfully.
- Built image reports the expected base image (`ghcr.io/cloche-project/cloche` per `CLAUDE.md`'s repo table).

## ⚠️ Unverified — confirm before trusting in CI

Not confirmed against this repo's actual `recipes/` tree (no shell/search tooling was available
when this suite was written):

- `RECIPE` in `run.sh` — placeholder is `./recipes/cloche-pro-minimal.yml`, taken from `CLAUDE.md`'s
  mention of this filename; confirm it's correct and current.
- The base-image detection check (`os-release` / `rpm-ostree status` grep) — confirm it actually
  matches how this image reports its base.
