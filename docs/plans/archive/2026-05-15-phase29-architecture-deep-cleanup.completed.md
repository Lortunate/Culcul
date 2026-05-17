# Phase 29 Architecture Deep Cleanup Plan

Spec: `docs/specs/archive/2026-05-15-phase29-architecture-deep-cleanup.completed.md`

## Status

Completed on 2026-05-15.

Supersedes:

- `docs/plans/archive/2026-05-15-phase28-deep-simplification.completed.md`

## Execution Rules

- Use Git Bash.
- Refresh GitNexus before code edits: `npx gitnexus analyze`.
- Before editing any function, class, or method, run GitNexus upstream impact on the target symbol and report risk.
- Do not touch unrelated local changes.
- Use generated Riverpod providers for new or rewritten provider code.
- Keep route seams intact unless a concrete route coupling bug is found.
- Do not delete code from broad grep alone; classify first.

## Task 0 - Baseline and Guard Inventory

- [x] Run `git status --short`.
- [x] Run `npx gitnexus analyze`.
- [x] Capture current counts:
  - `lib` Dart total/source/generated.
  - hand-written provider files.
  - confirmed cross-feature internal imports.
  - duplicate model/DTO names.
  - placeholder/no-op matches.
- [x] Run baseline verification:
  - `flutter analyze`
  - `flutter test test/architecture`
- [x] Record any pre-existing failures before code edits.

## Task 1 - Provider Tail Cleanup

Targets:

- `lib/core/session/session_lifecycle_providers.dart`
- `lib/core/services/audio_handler.dart`
- `lib/features/auth/application/auth_session_providers.dart`

Steps:

- [x] Run GitNexus impact for each provider symbol before edits.
- [x] Decide per file: migrate to `@riverpod`, inline into an existing generated provider, or keep with written justification.
- [x] Preserve overrides and service identity.
- [x] Run `dart run build_runner build --delete-conflicting-outputs`.
- [x] Run targeted analyzer/tests for touched areas.

Acceptance:

- [x] No unnecessary hand-written provider remains.
- [x] Any retained hand-written provider has a concrete lifecycle/override reason documented in code or plan notes.

## Task 2 - Placeholder and No-op Classification

Initial audit matched 80 files. Known sample areas:

- `lib/ui/widgets/**`
- `lib/ui/assemblies/**`
- `lib/core/utils/json_utils.dart`
- `lib/core/services/audio_playback_state_gate.dart`
- `lib/features/dynamic/data/article_parsing/**`
- `lib/features/video/presentation/player/hooks/**`

Steps:

- [x] Generate a classification table: real nullable behavior, legitimate empty fallback, cleanup target, dead code.
- [x] Remove only cleanup/dead targets.
- [x] Replace meaningless wrappers with direct imports/calls.
- [x] Keep parser/UI fallback behavior when tests or runtime expectations depend on it.

Acceptance:

- [x] Meaningless `TODO`, `UnimplementedError`, pass-through wrappers, and fake abstraction shells are gone.
- [x] Legitimate nullable/empty fallback behavior is documented by name in the task notes.

## Task 3 - Feature Boundary Import Cleanup

Confirmed targets:

- `lib/features/auth/presentation/view_models/auth_view_model.dart` imports `profile/data`.
- `lib/features/dynamic/presentation/view_models/topic_search_view_model.dart` imports `search/data`.
- `lib/features/live/presentation/view_models/live_room_view_model.dart` imports `profile/data`.
- `lib/features/home/presentation/pages/home_page.dart` imports `search/presentation`.
- `lib/features/home/presentation/widgets/home_video_actions.dart` imports `video/presentation`.
- `lib/features/home/presentation/widgets/live_view.dart` imports `live/presentation`.
- `lib/features/profile/presentation/widgets/profile_menu.dart` imports `auth/presentation`.
- `lib/features/profile/presentation/widgets/user_dynamic_tab.dart` imports `dynamic/presentation`.

Steps:

- [x] Classify `package:culcul/features/*/(data|presentation)/*` imports by source feature and target feature.
- [x] Keep same-feature internal imports.
- [x] For cross-feature imports, choose one:
  - move shared type/service to `core/contracts` or `core/services`;
  - expose a real `<feature>.dart` or route seam;
  - move duplicated UI into `ui/`.
- [x] Add/extend architecture guard for cross-feature data/presentation imports.

Acceptance:

- [x] Cross-feature imports of another feature's `data/**` or `presentation/**` internals are zero.
- [x] Same-feature imports are not over-policed.

## Task 4 - Duplicate Model and DTO Ownership

Initial exact duplicate names:

