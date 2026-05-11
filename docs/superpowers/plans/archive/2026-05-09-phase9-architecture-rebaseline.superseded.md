# Phase 9 Architecture Rebaseline Implementation Plan

> **Superseded on 2026-05-11 after substantial completion:** This archive is preserved as historical execution context. The repo-wide boundary work it described largely landed. Do not execute it as the active baseline; use `docs/superpowers/specs/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams-design.md` and `docs/superpowers/plans/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams.md` instead. Phase 10 remains archived as the partial-landing bridge between these two phases.

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Status:** SUPERSEDED
**Archived spec:** `docs/superpowers/specs/archive/2026-05-09-phase9-architecture-rebaseline-design.superseded.md`
**Historical bridge archive:** `docs/superpowers/specs/archive/2026-05-11-phase10-slice-normalization-and-public-seam-hardening-design.superseded.md`
**Current active baseline:** `docs/superpowers/specs/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams-design.md`
**Goal:** Rebuild Culcul's runtime ownership, shared presentation surface, and feature public seams so future refactors stop depending on hidden cross-feature internals.

**Architecture:** Phase 9 is a structural rebaseline, not a cosmetic cleanup. The implementation order is: document baseline, runtime/port ownership, shared presentation extraction, feature seam hardening, then slice-specific purity work. The main rule is that shared UI must get a legitimate shared home and `core/` must stop depending on `features/`.

**Tech Stack:** Flutter, Riverpod, Hooks Riverpod, Freezed, Hive, Dio

## Archive Note

Phase 9 is no longer the active execution baseline because the broad boundary goals it targeted now have passing in-repo guards. The remaining debt changed shape: it is now slice-local readability, decomposition, and public-seam cleanup rather than repo-wide rebaseline work. That narrower follow-up is tracked in active Phase 10.

---

---

### Task 1: Lock the Phase 9 baseline and record the starting boundary snapshot

**Files:**
- Modify: `docs/architecture/architecture-guide.md` as needed during implementation
- Optional create: `tool/architecture/` or similar guardrail scripts if the repo needs repeatable scans

- [ ] Confirm the active planning baseline before writing code:

```bash
find docs/superpowers/specs -maxdepth 2 -type f | sort
find docs/superpowers/plans -maxdepth 2 -type f | sort
rg -n "2026-05-09-phase9|2026-05-08-phase8|2026-05-07-phase7" docs/architecture docs/superpowers
```

- [ ] Capture the starting boundary violations and keep the raw output for before/after comparison:

```bash
rg -n "package:culcul/features/" lib/core --glob '*.dart'
awk '
  FNR==1 { current=FILENAME; split(FILENAME,a,"/"); feature=a[3] }
  /package:culcul\\/features\\// {
    if (match($0, /package:culcul\\/features\\/([^\\/]+)\\/presentation\\//, m) && m[1] != feature) {
      print current ":" FNR ":" $0
    }
  }
' $(find lib/features -type f -name '*.dart' ! -name '*.g.dart' ! -name '*.freezed.dart')
rg -n "features/notification/data/dtos|protos/dm.pb.dart" lib/features --glob '*.dart'
```

- [ ] Only start structural edits after the snapshot clearly matches the phase9 spec assumptions.

---

### Task 2: Rebuild runtime composition and neutralize `core/session`

**Files:**
- Create: `lib/app/runtime/bootstrap_coordinator.dart`
- Create: `lib/app/runtime/app_runtime.dart`
- Create: `lib/app/runtime/root_overrides.dart`
- Create: `lib/app/runtime/stores/session_store.dart`
- Create: `lib/app/runtime/stores/settings_store.dart`
- Create: `lib/app/runtime/stores/search_history_store.dart`
- Create: `lib/core/contracts/relation_port.dart`
- Create: `lib/core/contracts/search_port.dart`
- Create: `lib/core/contracts/watch_later_port.dart`
- Modify: `lib/main.dart`
- Modify: `lib/app/bootstrap/app_bootstrap.dart`
- Modify: `lib/app/bootstrap/app_dependencies.dart`
- Modify: `lib/app/bootstrap/provider_overrides.dart`
- Modify: `lib/features/auth/feature_scope.dart`
- Modify: `lib/features/profile/feature_scope.dart`
- Modify: `lib/features/search/feature_scope.dart`
- Modify: `lib/features/to_view/feature_scope.dart`
- Modify: `lib/core/session/relation_providers.dart`
- Modify: `lib/core/session/search_providers.dart`
- Modify: `lib/core/session/session_lifecycle_providers.dart`

