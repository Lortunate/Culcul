# Phase 18: Architecture Simplification & Single Source of Truth — Plan

**Status:** Active  
**Date:** 2026-05-13  
**Spec:** `docs/superpowers/specs/2026-05-13-phase18-architecture-simplification-and-single-source-of-truth.md`

## Verified Baseline

- `flutter test test/architecture --reporter compact` passes (Phase 16+ guard-green)
- `dart run build_runner build --delete-conflicting-outputs` succeeds
- Phase 17 partial landing confirmed (runtime_dependencies gone, SearchQuery migrated to freezed)

---

## Task 1: Archive Phase 17 & Housekeeping

**Goal:** Clear the decks for Phase 18.

- [ ] Move Phase 17 spec to `archive/` with status `Superseded (remaining work absorbed into Phase 18)`
- [ ] Move Phase 17 plan to `archive/` with status `Superseded`
- [ ] Update `CLAUDE.md` to reference Phase 18 as active
- [ ] Supersede any stale beads issues from Phase 17

---

## Task 2: Eliminate Typedef Aliases & Dead Code

**Goal:** Quick wins — remove confusion and dead weight.

### 2A: Remove typedef aliases
- [ ] Delete `typedef Owner = VideoOwner;` and `typedef Stat = VideoStat;` from `lib/core/contracts/video_model_contract.dart`
- [ ] Update all consumers (grep for `Owner` and `Stat` used as types) to use `VideoOwner`/`VideoStat` directly
- [ ] Run `dart analyze`

### 2B: Remove dead code
- [ ] Delete `lib/features/notification/application/services/notification_image_uploader.dart`
- [ ] Verify no broken imports

---

## Task 3: Model Deduplication — VideoOwner/VideoStat

**Goal:** Features reuse core contracts, no feature-local clones.

### 3A: Replace ToViewOwnerModelDto/ToViewStatModelDto
- [ ] In `lib/features/to_view/data/dtos/to_view_model_dto.dart`: replace `ToViewOwnerModelDto` with `VideoOwner` from core contracts, replace `ToViewStatModelDto` with `VideoStat`
- [ ] Update `ToViewModelDto` to reference `VideoOwner?` and `VideoStat?` directly
- [ ] Update the to_view mapper/repository to use core types
- [ ] Delete the local DTO classes
- [ ] Run `build_runner`

### 3B: Replace FavoriteOwner with VideoOwner
- [ ] In `lib/features/favorites/domain/entities/favorite_folder.dart`: replace `FavoriteOwner` with `VideoOwner` from core
- [ ] Update `FavoriteFolder.upper` field type
- [ ] Update `lib/features/favorites/data/favorite_mapper.dart` to map directly to `VideoOwner`
- [ ] Delete `FavoriteOwner` class and its freezed output
- [ ] Run `build_runner`

---

## Task 4: Model Deduplication — OfficialVerify/VipInfo

**Goal:** One definition per concept across the entire codebase.

### 4A: Unify OfficialVerify
- [ ] Keep `RelationOfficialVerify` in `core/contracts/relation_user_contract.dart` as the canonical definition (rename to just `OfficialVerify`)
- [ ] Delete `OfficialVerify` from `lib/features/profile/data/dtos/relation_model.dart`
- [ ] Replace `CommentOfficialVerify` in `lib/core/contracts/comment_contract.dart` with the unified `OfficialVerify`
- [ ] Update all imports and mappers
- [ ] Run `build_runner`

### 4B: Unify VipInfo
- [ ] Keep `RelationVipInfo` in `core/contracts/relation_user_contract.dart` as canonical (rename to just `VipInfo`)
- [ ] Delete `VipInfo` from `lib/features/profile/data/dtos/relation_model.dart`
- [ ] Update all imports and mappers
- [ ] Run `build_runner`

