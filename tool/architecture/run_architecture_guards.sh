#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$repo_root"

echo "[1/5] Placeholder seam scan"
if rg -n "UnimplementedError|TODO\(\)" lib/app/runtime lib/core/session lib/core/bootstrap/providers; then
  echo "Placeholder seam scan failed."
  exit 1
fi

echo "[2/5] Shared import guard"
if [[ -d lib/shared ]]; then
  echo "lib/shared exists; architecture violation."
  exit 1
fi
if rg -n "package:culcul/shared/|lib/shared/" lib; then
  echo "shared import scan failed."
  exit 1
fi

echo "[3/5] Source/generated Dart split"
python - <<'PY'
import re
from pathlib import Path

def is_generated_dart(path: str) -> bool:
    is_localization = re.match(r"^lib/i18n/strings(?:_[A-Za-z_]+)?\.g\.dart$", path) is not None
    return (
        path.endswith(".g.dart")
        or path.endswith(".freezed.dart")
        or path.startswith("lib/protos/")
        or is_localization
    )

paths = sorted(str(path).replace("\\", "/") for path in Path("lib").rglob("*.dart"))
source = [path for path in paths if not is_generated_dart(path)]
generated = [path for path in paths if is_generated_dart(path)]

print(f"Source Dart files: {len(source)}")
print(f"Generated Dart files: {len(generated)}")
print(f"Total Dart files: {len(paths)}")
PY

echo "[4/5] Barrel guard"
python - <<'PY'
import re
from pathlib import Path

def is_generated_dart(path: str) -> bool:
    is_localization = re.match(r"^lib/i18n/strings(?:_[A-Za-z_]+)?\.g\.dart$", path) is not None
    return (
        path.endswith(".g.dart")
        or path.endswith(".freezed.dart")
        or path.startswith("lib/protos/")
        or is_localization
    )

approved = {"lib/core/contracts/core_contracts.dart", "lib/ui/ui.dart"}
hits = []
for path in Path("lib").rglob("*.dart"):
    normalized = str(path).replace("\\", "/")
    if is_generated_dart(normalized):
        continue
    lines = path.read_text(encoding="utf-8").splitlines()
    code = [line.strip() for line in lines if line.strip() and not line.strip().startswith("//")]
    if code and all(line.startswith("export ") or line.startswith("import ") for line in code):
        if normalized not in approved:
            hits.append(normalized)
if hits:
    print("Unapproved barrel-like files:")
    for hit in hits:
        print(hit)
    raise SystemExit(1)
PY

echo "[5/5] Flutter architecture tests"
flutter test \
  test/architecture/architecture_boundary_guard_test.dart \
  test/architecture/architecture_domain_dto_guard_test.dart \
  test/architecture/architecture_feedback_guard_test.dart \
  --reporter compact