- [ ] Add neutral runtime port contracts under `lib/core/contracts/` so `core/session/**` no longer imports feature repository types.

```dart
abstract interface class SearchPort {
  Future<SearchFeedResult> search(SearchQuery query);
}
```

- [ ] Replace raw `AppDependencies` box exposure with a typed runtime object.

```dart
class AppRuntime {
  final SessionStore sessionStore;
  final SettingsStore settingsStore;
  final SearchHistoryStore searchHistoryStore;
  // plus cookie jar, cache store, locale, and other root dependencies
}
```

- [ ] Move root override assembly into `app/runtime/root_overrides.dart` and keep `main.dart` limited to bootstrap + `runApp`.
- [ ] Remove UI-facing actions from `core/session` if they are not truly core ports. `showLoginDialog` should move to an app/auth-facing seam.
- [ ] Add a boot-time verification path that asserts required overrides are present before app startup proceeds.
- [ ] Verify the boundary rule:

```bash
rg -n "package:culcul/features/" lib/core --glob '*.dart'
flutter analyze
```

- [ ] Add or update targeted runtime tests, then commit this task in isolation.

---

### Task 3: Introduce a shared presentation surface for reusable product UI

**Files:**
- Create: `lib/ui/compositions/feed_cards/`
- Create: `lib/ui/compositions/comments/`
- Create: `lib/ui/compositions/text/`
- Create: `lib/ui/compositions/users/`
- Create: `lib/ui/compositions/auth/`
- Modify: `lib/ui/ui.dart`
- Modify: `lib/ui/widgets/feedback/privacy_error_widget.dart`
- Modify: `lib/ui/widgets/skeletons/dynamic_skeleton.dart`
- Modify: `lib/ui/widgets/buttons/follow_button.dart`
- Modify: `lib/ui/widgets/users/guest_view.dart`
- Modify: `lib/features/video/presentation/widgets/**`
- Modify: `lib/features/dynamic/presentation/widgets/bilibili_emoji_text.dart`
- Modify: `lib/features/profile/presentation/widgets/user_tags.dart`
- Modify: all feature consumers that currently import shared widgets from other features

- [ ] Extract the shared video card kit first: `video_card`, `video_list_card`, `video_thumbnail`, and related skeletons move to `ui/compositions/feed_cards/`.
- [ ] Extract shared comment rendering next: `comment_item`, `comment_reply_sheet`, and related shared comment widgets move to `ui/compositions/comments/`.
- [ ] Move shared rich text and user badges into shared ownership: `bilibili_emoji_text.dart`, `VipTag`, and `LevelTag`.
- [ ] Decide the ownership of `FollowButton`, `GuestView`, `PrivacyErrorWidget`, and `DynamicSkeleton`: either move them to `ui/compositions/**` if cross-feature, or return them to feature ownership if not.
- [ ] Publish the new shared surface through explicit barrels instead of deep ad hoc imports.

```dart
export 'compositions/feed_cards/feed_cards.dart';
export 'compositions/comments/comments.dart';
export 'compositions/text/text.dart';
export 'compositions/users/users.dart';
```

- [ ] Verify there are no remaining cross-feature presentation imports for the extracted widgets:

```bash
awk '
  FNR==1 { split(FILENAME,a,"/"); feature=a[3] }
  /package:culcul\\/features\\// {
    if (match($0, /package:culcul\\/features\\/([^\\/]+)\\//, m) && m[1] != feature) {
      print FILENAME ":" FNR ":" $0
    }
  }
' $(find lib/features -type f -name '*.dart' ! -name '*.g.dart' ! -name '*.freezed.dart')
```

- [ ] Run `flutter analyze`, update widget tests/imports, and commit.

---

### Task 4: Harden feature public seams and remove external imports into presentation internals

**Files:**
- Modify: `lib/features/home/presentation/pages/home_page.dart`
- Modify: `lib/features/home/presentation/widgets/live_view.dart`
- Modify: `lib/features/home/home.dart`
- Modify: `lib/features/home/feature_scope.dart`
- Modify: `lib/features/search/presentation/widgets/items/search_topic_item.dart`
- Modify: `lib/features/search/search.dart`
- Modify: `lib/features/search/feature_scope.dart`
- Modify: `lib/features/live/live.dart`
- Modify: `lib/features/live/feature_scope.dart`
- Modify: `lib/features/dynamic/dynamic.dart`
- Modify: `lib/features/dynamic/feature_scope.dart`
- Modify: `lib/features/profile/presentation/widgets/user_dynamic_tab.dart`
- Modify: `lib/features/profile/profile.dart`
- Modify: `lib/features/profile/feature_scope.dart`
- Modify: `lib/features/notification/feature_scope.dart`
- Modify: `lib/features/video/video.dart`
- Modify: `lib/features/video/feature_scope.dart`

