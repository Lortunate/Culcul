#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
output_path="${1:-$repo_root/.codex-temp/phase11-boundary-snapshot.txt}"

mkdir -p "$(dirname "$output_path")"

{
  echo "# Phase 11 Boundary Snapshot"
  echo "repo: $repo_root"
  echo

  echo "## Active planning baseline"
  find "$repo_root/docs/superpowers/specs" -maxdepth 2 -type f | sort
  echo
  find "$repo_root/docs/superpowers/plans" -maxdepth 2 -type f | sort
  echo
  rg -n "phase9|phase10|phase11|Active spec|Active plan" \
    "$repo_root/CLAUDE.md" \
    "$repo_root/docs/architecture" \
    "$repo_root/docs/superpowers" || true
  echo

  echo "## root feature barrel exports of presentation/data internals"
  rg -n "^export .*presentation/|^export .*data/" "$repo_root/lib/features"/*/*.dart || true
  echo

  echo "## public facade repository fields"
  rg -n "^[[:space:]]*final[[:space:]]+[A-Za-z0-9_]*Repository[[:space:]]+[A-Za-z][A-Za-z0-9_]*[[:space:]]*;" \
    "$repo_root/lib/features"/*/application/*facade*.dart \
    "$repo_root/lib/features"/*/application/*_facade.dart || true
  echo

  echo "## presentation -> local data shortcuts"
  rg -n "package:culcul/features/.*/data/" "$repo_root/lib/features"/*/presentation/**/*.dart || true
  echo

  echo "## seam imports of *_repository_impl.dart"
  rg -n "_repository_impl\\.dart" \
    "$repo_root/lib/features"/*/application \
    "$repo_root/lib/features"/*/feature_scope.dart || true
} > "$output_path"

printf 'Wrote phase11 boundary snapshot to %s\n' "$output_path"
