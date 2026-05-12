# Phase 17: Model Consolidation & Code Modernization — Plan

**Status:** Superseded  
**Date:** 2026-05-13  
**Spec:** `docs/superpowers/specs/2026-05-13-phase17-model-consolidation-and-code-modernization.md`

## Verified Baseline

- `flutter test test/architecture --reporter compact` passes (Phase 16 guard-green)
- `dart run build_runner build --delete-conflicting-outputs` succeeds

---

## Task 1: Archive Phase 16 & Clean Stale Issues

**Goal:** Clear the decks — archive completed phase, supersede stale tracking.

- [ ] Move Phase 16 spec to `archive/` with `Status: Completed`
- [ ] Move Phase 16 plan to `archive/` with `Status: Completed`
- [ ] Update `CLAUDE.md` to reference Phase 17 as active
- [ ] Supersede Phase 8 stale issues (culcul-lw3, culcul-9f6, culcul-fnf)

---

## Task 2: Consolidate Video Models

**Goal:** Single source of truth for video owner/stat types. Features compose core contracts.

### 2A: Remove ProfileVideoOwner & ProfileVideoStats

- [ ] Delete `ProfileVideoOwner` and `ProfileVideoStats` from `lib/features/profile/domain/entities/profile_video.dart`
- [ ] Update `ProfileVideo` to use `VideoOwner` and `VideoStat` from `core/contracts/video_model_contract.dart`
- [ ] Update all consumers of `ProfileVideo` (profile repository, view models, widgets)
- [ ] Run `build_runner` to regenerate freezed code

### 2B: Simplify RankingVideo

- [ ] Refactor `RankingVideo` to hold a `VideoOwner` reference instead of flattened `ownerName`
- [ ] Or: replace `RankingVideo` entirely with `VideoModel` if the API response matches
- [ ] Update ranking repository DTO mapping
- [ ] Update ranking UI consumers

### 2C: Remove Dead Re-export Files

- [ ] Delete `lib/features/live/domain/live_models.dart` (re-exports live_dtos)
- [ ] Delete `lib/features/video/domain/entities/comment_model.dart` (re-exports comment_contract)
- [ ] Delete `lib/features/dynamic/data/dtos/emote_response.dart` (re-exports domain entity)
- [ ] Delete `lib/features/dynamic/data/dtos/dynamic_response.dart` (re-exports domain entity)
- [ ] Delete `lib/features/search/domain/entities/search_query.dart` (re-exports contract)
- [ ] Update all import paths to point to the actual source files
- [ ] Verify no broken imports with `dart analyze`

---

## Task 3: Consolidate User Models

**Goal:** Unified user identity contract, feature-specific models compose it.

### 3A: Unify UserCardModel & UserProfileInfo

- [ ] Evaluate if `UserProfileInfo` can be replaced by `UserCardModel` (both have mid, name, face/avatarUrl)
- [ ] If yes: remove `UserProfileInfo`, update `UserProfileLookup` interface to return `UserCardModel`
- [ ] If no (different semantics): keep both but ensure field naming is consistent (standardize on `face` or `avatarUrl`)
- [ ] Update all consumers

### 3B: Freezed-ify ProfileRelationUser

- [ ] Convert `ProfileRelationUser`, `RelationOfficialVerify`, `RelationVipInfo` to freezed classes
- [ ] Add `fromJson` factories (these come from API responses)
- [ ] Update consumers to use generated equality/copyWith
- [ ] Run `build_runner`

### 3C: Standardize User ID Type

- [ ] Audit: `UserCardModel.mid` is String, `ProfileRelationUser.mid` is int
- [ ] Standardize to `int` (Bilibili API uses numeric mid) or `String` (display-friendly)
- [ ] Update all consumers for the chosen type

---

## Task 4: Freezed Migration for Value Objects

**Goal:** Zero hand-written copyWith/equality (except ThemeExtension).

Files to migrate:

