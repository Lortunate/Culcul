# Task Completion

- If code changed, run focused tests for the touched behavior, then broaden based on blast radius. Baseline commands: `make analyze`, `make test`; use `make ci` for format-check + analyze + tests when feasible.
- If generated providers/routes/DTOs/localization changed, run the needed generator: `dart run slang` and/or `dart run build_runner build --delete-conflicting-outputs`.
- Run architecture guards or architecture tests when changing boundaries/imports/source-of-truth rules: `bash tool/architecture/run_architecture_guards.sh` if available, or focused `flutter test test/architecture/...`.
- Run GitNexus `detect_changes(scope: "all", repo: "Culcul")` before committing; verify affected symbols/processes match intended scope.
- Use `bd` for all remaining/follow-up work; do not create markdown TODO/task lists. Close finished issues with `bd close <id> --reason "Completed" --json`.
- Required session-completion workflow in project instructions includes `git pull --rebase`, `bd dolt push`, `git push`, then `git status` showing up to date with origin. Do not claim a coding work session is complete until push succeeds, unless the user explicitly limits the task to local/no-push work.
- Current workspace may have user-owned changes. Before committing or pushing, inspect status and avoid reverting unrelated changes.