# Phase 30 Architecture Optimization Spec

## Status

Completed on 2026-05-15.

Supersedes:

- `docs/specs/archive/2026-05-15-phase29-architecture-deep-cleanup.completed.md`

Archive check:

- No active legacy spec exists to move. Phase 22-24 specs are already `.superseded.md`; Phase 25-29 specs are already `.completed.md`.
- Completion snapshot: `lib/` has 640 authored Dart files, 241 generated Dart files, and 881 total Dart files.

## Context

Phase 29 left the top-level architecture in a healthy state: `lib/shared/` is gone, generated/source code is separated, broad public barrels are limited to `core_contracts.dart` and `ui.dart`, and cross-feature private `data/**` or `presentation/**` imports are zero.

The remaining architecture work is semantic and maintainability-focused, not another top-level directory rewrite. The next cleanup should keep the current `app/` + `core/` + `features/` + `ui/` shape while removing softer coupling, duplicated generation paths, and large mixed-responsibility files.

Current planning audit:

1. `lib/` has 636 authored Dart files and 241 generated Dart files.
2. Cross-feature private `data/**`/`presentation/**` imports are 0.
3. Cross-feature `domain/**`/`application/**` imports are 30. Many are likely legitimate session/search/profile seams, but they are still coupling points and need classification.
4. Same-feature internal imports are common and allowed, but presentation-to-data/proto coupling is still high enough to hide DTO ownership drift.
5. `lib/features/dynamic/domain/entities/dynamic_extension.dart` imports `features/dynamic/data/dtos/dynamic_response.dart`; domain still knows a DTO shape.
6. `lib/app/runtime/root_overrides.dart` imports `features/auth/application/auth_session_cookie_refresher.dart`; app runtime still wires a feature implementation directly.
7. `feature_scope.dart` files are 0 while docs and guards still describe `feature_scope.dart` as an approved seam. That rule is now either stale or a future seam, not current truth.
8. Riverpod provider modernization is effectively complete in authored source. Current raw regex hits are false positives in `ImageProvider` naming or local variables, not hand-written providers.
9. `build.yaml` runs `slang_build_runner`, while `scripts/bootstrap_codegen.sh` also runs `dart run slang`; localization generation has two entry points and should have one source of truth.
10. `build.yaml` runs `retrofit_generator` over `lib/**`; actual Retrofit API entry points are narrower.
11. Large files remain in notification data, video UI, live socket handling, auth helpers, network policy, and WBI helper code.
12. `ArticleDetailCommentActionResult.noop()` and related dynamic workflow paths need a behavior audit so no-op results are either meaningful domain states or removed.

## Goals

1. Establish one active Phase 30 planning surface in `docs/specs/` and `docs/plans/`.
2. Classify the original 30 cross-feature `domain/**`/`application/**` imports into approved public seams, contract candidates, or coupling to remove.
3. Reduce coupling where a feature presentation layer reaches into another feature application layer for session/search/profile state.
4. Remove domain-to-DTO knowledge, starting with the dynamic feature extension leak.
5. Classify presentation-to-data/proto dependencies and move reusable view-facing models or mappers to domain/application where they are true behavior, not response shape.
6. Decouple app runtime/bootstrap from feature implementation classes where a core/app contract is clearer.
7. Decide whether `feature_scope.dart` is retired or reintroduced; update docs and guards to match actual architecture.
8. Make code generation single-source-of-truth:
   - one canonical localization generation path;
   - tighter generator includes where broad includes are not needed.
9. Split large mixed-responsibility files only where the split creates a clear owner and simpler tests.
10. Audit no-op workflow results and delete zero-behavior abstractions when behavior is already represented elsewhere.
11. Keep modern library usage aligned with current docs:
   - Riverpod generated providers, `Notifier`, and `AsyncNotifier` for new or rewritten provider state;
   - typed `go_router_builder` route seams;
   - Freezed/json_serializable/Retrofit/Drift/Slang where they are already the project source of truth.
8. Extend architecture guards for Phase 30 findings without over-policing same-feature internals.

## Non-Goals

- No UI redesign.
- No route system rewrite.
- No storage backend rewrite.
- No API behavior changes.
- No compatibility layers for deleted wrappers.
- No package replacement just because another package is popular.
- No deletion based only on grep. Each deletion needs usage evidence and verification.
- No generated protobuf, localization, Freezed, Drift, Retrofit, or router output hand edits.

## Target Slices

### Slice 1: Cross-feature application seam classification

Classify the original 30 cross-feature `domain/**`/`application/**` imports. Expected categories:

