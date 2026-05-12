# Phase 19: Pragmatic Simplification & Dead Weight Removal — Plan

**Status:** Active  
**Date:** 2026-05-13  
**Spec:** `docs/superpowers/specs/2026-05-13-phase19-pragmatic-simplification.md`

## Verified Baseline

- `flutter test test/architecture --reporter compact` passes (Phase 18 guard-green)
- `dart run build_runner build --delete-conflicting-outputs` succeeds
- Phase 18 fully landed (barrel elimination, freezed, @riverpod, model dedup)

---

## Task 1: Remove `responsive_framework` Dependency

**Goal:** Eliminate unused package that wraps the widget tree but is never queried.

**Evidence:** `ResponsiveBreakpoints.of(context)` is called nowhere. All 18 responsive consumers use the custom `AppResponsive` extension via `MediaQuery.sizeOf`.

### Steps:
- [ ] Remove `responsive_framework` from `pubspec.yaml`
- [ ] In `lib/app/app.dart`: remove `ResponsiveBreakpoints.builder(...)` wrapper, return `child` directly from the `builder:` callback
- [ ] In `lib/ui/responsive/app_breakpoints.dart`: remove `import 'package:responsive_framework/responsive_framework.dart'` and delete the `frameworkBreakpoints` list (keep numeric constants `kDesktopBreakpoint`, `kExtendedRailBreakpoint`)
- [ ] Run `dart analyze` — verify no broken imports
- [ ] Run `flutter test` — verify no regressions

---

## Task 2: Delete Dead Proto Files & Unused Dependency

**Goal:** Remove server-side proto stubs that are never imported by client code.

