#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
output_path="${1:-$repo_root/.codex-temp/phase10-boundary-snapshot.txt}"

mkdir -p "$(dirname "$output_path")"

{
  echo "# Phase 10 Boundary Snapshot"
  echo "repo: $repo_root"
  echo

  echo "## Active planning baseline"
  find "$repo_root/docs/superpowers/specs" -maxdepth 2 -type f | sort
  echo
  find "$repo_root/docs/superpowers/plans" -maxdepth 2 -type f | sort
  echo
  rg -n "phase9|phase10" \
    "$repo_root/CLAUDE.md" \
    "$repo_root/docs/architecture" \
    "$repo_root/docs/superpowers" || true
  echo

  echo "## core -> features imports"
  rg -n "package:culcul/features/" "$repo_root/lib/core" --glob "*.dart" || true
  echo

  echo "## cross-feature presentation imports"
  find "$repo_root/lib/features" -type f -name "*.dart" \
    ! -name "*.g.dart" \
    ! -name "*.freezed.dart" \
    -print0 | xargs -0 awk '
      FNR == 1 { current = FILENAME }
      /package:culcul\/features\// {
        if (!match(current, /\/features\/([^\/]+)\//, owner_parts)) {
          next
        }
        if (match($0, /package:culcul\/features\/([^\/]+)\/presentation\//, match_parts) &&
            match_parts[1] != owner_parts[1]) {
          print current ":" FNR ":" $0
        }
      }
    ' || true
  echo

  echo "## dto / protobuf boundary leaks"
  rg -n "features/notification/data/dtos|protos/dm.pb.dart" \
    "$repo_root/lib/features" \
    --glob "*.dart" || true
  echo
  
  echo "## Phase 10: Barrel presentation exports"
  rg -n "^export 'presentation/" "$repo_root/lib/features"/*/*.dart || true
  echo
  
  echo "## Phase 10: feature_scope data provider leaks"
  rg -n "RepositoryProvider|ApiProvider" "$repo_root/lib/features"/*/feature_scope.dart || true
} > "$output_path"

printf 'Wrote phase10 boundary snapshot to %s\n' "$output_path"
