#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

echo "[bootstrap_codegen] repo root: $repo_root"
echo "[bootstrap_codegen] flutter pub get"
flutter pub get

echo "[bootstrap_codegen] dart run build_runner build"
dart run build_runner build

echo "[bootstrap_codegen] done"
