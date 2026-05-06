# Phase 4: CI/CD & Code Quality Pipeline

**Status:** DRAFT
**Date:** 2026-05-06
**Goal:** Establish automated quality gates — CI pipeline, test automation, lint scripts, and developer task runner.

## Context

Phase 3 structural normalization is 100% complete. `lib/shared/` is fully retired. 83 test files exist across features and architecture guards. However:

- No CI/CD pipeline (no GitHub Actions, no GitLab CI)
- No automated lint/analysis scripts
- No task runner (Makefile or equivalent)
- Tests only run manually via `flutter test`
- No coverage reporting

## Design

### 1. GitHub Actions CI Pipeline

Create `.github/workflows/ci.yml` with three jobs:

**Job: analyze**
```yaml
- flutter analyze --no-fatal-infos
- dart format --output=none --set-exit-if-changed .
```

**Job: test**
```yaml
- flutter test --coverage
- Upload coverage artifact
```

**Job: build-check** (optional, slower)
```yaml
- flutter build apk --debug --target-platform android-arm64
```

**Triggers:** push to `master`, all PRs.
**Caching:** `~/.pub-cache`, `.dart_tool/`.

### 2. Developer Task Runner

Create `Makefile` with targets:

| Target | Command |
|--------|---------|
| `make analyze` | `flutter analyze` |
| `make test` | `flutter test` |
| `make test-coverage` | `flutter test --coverage && genhtml coverage/lcov.info -o coverage/html` |
| `make format` | `dart format .` |
| `make format-check` | `dart format --output=none --set-exit-if-changed .` |
| `make codegen` | `dart run build_runner build --delete-conflicting-outputs` |
| `make i18n` | `dart run slang` |
| `make all` | `analyze && test` |
| `make ci` | `format-check && analyze && test` |

### 3. Architecture Guard Integration

The existing `test/architecture/` tests (phase3_legacy_import_paths_test.dart, etc.) should be part of the CI test suite. No changes needed — they already run with `flutter test`.

### 4. Coverage Reporting

- Generate `lcov.info` via `flutter test --coverage`
- CI uploads as artifact
- Optional: integrate with Codecov or Coveralls (future enhancement)

### 5. Pre-commit Hooks (Optional)

Consider `dart format` pre-commit hook via `lefthook` or simple git hook. Not blocking for initial CI.

## Out of Scope

- Codecov/Coveralls integration (future)
- Android/iOS build CI (future)
- Deployment/release automation (future)
- Pre-commit hooks (future, separate spec)

## Verification

```bash
# Local
make ci

# CI
# Push to branch, verify GitHub Actions green
```

## Effort

Low-medium. ~3 new files, no code changes.