- `PrivateSessionList`: presentation view model state plus widget.
- `VideoSubtitle`: video DTO plus protobuf-generated type.

Steps:

- [x] Run GitNexus context/impact before renaming or merging symbols.
- [x] Rename presentation-only widgets/state where names collide but concepts differ.
- [x] Merge only true duplicate DTO/domain concepts.
- [x] Preserve protobuf-generated names unless generation config changes intentionally.
- [x] Review 24 normalized duplicate-name groups and document keep/merge/rename decisions.

Acceptance:

- [x] Exact duplicate names are resolved or explicitly justified.
- [x] Core shared contracts remain the only source for truly shared models.

## Task 5 - Dead-code and Wrapper Triage

Steps:

- [x] Generate orphan candidate inventory and exclude router, generated, `part`, localization, and platform entry points.
- [x] Run impact analysis before deleting any symbol.
- [x] Remove real orphan files and meaningless wrappers.
- [x] Keep thin files only when they encode a real boundary, generated contract, or platform seam.

Acceptance:

- [x] Static orphan candidate list is reduced to false positives or documented retained seams.
- [x] No deleted file was router/generated/part reachable.

## Task 6 - Dependency Source-of-Truth Audit

Steps:

- [x] For each direct dependency in `pubspec.yaml`, verify one of:
  - imported by Dart source;
  - required by generated code;
  - required by platform integration;
  - required by build/tooling.
- [x] Remove unused dependencies only with evidence.
- [x] Treat `flutter_launcher_icons` as low-risk removal candidate if no icon generation config exists.
- [x] Treat `media_kit_libs_video` and `sqlite3_flutter_libs` as high-risk runtime dependencies until desktop/mobile verification proves safe.
- [x] Prefer current project defaults:
  - Riverpod generated providers over custom wiring.
  - `go_router_builder` typed routes over manual route glue.
  - `freezed`/`json_serializable` over hand-written model equality/copy/JSON.
  - `retrofit`/`dio` and shared `RequestExecutor` over custom network wrappers.
  - `drift` for structured persistence where already adopted.

Acceptance:

- [x] `pubspec.yaml` has no unused direct dependency.
- [x] Lockfile changes are explained.

## Task 7 - Final Verification and Closeout

- [x] `dart run build_runner build --delete-conflicting-outputs`
- [x] `dart run drift_dev identify-databases` if Drift files or dependencies changed.
- [x] `flutter analyze`
- [x] `flutter test test/architecture`
- [x] `flutter test`
- [x] `flutter build windows --debug` if media/database/platform dependencies changed.
- [x] `flutter build apk --debug` if media/database/platform dependencies changed.
- [x] Run relevant feature tests for touched areas.
- [x] `gitnexus_detect_changes(scope: "all")`
- [x] Update `docs/architecture/architecture-guide.md` with final Phase 29 counts and completed changes.
- [x] Archive this spec/plan as `.completed.md` only after all acceptance checks pass.

## Completion Notes

- GitNexus force refresh succeeded: 2,214 nodes, 3,011 edges, 27 flows. Dart parser binding was unavailable, so impact for new/renamed Dart symbols returned `UNKNOWN`; edits were constrained by direct references and verification.
- Baseline verification: `flutter test test/architecture` passed; `flutter analyze --no-fatal-infos` reported 267 info-level diagnostics and no warning/error diagnostics.
- Provider tail: the 3 target provider files now use generated Riverpod providers or retain concrete lifecycle/service identity behavior.
- Placeholder/no-op audit: final strict source grep found 0 candidate files for `TODO`, `UnimplementedError`, `UnsupportedError`, `=> []`, or `=> null`.
- Feature boundary audit: final cross-feature private data/presentation import count is 0.
- Duplicate ownership: renamed the notification widget to `PrivateSessionListView` and the video DTO to `VideoSubtitleDto`; final exact duplicate name count is 0.
- Dependency audit: no direct dependency is removable. `riverpod` is direct because `package:riverpod/riverpod.dart` is imported. `flutter_launcher_icons` is retained by `flutter_launcher_icons.yaml`. `media_kit_libs_video` and `sqlite3_flutter_libs` are retained as runtime/platform dependencies.
- Verification: `dart run build_runner build --delete-conflicting-outputs`, `dart run drift_dev identify-databases`, targeted notification analyze, `flutter test test/architecture`, and `flutter test` passed. Windows/APK builds were not required because media/database/platform dependencies were not changed.

## Parallelization Notes

Safe parallel slices after Task 0:

- Provider tail cleanup.
- Placeholder/no-op classification.
- Dependency usage audit.

Do not parallelize cross-feature import cleanup with duplicate model cleanup unless write sets are explicitly separated.
