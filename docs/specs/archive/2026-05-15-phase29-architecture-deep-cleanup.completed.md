# Phase 29 Architecture Deep Cleanup Spec

## Status

Completed on 2026-05-15.

Supersedes:

- `docs/specs/archive/2026-05-15-phase28-deep-simplification.completed.md`

## Context

Phases 1-28 retired `lib/shared/`, standardized the `app/` + `core/` + `features/` + `ui/` shape, removed barrel chains, collapsed thin domain/repository layers, migrated most providers to Riverpod generation, consolidated error/feedback/network patterns, simplified bootstrap, and removed known dead infrastructure.

The current codebase is structurally healthy, but the planning audit still found cleanup targets that should be handled before another feature pass:

1. **Provider tail cleanup** - Only 3 hand-written provider files remain:
   - `lib/core/session/session_lifecycle_providers.dart`
   - `lib/core/services/audio_handler.dart`
   - `lib/features/auth/application/auth_session_providers.dart`
2. **UI placeholder/no-op audit** - The broad scan matched 80 files with `TODO`, nullable placeholder returns, empty collection returns, or similar patterns. Some are legitimate nullable APIs; the next phase must classify them and remove only meaningless wrappers or dead branches.
3. **Feature boundary audit** - 9 cross-feature direct imports of another feature's `data/**` or `presentation/**` remain. Same-feature imports are allowed internally; cross-feature imports must be eliminated or moved behind approved public seams.
4. **Duplicate model/DTO ownership** - Exact duplicate names were found for `PrivateSessionList` and `VideoSubtitle`, with 24 normalized duplicate-name groups that need classification before any rename/delete.
5. **Dependency source-of-truth audit** - Phase 28 removed `uuid` and `archive`. New candidates include `flutter_launcher_icons`, while `media_kit_libs_video` and `sqlite3_flutter_libs` must be treated as platform-runtime dependencies unless platform verification proves otherwise.
6. **Dead wrappers and pass-through code** - Phase 27/28 removed the obvious infrastructure shells. Remaining trivial adapters, extension-only files, and fake abstraction layers need symbol-level impact analysis before deletion.
7. **Dead-code triage** - Static import analysis found 112 orphan candidates, with expected false positives around router, generated, and `part` entry points. This must be a classified pass, not bulk deletion.

## Goals

1. Finish Riverpod 3 provider modernization by migrating or deleting the 3 remaining hand-written providers.
2. Classify the 80 placeholder/no-op matches into real behavior, cleanup targets, and false positives; remove dead or meaningless code.
3. Remove the 9 confirmed cross-feature data/presentation imports by moving shared contracts/UI to approved seams.
4. Classify duplicate model/DTO ownership and merge only true duplicate concepts.
5. Verify dependency usage and remove packages only when imports and generated code prove they are unused.
6. Keep one source of truth for shared models, runtime services, feedback, routing seams, and persistence contracts.
7. Preserve the current typed `go_router_builder` route surface unless a route seam is demonstrably broken.
8. Refresh architecture guards so future phases fail on the specific patterns cleaned in this phase.

## Non-Goals

- No UI redesign.
- No route system rewrite.
- No storage backend rewrite.
- No API behavior changes.
- No broad feature rewrites outside the cleanup targets.
- No compatibility layer for deleted abstractions unless current behavior requires it.
- No dependency replacement based only on preference; each removal needs usage evidence.

## Success Criteria

- [x] GitNexus index refreshed before code edits; each edited symbol has upstream impact noted.
- [x] 3 remaining hand-written providers are either migrated to `@riverpod` or explicitly justified in this spec/plan.
- [x] Placeholder/no-op audit produces a checked inventory; meaningless wrappers/dead branches are removed.
- [x] 9 confirmed cross-feature imports of another feature's `data/**` or `presentation/**` internals are zero.
- [x] Duplicate model/DTO ownership inventory is classified; true duplicates are merged or renamed.
- [x] Dependency audit confirms every `pubspec.yaml` dependency is imported, generated, or platform-required; unused packages are removed.
- [x] Architecture tests cover the cleaned patterns.
- [x] `dart run build_runner build --delete-conflicting-outputs` succeeds if generated providers/models change.
- [x] `dart run slang` succeeds if localization generated files are touched.
- [x] `flutter analyze` has 0 errors and 0 warnings.
- [x] `flutter test test/architecture` passes.
- [x] Full relevant test suite passes, or blockers are documented with exact failing commands.

Completion notes:

- GitNexus force refresh completed, but the local Dart parser binding still skipped Dart files; symbol-level impact for `PrivateSessionList` returned `UNKNOWN`. The rename was constrained to the widget class and its single page call site.
- Final source audit: `lib/` Dart total 877, source 636, generated 241.
- Final cleanup counts: cross-feature private data/presentation imports 0; placeholder/no-op candidate files 0; exact duplicate names 0. The protobuf `VideoSubtitle` name is preserved; the video data DTO is `VideoSubtitleDto`.
- Dependency audit found no removable direct dependencies. `riverpod` is directly imported by source, `flutter_launcher_icons` is retained because `flutter_launcher_icons.yaml` is the icon generation source, and `media_kit_libs_video` and `sqlite3_flutter_libs` are retained as platform/runtime dependencies.
- `flutter analyze --no-fatal-infos` still reports 267 info-level lints from the existing ruleset, with no warning/error diagnostics.

## Risks

- **Provider lifecycle risk** - `audio_handler` and session providers may depend on app startup order or long-lived service identity. Migration must preserve disposal and override behavior.
- **False-positive cleanup risk** - Many nullable returns and empty lists are legitimate UI or parser behavior. The phase must classify before deleting.
- **Feature import audit risk** - Same-feature internal imports are expected; only cross-feature coupling is a violation.
- **Dependency risk** - Some packages are used only by generated code or platform setup. Do not remove based on Dart import grep alone; `media_kit_libs_video` and `sqlite3_flutter_libs` need platform runtime verification.
- **GitNexus staleness** - Current GitNexus index was reported behind HEAD. Run `npx gitnexus analyze` before symbol edits.

## Approach

Work in narrow slices with a verification gate after each slice:

1. Refresh analysis baseline and GitNexus index.
2. Provider tail cleanup.
3. Placeholder/no-op classification and deletion.
4. Cross-feature import cleanup.
5. Duplicate model/DTO ownership cleanup.
6. Dependency source-of-truth audit.
7. Dead-code triage.
8. Guard/test updates and final verification.

Each slice should leave the repo buildable. If a slice uncovers higher-risk architecture work, split it into a follow-up spec instead of expanding Phase 29 silently.
