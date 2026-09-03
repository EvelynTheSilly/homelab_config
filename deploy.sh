#!/usr/bin/env bash
set -euo pipefail

FLAKE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_HOST="${TARGET_HOST:-homelab}"
FORCE=0

for arg in "$@"; do
  case "$arg" in
    -f|--force) FORCE=1 ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

cd "$FLAKE_DIR"

UNTRACKED="$(git ls-files --others --exclude-standard)"

if [[ -n "$UNTRACKED" ]]; then
  if [[ "$FORCE" -eq 0 ]]; then
    echo "Error: untracked files present in the flake repo:" >&2
    echo "$UNTRACKED" >&2
    echo "Use --force (-f) to deploy anyway." >&2
    exit 1
  fi
  echo "Warning: deploying with untracked files:" >&2
  echo "$UNTRACKED" >&2
fi

nixos-rebuild switch \
  --flake ".#homelab" \
  --target-host "$TARGET_HOST" \
  --sudo \
  --ask-elevate-password