- [ ] For each feature that is externally consumed, define a minimal public surface in `<feature>.dart` and/or `feature_scope.dart`.
- [ ] Replace direct imports of presentation pages/providers from other features with route seams or approved public facades.
- [ ] Keep `home` as a composition feature: its presentation layer may depend on shared UI and public feature facades, but not another feature's presentation internals.
- [ ] Stop page-level integration from `search` into `dynamic` by routing topic navigation through route seams or app router adapters.
- [ ] Make `live` expose an application-facing feed facade so `home` stops consuming `liveRecommendProvider` directly.
- [ ] Verify zero remaining external imports into another feature's `presentation/**`:

```bash
awk '
  FNR==1 { current=FILENAME; split(FILENAME,a,"/"); feature=a[3] }
  /package:culcul\\/features\\// {
    if (match($0, /package:culcul\\/features\\/([^\\/]+)\\/presentation\\//, m) && m[1] != feature) {
      print current ":" FNR ":" $0
    }
  }
' $(find lib/features -type f -name '*.dart' ! -name '*.g.dart' ! -name '*.freezed.dart')
```

- [ ] Run targeted feature tests plus `flutter analyze`, then commit.

---

### Task 5: Normalize `notification` into a clean vertical slice

**Files:**
- Create: `lib/features/notification/application/`
- Modify: `lib/features/notification/feature_scope.dart`
- Modify: `lib/features/notification/presentation/chat_page_commands.dart`
- Modify: `lib/features/notification/presentation/widgets/chat_input.dart`
- Modify: `lib/features/notification/presentation/view_models/chat_view_model.dart`
- Modify: `lib/features/notification/data/notification_repository_impl.dart`
- Modify: `lib/features/notification/domain/entities/**`
- Modify: `lib/features/notification/data/dtos/**`
- Create: mapper/value-object files as needed under `data/` and `domain/`

- [ ] Move workflow/command logic out of `presentation/` and into a real `application/` layer.
- [ ] Remove `dart:io` from non-owning layers where bytes/value objects are enough.
- [ ] Stop domain entities from importing DTOs directly; map DTOs in `data/` and expose domain value objects instead.
- [ ] Replace the feature's exported concrete data provider with a stable feature-owned facade.
- [ ] Keep the repository collaborators, but recompose them through clear provider-owned services instead of a pseudo-hidden cluster.
- [ ] Add or update notification tests first for:
  - chat send workflow
  - local paging reads
  - unread/session/feed sync orchestration
- [ ] Verify:

```bash
rg -n "features/notification/data/dtos|dart:io" lib/features/notification --glob '*.dart'
flutter analyze
flutter test test/features/notification
```

- [ ] Commit after the notification slice is independently green.

---

### Task 6: Finish remaining model-boundary cleanup and final architecture verification

**Files:**
- Modify: `lib/features/video/domain/repositories/danmaku_repository.dart`
- Modify: `lib/features/video/data/danmaku_repository_impl.dart`
- Modify: `lib/features/video/domain/entities/**`
- Modify: `lib/features/live/domain/entities/**`
- Modify: `lib/features/dynamic/domain/entities/**`
- Modify: `lib/features/video/presentation/view_models/danmaku_view_model.dart`
- Create: domain wrappers/mappers for danmaku payloads if kept
- Modify: `docs/architecture/architecture-guide.md`
- Modify: any relevant feature barrels and public exports

- [ ] Remove protobuf types from the video domain seam, or isolate them behind domain wrapper models with mapping owned by `data/`.
- [ ] Replace DTO re-export style domain files in `video`, `live`, and `dynamic` with feature-owned models or explicit mapper-owned aliases that stay out of `domain/`.
- [ ] Re-scan the repo for boundary regressions:
  - `core` importing `features`
  - feature-to-feature presentation imports
  - DTO/protobuf leaks into domain
  - shared product UI still trapped in feature internals
- [ ] Refresh `architecture-guide.md` so it describes the post-Phase-9 structure instead of the pre-rebaseline structure.
- [ ] Run the final verification gate:

```bash
flutter analyze
flutter test
rg -n "package:culcul/features/" lib/core --glob '*.dart'
rg -n "data/dtos|protos/dm.pb.dart" lib/features/video lib/features/live lib/features/dynamic lib/features/notification --glob '*.dart'
```

- [ ] Make the final architecture commit only after the boundary scans and test suite are clean.