### Steps:
- [ ] Delete `lib/protos/dm.pbserver.dart`
- [ ] Delete `lib/protos/dm.pbjson.dart`
- [ ] Verify `lib/protos/dm.pb.dart` does not import either file (it imports `dm.pbenum.dart` only)
- [ ] Check if `fixnum` is still needed: grep for `fixnum` in remaining proto files
- [ ] If `fixnum` is only used by `dm.pb.dart` (transitive via `protobuf`), remove explicit `fixnum` from `pubspec.yaml` (it's a transitive dep of `protobuf`)
- [ ] Run `dart pub get` — verify resolution
- [ ] Run `dart analyze`

---

## Task 3: Inline `app_dimens.dart` & Delete

**Goal:** Remove near-dead constants file with only 3 consumers.

### Steps:
- [ ] In `lib/ui/widgets/users/user_list_tile.dart`: replace `AppDimens.*` references with inline values
- [ ] In `lib/ui/widgets/feedback/privacy_error_widget.dart`: replace `AppDimens.*` references with inline values
- [ ] In `lib/features/profile/presentation/widgets/relation_user_list.dart`: replace `AppDimens.*` references with inline values
- [ ] Delete `lib/core/constants/app_dimens.dart`
- [ ] Run `dart analyze`

---

## Task 4: Eliminate `RankingVideo` Domain Entity

**Goal:** Ranking feature consumes `VideoModel` from core contracts directly. No intermediate domain entity.

### Steps:
- [ ] Read `lib/features/ranking/data/ranking_video_mapper.dart` to understand current mapping
- [ ] Read ranking presentation widgets to find all `RankingVideo` field accesses
- [ ] Update ranking presentation widgets to use `VideoModel` fields:
  - `model.coverUrl` → `model.pic`
  - `model.ownerName` → `model.owner.name`
  - `model.viewCount` → `model.stat.view`
  - `model.danmakuCount` → `model.stat.danmaku`
- [ ] Update ranking data layer to return `List<VideoModel>` directly (remove mapper call)
- [ ] Delete `lib/features/ranking/domain/entities/ranking_video.dart`
- [ ] Delete `lib/features/ranking/domain/entities/ranking_video.freezed.dart`
- [ ] Delete `lib/features/ranking/data/ranking_video_mapper.dart` (if it exists)
- [ ] Remove empty `lib/features/ranking/domain/` directory if nothing remains
- [ ] Update any imports referencing `RankingVideo`
- [ ] Run `build_runner` (in case generated code references the deleted type)
- [ ] Run `dart analyze`
- [ ] Run `flutter test`

---

## Task 5: Remove Thin Repository Interfaces

**Goal:** Eliminate ceremony-only interfaces. Consumers depend on the impl directly.

### 5A: Remove `HomeRepository` interface + rename impl
- [ ] Delete `lib/features/home/domain/repositories/home_repository.dart`
- [ ] Rename `lib/features/home/data/home_feed_data_source.dart` → `lib/features/home/data/home_repository_impl.dart`
- [ ] Rename class `HomeFeedDataSource` → `HomeRepositoryImpl`
- [ ] Remove `implements HomeRepository` from the class declaration
- [ ] Update `lib/features/home/feature_scope.dart` to export the renamed provider
- [ ] Update all imports (grep for `home_feed_data_source` and `HomeFeedDataSource`)
- [ ] Remove empty `lib/features/home/domain/repositories/` directory
- [ ] Run `dart analyze`

### 5B: Remove `SettingsRepository` interface
- [ ] Delete `lib/features/settings/domain/repositories/settings_repository.dart`
- [ ] Remove `implements SettingsRepository` from `SettingsRepositoryImpl`
- [ ] Update imports in consumers
- [ ] Remove empty `lib/features/settings/domain/repositories/` directory
- [ ] Run `dart analyze`

### 5C: Remove `ToViewRepository` interface
- [ ] Delete `lib/features/to_view/domain/repositories/to_view_repository.dart`
- [ ] Remove `implements ToViewRepository` from `ToViewRepositoryImpl`
- [ ] Update imports in consumers
- [ ] Remove empty `lib/features/to_view/domain/repositories/` directory
- [ ] Run `dart analyze`

### 5D: Remove `DanmakuRepository` interface
- [ ] Delete `lib/features/video/domain/repositories/danmaku_repository.dart`
- [ ] Remove `implements DanmakuRepository` from `DanmakuRepositoryImpl`
- [ ] Update imports in consumers
- [ ] Run `dart analyze`

### 5E: Remove `RelationRepository` interface
- [ ] Delete `lib/features/profile/domain/repositories/relation_repository.dart`
- [ ] Remove `implements RelationRepository` from `RelationRepositoryImpl`
- [ ] Update imports in consumers
- [ ] Remove empty directory if applicable
- [ ] Run `dart analyze`

### 5F: Verification
- [ ] `flutter test test/architecture --reporter compact` — update guards if they enforce domain/repositories/ existence for these features
- [ ] `flutter test` — full suite passes

---

## Task 6: Fix Hardcoded Placeholder

**Goal:** Remove user-visible fake data.

### Steps:
- [ ] In `lib/features/video/presentation/detail/info/uploader_section.dart`: remove hardcoded `'12.5W followers · 168 videos'` string
- [ ] Either: fetch real stats from the video's owner data (if available in the video detail response), or hide the subtitle entirely when data is unavailable
- [ ] Run `dart analyze`

---

## Task 7: Final Verification & Documentation

- [ ] `dart run build_runner build --delete-conflicting-outputs` — no errors
- [ ] `dart analyze` — no new warnings
- [ ] `flutter test test/architecture --reporter compact` — all pass
- [ ] `flutter test` — full test suite passes
- [ ] Update `docs/architecture/architecture-guide.md` with Phase 19 changes
- [ ] Update `CLAUDE.md` architecture section to reference Phase 19

---

## Execution Order

```
Task 1 (responsive_framework removal) — independent
Task 2 (dead proto files) — independent
Task 3 (app_dimens inline) — independent
  ↓ (all three can be parallelized)
Task 4 (RankingVideo elimination) — independent
Task 5 (thin interface removal) — independent
  ↓ (can be parallelized with Task 4)
Task 6 (placeholder fix) — independent
  ↓
Task 7 (final verification + docs)
```

Tasks 1-3 are quick wins with no cross-dependencies. Tasks 4-6 are medium effort and independent of each other. Task 7 is the final gate.

## Risk Notes

- **Architecture test guards**: Tests in `test/architecture/` may assert that features have `domain/repositories/`. After removing thin interfaces, update these guards to exclude the simplified features (home, settings, to_view, ranking).
- **Provider naming**: Renaming `HomeFeedDataSource` changes the generated provider name from `homeFeedDataSourceProvider` to `homeRepositoryImplProvider`. All consumers of this provider must be updated.
- **Ranking UI field access**: Switching from flat `model.ownerName` to nested `model.owner.name` is mechanical but touches every ranking widget. Verify no null-safety issues with `owner` field.
