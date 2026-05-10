# Phase 8: Architecture Optimization & Code Readability

> **Superseded on 2026-05-09:** This archive is preserved as historical analysis only. Do not treat it as the active planning baseline. Phase 9 replaced it because the remaining work changed shape after several Phase 8 moves had already landed.

**Status:** SUPERSEDED
**Replaced by spec:** `docs/superpowers/specs/2026-05-09-phase9-architecture-rebaseline-design.md`
**Replaced by plan:** `docs/superpowers/plans/2026-05-09-phase9-architecture-rebaseline.md`
**Date:** 2026-05-08
**Goal:** Eliminate remaining architectural violations, consolidate over-fragmented modules, enforce domain boundaries, and improve code readability and maintainability.

## Context

Phases 1-7 established a clean feature-module architecture with all 13 features at FULL compliance, core reorganized, widget categorization, cross-feature decoupling, and error handling unification. However, a deep audit reveals **structural debts** in four areas:

1. **Core layer fragmentation** — `session/` has 13 identical-boilerplate files with 2 dynamic-typed providers; `exceptions.dart` duplicates `app_error.dart`; barrel files are broken
2. **App layer god file** — `provider_overrides.dart` defines 5 adapter classes and 15 overrides in one file with a runtime `UnimplementedError` landmine
3. **UI boundary violations** — ~15 domain-specific widgets (Bilibili video cards, comments, emoji text) live in `ui/widgets/` instead of their feature modules
4. **Feature-level quality issues** — notification repository is a 10-file god class via mixins; `dart:io` leaks into domain; 3 dynamic view models bypass the application layer

This phase addresses all four areas in a single coordinated pass.

---

## Problem Analysis

### P0: Core Layer Cleanup

#### P0a: `core/session/` over-fragmented (13 files → 5)

13 provider files with identical boilerplate: define typedef/interface, declare Provider that throws UnimplementedError. Two providers (`relation_repository_provider.dart`, `search_repository_provider.dart`) are typed `dynamic`, destroying compile-time safety.

**Current:** 13 files, 1 file per provider
**Proposed:** 5 domain-grouped files

| New file | Providers | Lines |
|----------|-----------|-------|
| `user_providers.dart` | currentUserProvider, userCardProvider, userProfileLookupProvider, userProfileInfoProvider | ~30 |
| `relation_providers.dart` | modifyRelationProvider, crossRelationRepositoryProvider (typed!) | ~20 |
| `search_providers.dart` | crossSearchRepositoryProvider (typed!), searchServiceProvider | ~20 |
| `session_lifecycle_providers.dart` | sessionCookieRefresherProvider, sessionRefreshActionProvider, logoutActionProvider, showLoginDialogProvider | ~35 |
| `feature_action_providers.dart` | followListServiceProvider, watchLaterActionsProvider | ~20 |

**Critical fix:** The two `dynamic`-typed providers must be replaced with proper types from `core/contracts/`.

#### P0b: `core/errors/exceptions.dart` is legacy dead code

`exceptions.dart` defines a parallel exception hierarchy (`NetworkException`, `ServerException`, etc.) that duplicates the exact same DioException mapping logic found in `AppError._fromDioException()`. `UnknownException` is dead code — the conversion never reaches it.

**Action:** Audit all usages. If `AppException` subclasses are no longer thrown directly, delete `exceptions.dart` entirely. If some paths still throw them, consolidate the mapping logic into `AppError` only.

#### P0c: `core/core.dart` barrel is broken

Exports only 4 items from a directory with 90+ files. Consumers must know internal structure to import anything. Cherry-picks 2 of 13 session files.

**Action:** Either expand to cover the main public API surface or replace with sub-barrels (`data.dart`, `errors.dart`, `session.dart`, `utils.dart`).

### P1: App Layer Cleanup

#### P1a: `provider_overrides.dart` is a god file

159 lines. 5 private adapter classes (`_AuthSessionAdapter`, `_FollowListAdapter`, `_SearchServiceAdapter`, `_WatchLaterAdapter`, `_UserProfileLookupAdapter`). 15 provider overrides. 20+ package imports. Missing return type annotation on `createProviderOverrides`.

**Critical bug:** `_WatchLaterAdapter.removeFromWatchLater` throws `UnimplementedError` at runtime — a latent crash.

**Action:**
1. Extract each adapter class into its respective feature's `feature_scope.dart`
2. `createProviderOverrides` becomes a thin wiring list
3. Fix the `UnimplementedError` with a proper no-op or implementation
4. Add return type annotation

#### P1b: `ProviderScope` misnesting in `app.dart`

`sessionCookieRefresherProvider` override is applied inside `CulculApp.build()`, creating a new ProviderScope on every rebuild. Should be in root `main()`.

#### P1c: Route sub-file naming misleading

- `app_primary_routes.content_feed.dart` contains login, settings, to-view, history — not content feed
- "primary/secondary" split criteria is unclear

