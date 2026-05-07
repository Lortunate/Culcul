# Phase 6: Architecture Optimization & Code Quality

**Status:** DRAFT
**Date:** 2026-05-07
**Goal:** Normalize feature structure, tighten lint rules, reconcile documentation, and improve code readability/maintainability.

## Context

Phases 1-5 are complete: shared/ retirement, route seams, CI/CD, test coverage (20%), and performance optimization. The codebase has 908 Dart files across 13 features, but structural inconsistencies remain:

- **5/13 features lack `application/` and `domain/` layers** (history, home, ranking, settings, to_view)
- **`home` feature is non-compliant** — missing `feature_scope.dart`, barrel export, and two subdirectories
- **CLAUDE.md and AGENTS.md diverge** — different beads profiles, AGENTS.md missing architecture section
- **Architecture guide is stale** — doesn't reflect Phase 5 completion or performance optimization
- **Lint rules are loose** — `avoid_print: false`, no architecture boundary enforcement in analysis_options
- **`core/utils/` is a dumping ground** — 11 unrelated utility files in one directory

## Design

### 1. Feature Structure Normalization (P1)

Normalize the 5 non-compliant features to match the standard structure. For simple features (history, ranking, to_view, settings), the `application/` and `domain/` layers will contain minimal files — just enough to maintain structural consistency.

**home** (most non-compliant):
- Add `feature_scope.dart`
- Add `home.dart` barrel export
- Add `domain/` with repository interface
- Add `application/` with workflow stubs if orchestration logic exists in presentation

**history, ranking, to_view, settings**:
- Add `domain/` with repository interfaces (move from data/ if they exist inline)
- Add `application/` only if orchestration logic exists in presentation layer

**Rule**: Don't add empty directories. Each added directory must contain at least one file.

### 2. Documentation Reconciliation (P1)

**CLAUDE.md / AGENTS.md**:
- Merge AGENTS.md's detailed beads reference into CLAUDE.md
- Make AGENTS.md a thin pointer to CLAUDE.md (or delete if redundant)
- Ensure single source of truth for architecture rules

**Architecture guide**:
- Update phase history (Phases 1-5 complete, Phase 6 current)
- Add feature structure compliance matrix
- Add links to active spec/plan
- Remove stale "Phase 5 (Current)" references

### 3. Lint Tightening (P2)

**analysis_options.yaml**:
- Set `avoid_print: true` (replace print() with proper logging in non-test code)
- Add `prefer_const_constructors: true` (already default in flutter_lints, but verify enforcement)
- Add `unawaited_futures: true` to catch missing `await` on Futures
- Consider `always_declare_return_types: true`

**Architecture boundary lint** (P3):
- The existing `test/architecture/` tests cover boundary violations at runtime
- Consider adding a custom analyzer plugin or lint rule for compile-time enforcement
- This may be out of scope — runtime tests may be sufficient

### 4. Core Utils Reorganization (P2)

Split `core/utils/` into focused subdirectories:

```
core/utils/
├── format/          # format_utils.dart
├── crypto/          # crypto_utils.dart
├── validation/      # validation_utils.dart
├── json/            # json_compute.dart
├── ids/             # id_utils.dart
├── share/           # share_utils.dart
├── toast/           # toast_utils.dart
├── list/            # list_utils.dart
├── danmaku/         # danmaku_mask_parser.dart
└── core_utils.dart  # barrel export (re-exports all)
```

**Alternative**: Keep flat structure but add barrel export for discoverability. The subdirectory approach adds 11 directories for 11 files — may be overkill. Decision: keep flat, add barrel export.

### 5. Barrel Export Standardization (P2)

Every feature and core module should have a barrel export file:
- `features/<name>/<name>.dart` — exports public API
- `core/<module>/<module>.dart` — exports public API

Currently missing:
- `features/home/home.dart`
- Several core modules lack barrel exports

### 6. Architecture Guide Maintenance (P1)

Update `docs/architecture/architecture-guide.md`:
- Phase history: mark Phases 1-5 complete, add Phase 6
- Add feature structure compliance table
- Update "Current focus" from Phase 5 to Phase 6
- Add links to archived specs
- Document barrel export convention

## Out of Scope

- Video feature decomposition (~120 files, separate spec needed)
- Custom analyzer plugin for compile-time boundary enforcement
- Test coverage beyond 20% (Phase 5 handles this)
- Performance optimization (already complete, just needs committing)

## Verification

```bash
flutter analyze                    # No new warnings
flutter test                       # All tests pass
flutter test test/architecture/    # Architecture guards pass
make ci                            # Full CI pipeline passes
```

## Effort

Medium. ~15-20 file moves/creates for feature normalization, 2-3 doc updates, 1 lint config change.