- [ ] `lib/core/contracts/search_query_contract.dart` — `SearchQuery`
- [ ] `lib/core/contracts/search_result_contract.dart` — `SearchResultPage`
- [ ] `lib/features/video/presentation/player/playback_snapshot_view_model.dart` — `PlaybackSnapshot`
- [ ] `lib/features/video/presentation/player/listen_sleep_timer_view_model.dart` — `ListenSleepTimerState`
- [ ] `lib/features/notification/presentation/view_models/chat_view_model.types.dart` — `ChatState`
- [ ] `lib/features/dynamic/presentation/view_models/article_detail_view_model.dart` — `ArticleDetailUiState`
- [ ] `lib/features/dynamic/presentation/view_models/publish_dynamic_view_model.dart` — `PublishDynamicUiState`
- [ ] `lib/features/favorites/presentation/view_models/favorites_view_model.folder_resources.dart` — `FavFolderDetailState`
- [ ] `lib/features/video/presentation/overlays/danmaku/ns_danmaku/models/danmaku_option.dart` — `DanmakuOption`

For each:
1. Add `@freezed` annotation and `part` directives
2. Remove hand-written `copyWith`, `==`, `hashCode`
3. Run `build_runner`
4. Verify consumers still compile

---

## Task 5: @riverpod Provider Migration

**Goal:** All feature-level providers use code generation for consistency and type safety.

### 5A: Search Providers

- [ ] Convert `searchSuggestionsProvider` to `@riverpod` function
- [ ] Convert `DefaultSearchController` to `@riverpod` AsyncNotifier
- [ ] Convert `TrendingRankingController` to `@riverpod` AsyncNotifier
- [ ] Convert `SearchResultController` to `@riverpod` AsyncNotifier with family
- [ ] Run `build_runner`, verify search feature works

### 5B: Playback Providers

- [ ] Convert `playbackSnapshotProvider` to `@riverpod` StreamProvider
- [ ] Convert `playbackSnapshotValueProvider` to `@riverpod` function
- [ ] Convert `playbackPositionProvider`, `playbackDurationProvider`, `playbackBufferProvider` to `@riverpod`
- [ ] Run `build_runner`, verify player works

### 5C: Other Feature Providers

- [ ] Convert `topicSearchViewModelProvider` (dynamic feature)
- [ ] Convert `liveRoomPageCommandsProvider` (live feature)
- [ ] Convert `favoriteFolderCommandWorkflowProvider` (favorites feature)
- [ ] Convert `chatPageCommandWorkflowProvider` (notification feature)
- [ ] Convert `showLoginDialogProvider` (auth feature)
- [ ] Run `build_runner`, verify all features

---

## Task 6: Remove Runtime Dependency Double-Indirection

**Goal:** Eliminate the unnecessary `runtime_dependencies.dart` watch-only layer.

- [ ] Audit all consumers of `runtimeCacheStoreProvider`, `runtimeSharedPreferencesProvider`, `runtimeCookieJarProvider`
- [ ] Replace with direct imports of `cacheStoreProvider`, `sharedPreferencesProvider`, `cookieJarProvider` from bootstrap
- [ ] Delete `lib/core/runtime_dependencies.dart` and `lib/core/runtime_dependencies.g.dart`
- [ ] Run `dart analyze` and `flutter test`

---

## Task 7: Final Verification

- [ ] `dart run build_runner build --delete-conflicting-outputs` — no errors
- [ ] `dart analyze` — no new warnings
- [ ] `flutter test test/architecture --reporter compact` — all pass
- [ ] `flutter test` — full test suite passes
- [ ] No hand-written `copyWith` remains (grep verification)
- [ ] No duplicate Owner/Stat/UserCard definitions (grep verification)
- [ ] Update `docs/architecture/architecture-guide.md` with Phase 17 changes

---

## Execution Order

Tasks 1 → 2 → 3 → 4 → 5 → 6 → 7

Tasks 2, 3, 4 can be partially parallelized (independent model changes), but each must pass `build_runner` before the next starts. Task 5 depends on Task 4 (freezed types used in providers). Task 6 is independent. Task 7 is final gate.

## Risk Notes

- **Breaking generated code**: Each freezed/riverpod migration requires `build_runner`. Run after each file change, not in batch.
- **API response shape**: `ProfileVideo` has extra fields (aid, tname, ctime, state, attribute, tid, interVideo) that `VideoModel` doesn't. The consolidation keeps `ProfileVideo` as a feature-specific model that *composes* core types, not replaces them entirely.
- **Search provider complexity**: `SearchResultController` uses family + autoDispose + pagination. The @riverpod migration must preserve this lifecycle behavior exactly.