### 4C: Eliminate UserProfile→ProfileUser no-op mapping
- [ ] Evaluate: if `UserProfile` (DTO) and `ProfileUser` (domain) have identical fields, merge into one `ProfileUser` with `@JsonSerializable`/`@freezed` and `fromJson`
- [ ] Delete the DTO class and the `UserProfileMapper` extension
- [ ] Update `profile_repository_impl.dart` to return the unified model directly
- [ ] Run `build_runner`

---

## Task 5: Barrel File Elimination

**Goal:** All imports point to the actual defining file. No re-export-only files.

### 5A: Feature-level barrels
- [ ] Delete `lib/features/auth/auth.dart` — update importers to import `feature_scope.dart`, `login_dialog_action.dart`, `route_entry.dart` directly
- [ ] Delete `lib/features/dynamic/dynamic_post_card.dart` — update importers
- [ ] Delete `lib/features/dynamic/user_dynamic.dart` — update importers
- [ ] Delete `lib/features/live/domain/live_models.dart` — update importers
- [ ] Delete `lib/features/live/live_recommend.dart` — update importers
- [ ] Delete `lib/features/search/default_search.dart` — update importers
- [ ] Delete `lib/features/video/video_actions_bottom_sheet.dart` — update importers

### 5B: DTO barrel files
- [ ] Delete `lib/features/video/data/dtos/video_dtos.dart` — update all importers to import specific DTO files
- [ ] Delete `lib/features/live/data/dtos/live_dtos.dart` — update importers
- [ ] Delete `lib/features/notification/data/dtos/notification_dtos.dart` — update importers
- [ ] Delete `lib/features/profile/data/dtos/profile_dtos.dart` — update importers
- [ ] Delete `lib/features/search/data/dtos/search_dtos.dart` — update importers

### 5C: Domain entity barrels
- [ ] Delete `lib/features/video/domain/entities/video_entities.dart` — update importers
- [ ] Delete `lib/features/dynamic/domain/entities/dynamic_entities.dart` — update importers

### 5D: UI barrels (keep ui.dart, remove sub-barrels)
- [ ] Delete `lib/ui/assemblies/comments/comments.dart` — update importers
- [ ] Delete `lib/ui/assemblies/text/text.dart` — update importers
- [ ] Delete `lib/ui/assemblies/users/users.dart` — update importers
- [ ] Delete `lib/ui/theme/app_theme.dart` — update importers

### 5E: Core network barrel
- [ ] Delete `lib/core/data/network/core_network.dart` — update importers to import specific network files

### 5F: Verification
- [ ] `dart analyze` — no broken imports
- [ ] `flutter test` — all pass

---

## Task 6: Freezed Migration (Remaining)

**Goal:** Zero hand-written value objects.

### 6A: View model states
- [ ] Convert `PlaybackSnapshot` in `lib/features/video/presentation/player/playback_snapshot_view_model.dart` to freezed
- [ ] Convert `PublishDynamicUiState` in `lib/features/dynamic/presentation/view_models/publish_dynamic_view_model.dart` to freezed
- [ ] Convert `FavFolderDetailState` in `lib/features/favorites/presentation/view_models/favorites_view_model.folder_resources.dart` to freezed
- [ ] Run `build_runner` after each

### 6B: Dynamic content entities
- [ ] Convert `DynamicVideoContent`, `DynamicLinkCard`, `DynamicAdditional`, `DynamicGoodsItem` in `lib/features/dynamic/domain/entities/dynamic_content_entities.dart` to freezed
- [ ] Add `fromJson` factories where these come from API responses
- [ ] Run `build_runner`

---

## Task 7: @riverpod Provider Migration (Remaining)

**Goal:** All feature-level providers use code generation.

### 7A: Search providers
- [ ] Convert `searchSuggestionsProvider` to `@riverpod`
- [ ] Convert `DefaultSearchController` to `@riverpod` AsyncNotifier
- [ ] Convert `TrendingRankingController` to `@riverpod` AsyncNotifier
- [ ] Convert `SearchResultController` to `@riverpod` AsyncNotifier with family
- [ ] Run `build_runner`

