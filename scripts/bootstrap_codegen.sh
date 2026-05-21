#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

echo "[bootstrap_codegen] repo root: $repo_root"
echo "[bootstrap_codegen] flutter pub get"
flutter pub get

echo "[bootstrap_codegen] dart run slang"
dart run slang

echo "[bootstrap_codegen] dart run build_runner build --delete-conflicting-outputs"
dart run build_runner build --delete-conflicting-outputs

echo "[bootstrap_codegen] done"
