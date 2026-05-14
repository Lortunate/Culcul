#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$repo_root"

echo "[1/4] Placeholder seam scan"
if rg -n "UnimplementedError|TODO\(\)" lib/app/runtime lib/core/session lib/core/bootstrap/providers; then
  echo "Placeholder seam scan failed."
  exit 1
fi

echo "[2/4] Shared import guard"
if [[ -d lib/shared ]]; then
  echo "lib/shared exists; architecture violation."
  exit 1
fi
if rg -n "package:culcul/shared/|lib/shared/" lib; then
  echo "shared import scan failed."
  exit 1
fi

echo "[3/4] Barrel guard"
python - <<'PY'
from pathlib import Path
approved = {"lib/core/contracts/core_contracts.dart", "lib/ui/ui.dart"}
hits = []
for path in Path("lib").rglob("*.dart"):
    lines = path.read_text(encoding="utf-8").splitlines()
    code = [line.strip() for line in lines if line.strip() and not line.strip().startswith("//")]
    if code and all(line.startswith("export ") or line.startswith("import ") for line in code):
        normalized = str(path).replace("\\", "/")
        if normalized not in approved:
            hits.append(normalized)
if hits:
    print("Unapproved barrel-like files:")
    for hit in hits:
        print(hit)
    raise SystemExit(1)
PY

echo "[4/4] Flutter architecture tests"
flutter test \
  test/architecture/architecture_boundary_guard_test.dart \
  test/architecture/architecture_domain_dto_guard_test.dart \
  test/architecture/architecture_feedback_guard_test.dart \
  --reporter compact