### 7B: Playback providers
- [ ] Convert `playbackSnapshotProvider` to `@riverpod`
- [ ] Convert `playbackPositionProvider`, `playbackDurationProvider`, `playbackBufferProvider` to `@riverpod`
- [ ] Run `build_runner`

### 7C: Other feature providers
- [ ] Convert `topicSearchViewModelProvider` (dynamic)
- [ ] Convert `liveRoomPageCommandsProvider` (live)
- [ ] Convert `favoriteFolderCommandWorkflowProvider` (favorites)
- [ ] Convert `chatPageCommandWorkflowProvider` (notification)
- [ ] Convert `showLoginDialogProvider` (auth)
- [ ] Run `build_runner`

---

## Task 8: Thin Abstraction Removal

**Goal:** Remove ceremony-only interfaces that add no testing or polymorphic value.

### 8A: Evaluate and remove single-method repository interfaces
- [ ] `HistoryRepository` (7 lines, 1 method) — inline into `HistoryRepositoryImpl`, remove interface
- [ ] `RankingRepository` (7 lines, 1 method) — inline into `RankingRepositoryImpl`, remove interface
- [ ] `EmoteRepository` (7 lines, 1 method) — inline into `EmoteRepositoryImpl`, remove interface
- [ ] `ProfileCacheRepository` (7 lines, 1 method) — inline into impl, remove interface
- [ ] Update provider definitions to return impl type directly
- [ ] Update architecture tests if they assert on domain/data boundary for these features

### 8B: Remove no-op mappers
- [ ] After Task 4C (UserProfile/ProfileUser merge), delete `UserProfileMapper` if it becomes empty
- [ ] After Task 3B (FavoriteOwner removal), simplify `favorite_mapper.dart`
- [ ] After Task 4A/4B (OfficialVerify/VipInfo unification), delete `OfficialVerifyMapper` and `VipInfoMapper`

---

## Task 9: Final Verification & Documentation

- [ ] `dart run build_runner build --delete-conflicting-outputs` — no errors
- [ ] `dart analyze` — no new warnings
- [ ] `flutter test test/architecture --reporter compact` — all pass (update tests if needed)
- [ ] `flutter test` — full test suite passes
- [ ] Grep verification: no `typedef.*=` in contracts (except genuine type aliases)
- [ ] Grep verification: no barrel files in features (except allowed)
- [ ] Update `docs/architecture/architecture-guide.md` with Phase 18 changes
- [ ] Update `CLAUDE.md` architecture section

---

## Execution Order

```
Task 1 (archive)
  ↓
Task 2 (quick wins: typedefs + dead code)
  ↓
Task 3 + Task 4 (model deduplication — can be parallelized)
  ↓
Task 5 (barrel elimination — independent of model work)
  ↓
Task 6 (freezed migration — depends on model dedup being stable)
  ↓
Task 7 (riverpod migration — depends on freezed types)
  ↓
Task 8 (thin abstraction removal — after all model/provider work settles)
  ↓
Task 9 (final verification)
```

Tasks 3, 4, and 5 are largely independent and can be parallelized. Task 6 depends on Tasks 3-4 (model shapes must be final). Task 7 depends on Task 6 (freezed types used in providers). Task 8 depends on Tasks 3-4 (mapper removal follows model merge).

## Risk Notes

- **Architecture test breakage**: Removing repository interfaces changes the import graph. The architecture tests in `test/architecture/` may need updating — specifically tests that enforce "domain/ does not import from data/". If we collapse domain into data for simple features, these tests need scoping adjustments.
- **build_runner ordering**: Each freezed/riverpod migration must pass `build_runner` independently. Never batch multiple migrations without intermediate verification.
- **API coupling**: Merging DTO and domain model means `@JsonKey` annotations appear on domain classes. This is intentional — the "pure domain" pattern adds no value when mapping is identity.
- **Import count explosion**: Eliminating barrels means more import lines per file. This is acceptable — explicit imports are easier to navigate and refactor than hidden re-exports.
