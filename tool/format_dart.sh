#!/usr/bin/env bash
set -euo pipefail

mode="write"
if [[ "${1:-}" == "--check" ]]; then
  mode="check"
  shift
elif [[ "${1:-}" == "--write" ]]; then
  shift
fi

if [[ $# -gt 0 ]]; then
  echo "Usage: bash tool/format_dart.sh [--check|--write]" >&2
  exit 64
fi

is_generated_dart() {
  local file="$1"
  [[ "$file" == *.g.dart ]] ||
    [[ "$file" == *.freezed.dart ]] ||
    [[ "$file" == *.pb.dart ]] ||
    [[ "$file" == *.pbenum.dart ]] ||
    [[ "$file" == lib/protos/* ]]
}

files=()
while IFS= read -r -d '' file; do
  if [[ "$file" != *.dart ]]; then
    continue
  fi
  if [[ ! -f "$file" ]]; then
    continue
  fi
  if is_generated_dart "$file"; then
    continue
  fi
  files+=("$file")
done < <(
  {
    git ls-files -z -- '*.dart'
    git ls-files -z --others --exclude-standard -- '*.dart'
  } | sort -zu
)

if [[ ${#files[@]} -eq 0 ]]; then
  echo "No hand-written Dart files to format."
  exit 0
fi

format_args=()
if [[ "$mode" == "check" ]]; then
  format_args=(--output=none --set-exit-if-changed)
fi

printf '%s\0' "${files[@]}" | xargs -0 -r -n 40 dart format "${format_args[@]}"
