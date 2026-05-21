# Phase 38 Architecture SSOT And Startup Performance Plan

## Operating Rules

- Use Git Bash for shell commands.
- Use Context7 before changing Flutter, Riverpod, go_router, Dio, Retrofit,
  Drift, or codegen APIs.
- Use GitNexus impact analysis before editing any function, class, or method.
- If impact is high or critical, isolate that work into a later phase and warn
  before editing.
- Do not create markdown TODO lists for tracking. Use bd for follow-up work.
- Do not leave compatibility shims after callers move.
- Do not mix high-risk player/router refactors with startup or DTO cleanup.

## Current Problem Analysis

The repo already has the desired top-level architecture. The work should target
real complexity:

- DTO leakage into non-data code.
- Cross-feature application/domain seams that are too broad.
- Startup work that waits on network cache/cookie resources before first frame.
- Shell UI can bypass runtime performance policy when visual effects opt out.
- Dynamic route ownership drift exists in notification route parts, but
  `DynamicDetailRoute` impact is high and must be handled as its own route
  migration slice.
- Stale architecture documentation counts and active-doc routing.
- Tooling drift between CI Flutter version and the lockfile.

## Recommended Directory Structure

Keep the structure described in
`docs/specs/2026-05-21-phase38-architecture-ssot-startup-performance.md`.

## New Architecture Summary

Phase 38 keeps the existing app/core/features/ui split and tightens ownership:

- `app`: startup, root overrides, router, shell.
- `core`: reusable runtime primitives and shared contracts.
- `features`: feature-owned data/application/domain/presentation.
- `ui`: reusable UI only.

Startup is split into first-frame and deferred/lazy resources. DTO cleanup is
handled feature by feature.

## Phase 1: Documentation And Startup Resource Split

Goal: activate Phase 38 and remove avoidable pre-first-frame startup work.

Files:

- `docs/architecture/architecture-guide.md`
- `docs/specs/2026-05-21-phase38-architecture-ssot-startup-performance.md`
- `docs/plans/2026-05-21-phase38-architecture-ssot-startup-performance.md`
- `lib/app/bootstrap/app_bootstrap.dart`
- `lib/core/bootstrap/providers/cache_store_provider.dart`
- `lib/core/bootstrap/providers/cookie_jar_provider.dart`
- `lib/core/bootstrap/providers/storage_provider.dart`
- `lib/app/shell/main_shell.dart`
- `lib/core/data/network/dio_client.dart` only if provider API changes.

Steps:

1. Archive Phase 37 active spec/plan as superseded.
2. Update the architecture guide active doc links and current baseline.
3. Run GitNexus impact on startup symbols.
4. Keep `SharedPreferences` in `AppBootstrap.initialize()`.
5. Move network cache/cookie resource construction out of
   `AppBootstrap.initialize()`.
6. Prefer keeping synchronous provider read APIs if this can be done with lazy
   construction; otherwise update `DioClient` and direct dependents in one
   isolated patch.
7. Re-enable runtime performance policy for low-risk shell visual effects after
   `MainShell` impact analysis.
8. Do not move dynamic routes in this phase; `DynamicDetailRoute` has high
   impact and belongs in a later route ownership slice.
9. Run codegen if Riverpod provider source changes.
10. Run focused tests and architecture guards.

Verification:

```bash
dart run build_runner build --delete-conflicting-outputs
dart format --output=none --set-exit-if-changed docs lib test
flutter analyze --no-fatal-infos
bash tool/architecture/run_architecture_guards.sh
flutter test test/architecture
```

## Phase 2: Auth/Profile Session Seam

Goal: reduce cross-feature auth/profile coupling without hiding it behind
one-call adapters.

Files to audit:

- `lib/features/auth/application/auth_session_providers.dart`
- `lib/features/auth/application/auth_controller.dart`
- `lib/features/profile/application/profile_cache_actions.dart`
- `lib/features/profile/application/profile_session_providers.dart`
- cross-feature callers listed by the import audit.

Steps:

1. Use GitNexus impact on `currentUser`, `Auth`, and profile cache symbols.
2. Keep `UserSession` in `core/contracts` only if it remains a real shared
   contract.
3. Move cache/session behavior to the owning feature unless it is an app-level
   lifecycle concern.