**Proposed rename:**
- `app_shell_routes.dart` → keep (clear)
- `app_primary_routes.dart` → `app_content_routes.dart` (video, live, search, favorites, weekly)
- `app_primary_routes.content_feed.dart` → `app_social_routes.dart` (followings, followers, profile, login, settings, to-view, history)
- `app_secondary_routes.dart` → `app_notification_routes.dart` (notification tree + dynamic detail/publish)

### P2: UI Boundary Enforcement

#### P2a: Domain widgets in `ui/widgets/`

~15 files in `ui/widgets/` are domain-specific Bilibili widgets, not generic UI primitives:

| Widget | Location | Move to |
|--------|----------|---------|
| `video_card/` (4 files) | `ui/widgets/cards/` | `features/video/presentation/widgets/` or `features/home/` |
| `video_list_card/` (4 files) | `ui/widgets/cards/` | `features/video/presentation/widgets/` |
| `comment_*` (6 files) | `ui/widgets/comments/` | `features/video/presentation/widgets/` |
| `bilibili_emoji_text.dart` | `ui/widgets/text/` | `features/dynamic/presentation/widgets/` |
| `video_actions_bottom_sheet.dart` | `ui/widgets/overlays/` | `features/video/presentation/widgets/` |
| `user_tags.dart` | `ui/widgets/users/` | `features/profile/presentation/widgets/` |
| `video_card_skeleton.dart` | `ui/widgets/skeletons/` | `features/video/presentation/widgets/` |
| `video_list_skeleton.dart` | `ui/widgets/skeletons/` | `features/video/presentation/widgets/` |

**Borderline (decide during implementation):**
- `guest_view.dart` — has hardcoded `/login` route. If navigation coupling is injected, it can stay.
- `follow_button.dart` — concept is feature-level but button is generic. Can stay if renamed to `app_toggle_button` or similar.
- `video_thumbnail.dart` — has video-specific duration overlay. Move to video feature.

#### P2b: `ui/ui.dart` barrel broken

Exports only 4 items (responsive + theme). The entire `widgets/` directory is invisible.

**Action:** After moving domain widgets out, expand barrel to export all remaining generic widgets.

#### P2c: Feature-specific constants in `ui/responsive/`

`app_breakpoints.dart` hardcodes `homeFeedMaxWidth`, `homePopularMaxWidth`.
`app_responsive.dart` has `homeGridColumns` getter.

**Action:** Move to `features/home/` or inject via parameters.

### P3: Feature Quality

#### P3a: `notification/` — 3 issues

1. **`application/chat_page_commands.dart`** is a presentation concern (UI callbacks: `clearInput()`, `afterSuccess()`). Move to `presentation/`.

2. **Domain repository leaks `dart:io`** — `NotificationRepository.uploadImage(File file)`. Replace with domain-level `ImageSource` abstraction (e.g., `Uint8List` bytes or a sealed `ImageSource` type).

3. **God class via mixin splitting** — `NotificationRepositoryImpl` spans 10 files with 7 collaborators via mixins. Each collaborator holds a `repo` back-reference. Consider decomposing into standalone Riverpod-provided service classes instead of mixins.

#### P3b: `dynamic/` — view models bypass application layer

3 view models import `domain/repositories/dynamic_repository.dart` directly:
- `dynamic_view_model.dart`
- `user_dynamic_view_model.dart`
- `topic_dynamic_view_model.dart`

**Action:** Either route through `application/dynamic_workflows.dart` or accept the pragmatic shortcut with a documented exception.

#### P3c: `video/` — protobuf leak in domain

`domain/repositories/danmaku_repository.dart` imports `package:culcul/protos/dm.pb.dart`. This is an infrastructure dependency in the domain layer.

**Action:** Wrap protobuf types in domain entities or accept the intentional trade-off with a comment.

### P4: Pagination Consolidation

Two parallel pagination abstractions exist:
1. `OffsetPagedAsyncNotifier` / `CursorPagedAsyncNotifier` — Riverpod mixins managing `AsyncValue<List<T>>`
2. `PagedListState` + `PagedListStateTransitions` — freezed-based state machine

**Action:** Determine if both are actively used. If one is legacy, remove it. If both serve different use cases, document the distinction.

---

## Success Criteria

1. Zero `dynamic`-typed providers in `core/session/`
2. `exceptions.dart` deleted or consolidated into `app_error.dart`
3. `core.dart` barrel exports a useful public API surface
4. `provider_overrides.dart` contains zero adapter class definitions
5. Zero `UnimplementedError` throws in production code paths
6. `ProviderScope` overrides live in `main()`, not in widget `build()`
7. Route sub-files have self-documenting names
8. `ui/widgets/` contains zero domain-specific widgets
9. `ui.dart` barrel exports all generic widgets
10. `notification/` domain layer has zero `dart:io` imports
11. All tests pass, `flutter analyze` clean

---

## Non-Goals

- Rewriting the Riverpod provider pattern (it works well)
- Changing the feature module structure (already clean)
- Touching generated code (`.g.dart`, `.freezed.dart`)
- Modifying the test infrastructure beyond import path updates
- Performance optimization (covered in earlier phases)
