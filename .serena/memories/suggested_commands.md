# Suggested Commands

- Shell policy: on Windows, use Git Bash explicitly. Prefer forward slash paths, e.g. `cd /e/Projects/Flutter/Culcul`; do not use PowerShell/cmd for project commands.
- Ready issues: `bd ready --json`.
- Claim issue: `bd update <id> --claim --json`.
- Create linked issue: `bd create "Title" --description="Details" -t task -p 2 --deps discovered-from:<parent-id> --json`.
- Analyze: `make analyze` or `flutter analyze --no-fatal-infos`.
- Tests: `make test` or `flutter test`.
- Coverage: `make test-coverage`.
- Format: `make format`; check only: `make format-check` or `dart format --output=none --set-exit-if-changed .`.
- Codegen: `make codegen` or `dart run build_runner build --delete-conflicting-outputs`.
- Localization: `make i18n` or `dart run slang`.
- Fresh checkout generated recovery: `bash scripts/bootstrap_codegen.sh` runs `flutter pub get`, `dart run slang`, then build_runner.
- Architecture guards: `bash tool/architecture/run_architecture_guards.sh` if present/needed; architecture tests also live under `test/architecture/`.
- GitNexus stale index fix: `npx gitnexus analyze`.
- Pre-commit GitNexus scope check: use GitNexus `detect_changes(scope: "all", repo: "Culcul")`.