- approved app/session seam;
- should move to `core/contracts`;
- should move to `ui/`;
- should be exposed through a narrow feature public API;
- should be removed as accidental coupling.

### Slice 2: Session/search/profile public contracts

If multiple features consume auth, profile, or search application providers, create or tighten a single public seam instead of importing implementation files from many features.

### Slice 3: Codegen source-of-truth cleanup

Pick one localization generation path. Prefer the build graph if it is reliable; otherwise remove `slang_build_runner` from the build graph and keep the explicit script path. Tighten `retrofit_generator` includes to actual API files after a green generation run proves outputs are stable.

### Slice 4: Domain DTO and presentation data/proto cleanup

Remove direct domain knowledge of data DTOs. Then classify presentation imports of data/proto shapes in high-pressure features: `live`, `favorites`, `notification`, `profile`, and `dynamic`. Keep same-feature imports only when they are clearly private UI mapping; otherwise move view-facing contracts to domain/application or reusable UI seams.

### Slice 5: App runtime and feature-scope seam alignment

Decouple `lib/app/runtime/root_overrides.dart` from feature implementation classes when a stable app/core contract can own the seam. Decide whether `feature_scope.dart` is retired or should return as an explicit runtime composition seam; update `CLAUDE.md`, `architecture-guide.md`, and guards accordingly.

### Slice 6: Large-file decomposition

Target only files with mixed responsibilities, not files that are merely long:

- `lib/features/notification/data/notification_repository_impl.dart`
- `lib/features/video/presentation/player/controls/player_settings_sheet.options.dart`
- `lib/features/video/presentation/comments/comment_reply_page.dart`
- `lib/core/services/audio_handler.dart`
- `lib/features/video/presentation/detail/video_detail_view_model.dart`
- `lib/features/live/presentation/view_models/live_socket_service.dart`
- `lib/features/auth/data/auth_repository_impl.helpers.dart`
- `lib/core/data/network/endpoint_policy.dart`
- `lib/core/data/network/providers/wbi_helper_provider.dart`

### Slice 7: No-op workflow cleanup

Audit `ArticleDetailCommentActionResult.noop()` and callers. Keep it only if it represents an explicit user-visible no-op state. Otherwise replace it with direct control flow or a more precise result.

### Slice 8: Guard and docs refresh

Add focused guards for cleaned Phase 30 patterns, update architecture docs with the final baseline, and keep generated/source counts explicit.

## Success Criteria

- [x] Archived Phase 30 spec and plan exist in `docs/specs/archive/` and `docs/plans/archive/`.
- [x] `CLAUDE.md` and `docs/architecture/architecture-guide.md` point to Phase 30 as completed and show no active phase.
- [x] Cross-feature `data/**`/`presentation/**` imports remain 0.
- [x] Cross-feature `domain/**`/`application/**` imports are classified; accidental coupling is removed or moved behind approved seams.
- [x] Domain files no longer import feature `data/dtos/**`.
- [x] Presentation-to-data/proto imports are classified; remaining same-feature view mappings were inventoried and documented.
- [x] App runtime/bootstrap no longer imports feature implementation classes unless explicitly justified.
- [x] `feature_scope.dart` docs and guards match the real architecture.
- [x] Localization generation has one canonical path and no duplicated generation responsibility.
- [x] Retrofit generator include scope is tightened and verified by build output stability.
- [x] Large-file splits reduce responsibility count and keep behavior unchanged.
- [x] Meaningless no-op workflow abstractions are removed or documented as explicit behavior.
- [x] Architecture guards cover new constraints without flagging same-feature internals.
- [x] `npx gitnexus analyze` has been run before symbol edits.
- [x] `dart run build_runner build --delete-conflicting-outputs` succeeds if generated surfaces change.
- [x] `dart run build_runner build --delete-conflicting-outputs` or the chosen canonical localization command succeeds if localization generation changes.
- [x] `flutter analyze --no-fatal-infos` completes with no errors or warnings; remaining findings are info-level only.
- [x] `flutter test test/architecture --reporter compact` passes.
- [x] Relevant feature tests pass for every touched slice.

## Risks

- Cross-feature application imports may encode real feature contracts. Do not remove before replacing the contract.
- Generated code can churn heavily. Keep generated edits isolated and use `--delete-conflicting-outputs`.
- Localization generation has known historical `InvalidOutputException` risk when two tools write the same output.
- Platform/runtime dependencies can look unused in source grep. Keep `media_kit_libs_video` and `sqlite3_flutter_libs` unless runtime verification proves removal is safe.
- GitNexus Dart parser can still miss Dart symbol detail. Run the required tool first, then fall back to file-level impact notes when symbol lookup is weak.
