#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
output_path="${1:-$repo_root/.codex-temp/phase16-boundary-snapshot.txt}"

mkdir -p "$(dirname "$output_path")"

{
  echo "# Phase 16 Boundary Snapshot"
  echo "repo: $repo_root"
  echo

  echo "## Active planning baseline"
  find "$repo_root/docs/superpowers/specs" -maxdepth 2 -type f | sort
  echo
  find "$repo_root/docs/superpowers/plans" -maxdepth 2 -type f | sort
  echo
  rg -n "Active spec|Active plan|Phase 16" \
    "$repo_root/CLAUDE.md" \
    "$repo_root/docs/architecture" \
    "$repo_root/docs/superpowers" || true
  echo

  echo "## red/green architecture test summary command"
  echo "flutter test test/architecture --reporter compact"
  echo

  echo "## bootstrap provider import inventory"
  rg -n "package:culcul/core/bootstrap/providers|package:culcul/shared/providers" \
    "$repo_root/lib" \
    "$repo_root/test" \
    --glob "*.dart" || true
  echo

  echo "## archive active-status scan"
  rg -n "\\*\\*Status:\\*\\* Active" \
    "$repo_root/docs/superpowers/specs/archive" \
    "$repo_root/docs/superpowers/plans/archive" || true
  echo

  echo "## dependency modernization candidates"
  dart pub outdated --json | node -e '
    let data = "";
    process.stdin.on("data", (chunk) => data += chunk);
    process.stdin.on("end", () => {
      const wanted = new Set([
        "dio_cache_interceptor",
        "drift",
        "drift_flutter",
        "go_router",
        "go_router_builder",
        "build_runner",
      ]);
      const parsed = JSON.parse(data);
      for (const pkg of parsed.packages ?? []) {
        if (!wanted.has(pkg.package)) continue;
        const current = pkg.current?.version ?? "-";
        const upgradable = pkg.upgradable?.version ?? "-";
        const resolvable = pkg.resolvable?.version ?? "-";
        const latest = pkg.latest?.version ?? "-";
        console.log(
          `${pkg.package} current=${current} upgradable=${upgradable} resolvable=${resolvable} latest=${latest}`,
        );
      }
    });
  '
} > "$output_path"

printf 'Wrote phase16 boundary snapshot to %s\n' "$output_path"