4. Delete any one-call provider action that only forwards to another provider.
5. Add provider tests around login/logout/session refresh.

## Phase 3: Video DTO Leakage Slice

Goal: stop presentation widgets from importing `video/data/dtos` directly.

Files to audit first:

- `lib/features/video/presentation/detail/video_detail_state.dart`
- `lib/features/video/presentation/detail/video_detail_view_model.dart`
- `lib/features/video/data/dtos/video_detail_dto.dart`
- `lib/features/video/data/video_repository_impl.dart`

Steps:

1. Run impact on the selected video DTO/read-model symbols.
2. Decide whether each DTO is transport-only or promoted feature contract.
3. Introduce one application/domain read model only where it replaces multiple
   DTO-shaped usages.
4. Move mapping into the repository or a feature-local mapper.
5. Delete duplicate model/state definitions after callers move.
6. Run focused video detail tests and codegen if needed.

## Phase 4: Dynamic/Live DTO And Repository Cleanup

Goal: reduce DTO leakage and repository partial complexity after the video
slice proves the pattern.

Files to audit first:

- `lib/features/dynamic/application/dynamic_feed_controller.dart`
- `lib/features/dynamic/data/dynamic_repository_impl.dart`
- `lib/features/dynamic/data/dynamic_repository_impl.*.dart`
- `lib/features/live/presentation/view_models/live_room_state.dart`

Steps:

1. Keep `RequestExecutor` stable.
2. Move CSRF/publish/comment helpers into focused data-layer collaborators only
   when that reduces repeated behavior.
3. Do not add facade/service shells without state or policy.
4. Add focused tests for mappers and repository behavior.

## Phase 5: Router And Public Feature Seams

Goal: keep app router as the route source of truth while making feature public
APIs explicit.

Files to audit:

- `lib/app/router/app_routes.dart`
- all `lib/features/*/route_entry.dart`
- root feature files such as `dynamic/dynamic.dart`,
  `dynamic/dynamic_post_card.dart`, and `video/video_action_sheet_entry.dart`.

Steps:

1. Run impact before moving any root feature public seam.
2. Keep route pages behind `route_entry.dart`.
3. Move non-route public seams to intentionally named feature API files only
   when external callers remain.
4. Delete root feature files that become unused.

## Phase 6: Tooling And CI Alignment

Goal: make quality gates trustworthy for continued large refactors.

Files:

- `.github/workflows/ci.yml`
- `scripts/bootstrap_codegen.sh`
- `pubspec.yaml`
- `pubspec.lock`

Steps:

1. Align CI Flutter version with `pubspec.lock` SDK constraints.
2. Add `--delete-conflicting-outputs` to bootstrap codegen script if it remains
   the recovery path.
3. Add direct `fixnum` dependency only if generated protobuf output remains
   checked in and imports it directly.
4. Do not remove native/runtime packages just because they lack Dart imports.

## Delete, Merge, Or Archive Checklist

Archive:

- Phase 37 active spec and plan.

Keep until guard replacement:

- `docs/architecture/phase30-application-seam-inventory.md`
- `docs/architecture/phase30-presentation-data-inventory.md`

Delete or merge after impact and caller migration:

- DTO-shaped duplicate state/read models in video/dynamic/live.
- Search duplicate naming around DTO/application result types.
- Inline endpoint constants in search/auth APIs.
- No-value one-call action providers.
- Low-value utility files after reference audit.

## First Phase Commands

Use these in order after Phase 1 edits:

```bash
dart run build_runner build --delete-conflicting-outputs
dart format docs/architecture/architecture-guide.md \
  docs/specs/2026-05-21-phase38-architecture-ssot-startup-performance.md \
  docs/plans/2026-05-21-phase38-architecture-ssot-startup-performance.md \
  lib/app/bootstrap/app_bootstrap.dart \
  lib/app/shell/main_shell.dart \
  lib/core/bootstrap/providers/cache_store_provider.dart \
  lib/core/bootstrap/providers/cookie_jar_provider.dart \
  lib/core/bootstrap/providers/storage_provider.dart
flutter analyze --no-fatal-infos
bash tool/architecture/run_architecture_guards.sh
flutter test test/architecture
```
