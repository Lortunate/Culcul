# Phase 25 Architecture Surface Reduction Plan

Spec: `docs/specs/phase25-architecture-surface-reduction.md`

## Ground Rules

- Execute one task at a time.
- Before editing a function, class, or method, run GitNexus impact analysis and record the risk in this plan.
- If impact risk is HIGH or CRITICAL, stop and report before editing.
- Keep behavior stable unless the spec explicitly says the internal API may break.
- Delete empty seams instead of adding compatibility wrappers.
- Leave unrelated user-local changes unstaged.

## Phase Map

- Task 1: Planning rollover and archive hygiene.
- Task 2: Architecture audit script source/generated split.
- Task 3: Feature public surface reduction.
- Task 4: Thin domain layer collapse.
- Task 5: Router and app alias cleanup.
- Task 6: Dependency and config source-of-truth cleanup.
- Task 7: Final verification and commit split.

## Task 1: Planning Rollover And Archive Hygiene

- [x] Archive Phase 24 active spec as superseded.
- [x] Archive Phase 24 active plan as superseded.
- [x] Create active Phase 25 spec.
- [x] Create active Phase 25 plan.
- [x] Update `CLAUDE.md` active pointers.
- [x] Update `docs/architecture/architecture-guide.md` active phase and baseline.
- [x] Verify no stale Phase 24 active references remain outside archive history.

Verification:

- `git status --short`
- pointer grep across `CLAUDE.md`, `docs/specs`, `docs/plans`, and `docs/architecture`

## Task 2: Architecture Audit Script Source/Generated Split

- [x] Impact analysis targets before editing:
  - architecture guard functions/scripts under `tool/architecture/**`
  - architecture guard tests under `test/architecture/**`
- [x] Update guard logic to report source Dart files separately from generated Dart files.
- [x] Exclude `*.g.dart`, `*.freezed.dart`, protobuf generated output, and localization generated output from source debt counts by default.
- [x] Keep explicit generated verification checks where useful.
- [x] Update `docs/architecture/architecture-guide.md` with the new source-only baseline.

Verification:

- `bash tool/architecture/run_architecture_guards.sh`
- relevant `test/architecture/**` tests

## Task 3: Feature Public Surface Reduction

- [x] Impact analysis target set before editing each touched `feature_scope.dart` or exported symbol.
- [x] Audit every `lib/features/**/feature_scope.dart` export.
- [x] Remove exports for presentation widgets and data repositories that are consumed only inside their owning feature.
- [x] Keep only cross-feature runtime composition exports with documented consumers.
- [x] Prefer direct imports from owning source files for intra-feature usage.

Initial candidates from planning audit:

- `lib/features/dynamic/feature_scope.dart`
- `lib/features/live/feature_scope.dart`
- `lib/features/profile/feature_scope.dart`
- `lib/features/video/feature_scope.dart`
- `lib/features/to_view/feature_scope.dart`
- `lib/features/auth/feature_scope.dart`

Task 3 audit result:

- Removed owner-only repository exports from `auth`, `dynamic`, `favorites`, `history`, `home`, `live`, `notification`, `profile`, `ranking`, `search`, `settings`, `to_view`, and `video` feature scopes.
- Replaced intra-feature `feature_scope.dart` imports with direct imports from the owning data/application source files.
- Deleted empty `feature_scope.dart` files for `favorites`, `history`, `home`, `notification`, `ranking`, and `settings` after confirming no import consumers remained.
- Kept `auth` session providers because dynamic, favorites, history, home, live, notification, profile, to_view, and video UI/application code read login/logout state across feature boundaries.
- Kept `dynamic` `userDynamicProvider` and `DynamicPostCard` because `profile/presentation/widgets/user_dynamic_tab.dart` composes the user dynamic tab through that feature seam.
- Kept `liveRecommendProvider` because `home/presentation/widgets/live_view.dart` composes the home live feed through it.
- Kept `searchPortProvider` and `searchDefaultHintProvider` because dynamic topic search and home search hint consume them.
- Kept `watchLaterPortProvider` because `home/presentation/widgets/home_video_actions.dart` adds watch-later entries through the to-view seam.
- Kept `showVideoActionsBottomSheet` because home video actions open the video-owned action sheet through the video seam.
- Kept profile session providers because live and notification consumers need user-card/profile lookup data through a non-data source seam.
- Kept `profileCacheRepositoryProvider` temporarily because auth logout is the only cross-feature cache invalidation consumer and no narrower existing application seam exists in Task 3 scope.

Verification:

- architecture guards
- focused tests for touched feature scopes
- import grep showing removed symbols are not reintroduced through alternate barrels

## Task 4: Thin Domain Layer Collapse

- [x] Impact analysis target set before editing each domain entity or repository call site.
- [x] Audit low-count domain folders and classify each type as business entity or transport/view shape.
- [x] Collapse domain directories that only contain pass-through data shapes.
- [x] Keep business-bearing entities with rationale in the plan.
- [x] Regenerate Freezed output after moved/deleted models.

Initial candidates from planning audit:

- `lib/features/history/domain/entities/history_entry.dart`
- `lib/features/profile/domain/entities/profile_video.dart`
- `lib/features/settings/domain/entities/app_theme_preference.dart`
- `lib/features/to_view/domain/entities/to_view_entry.dart`
- `lib/features/video/domain/entities/danmaku_model.dart`

Task 4 audit result:

- Collapsed `HistoryEntry` to `lib/features/history/data/dtos/history_entry.dart`; it is a history API projection consumed by the repository and history UI, with no business behavior.
- Collapsed `ProfileVideo` to `lib/features/profile/data/dtos/profile_video.dart`; it is a profile video API projection reused by profile view models/widgets, with no business behavior.
- Collapsed `DanmakuEntry`, `DanmakuSegment`, and `DanmakuViewConfig` to `lib/features/video/data/dtos/danmaku_model.dart`; they are parsed danmaku transport/view shapes returned by the data repository.
- Kept `AppThemePreference` in settings domain because it owns accepted persisted values and storage fallback behavior through `storageValue`/`fromStorage`.
- Kept `ToViewEntry` in to-view domain because it owns watch-progress behavior through `hasProgress` and normalized `progressRatio`.

Verification:

- `dart run build_runner build --delete-conflicting-outputs`
- focused tests for touched repositories/view models
- architecture guard for DTO/domain placement

## Task 5: Router And App Alias Cleanup

- [x] Impact analysis target before editing router symbols.
- [x] Remove router-owned re-export aliases for feature-owned route input types.
- [x] Move consumers to import the feature route seam directly.
- [x] Keep `app/router` responsible for route composition, not feature API ownership.

Initial candidate:

- `lib/app/router/app_routes.dart` re-export of `ChatRouteInput`

Task 5 result:

- Removed `ChatRouteInput` re-export from `lib/app/router/app_routes.dart`.
- Kept generated `ChatRoute` ownership in `app/router` while moving `ChatRouteInput` construction sites to import `features/notification/route_entry.dart` directly.

Verification:

- router-related tests or analyzer on router and notification files
- architecture guards

## Task 6: Dependency And Config Source-Of-Truth Cleanup

- [x] Fix duplicated `dev_dependencies:` heading in `pubspec.yaml`.
- [x] Build a dependency usage table with direct source, generated source, platform registrant, or documented keep rationale.
- [x] Remove dependencies with no source/generated/platform usage and no keep rationale.
- [x] Keep platform-only packages only when generated plugin registrants or platform build files prove usage.
- [x] Do not add replacement libraries during this cleanup unless required for compile.

Initial low-use/generated/platform-only packages to classify:

- `json_annotation`
- `media_kit_libs_video`
- `sqlite3_flutter_libs`
- `riverpod`
- `dio_cookie_manager`
- `dio_http2_adapter`
- `dio_smart_retry`
- `audio_session`
- `gt3_flutter_plugin`
- `qr_flutter`
- `screen_brightness`
- `share_plus`
- `path_drawing`
- `archive`

Task 6 audit result:

| Dependency | Decision | Evidence |
| --- | --- | --- |
| `json_annotation` | Keep | Source DTOs use `@JsonKey`/json-serializable annotations through `freezed_annotation`; generated `*.g.dart` files are produced by `JsonSerializableGenerator`. |
| `media_kit_libs_video` | Keep | Direct native video-libraries package for `media_kit_video`; lockfile resolves platform video libs and Flutter plugin metadata registers platform video packages. |
| `sqlite3_flutter_libs` | Keep | Platform registrants include `sqlite3_flutter_libs` on Android, Darwin, Linux, and Windows for Drift/native sqlite. |
| `riverpod` | Keep | Direct source import in `lib/app/runtime/root_overrides.dart` for `Override`; generated/provider stack also depends on Riverpod runtime. |
| `dio_cookie_manager` | Keep | Direct source import in `lib/core/data/network/dio_client.dart`. |
| `dio_http2_adapter` | Keep | Direct source import in `lib/core/data/network/dio_client.dart`. |
| `dio_smart_retry` | Keep | Direct source import in `lib/core/data/network/dio_client.dart`. |
| `audio_session` | Keep | Direct source import in `lib/core/services/audio_handler.dart`; plugin metadata also lists it as native audio dependency. |
| `gt3_flutter_plugin` | Keep | Direct source import in `lib/features/auth/presentation/hooks/use_geetest.dart`; platform registrants include native plugin entries. |
| `qr_flutter` | Keep | Direct source import in `lib/features/auth/presentation/widgets/qr_login_view.dart`. |
| `screen_brightness` | Keep | Direct source imports in video player system-setting and interaction-layer code; platform registrants include native plugin entries. |
| `share_plus` | Keep | Direct source import in `lib/core/utils/share_utils.dart`; platform registrants include native/share entries. |
| `path_drawing` | Keep | Direct source import in `lib/features/video/application/video_extra_workflows.dart`. |
| `archive` | Keep | Direct source import in `lib/core/utils/danmaku_mask_parser.dart`. |

`pubspec.yaml` currently has a single `dev_dependencies:` heading, so Task 6 did not change dependency declarations.

Verification:

- `flutter pub get`
- `flutter analyze`
- dependency grep table committed or recorded in this plan

## Task 7: Final Verification And Commit Split

- [x] Run:
  - `dart run slang`
  - `dart run build_runner build --delete-conflicting-outputs`
  - `bash tool/architecture/run_architecture_guards.sh`
  - `flutter analyze`
  - focused tests from each task
- [x] Run `gitnexus_detect_changes(scope: "all")`.
- [x] Split commits by coherent boundary:
  - docs/planning
  - architecture guards
  - feature public surface
  - domain collapse
  - router alias cleanup
  - dependency/config cleanup
- [x] Leave unrelated user changes unstaged.

Task 7 verification result:

- `dart run slang`: passed.
- `dart run build_runner build --delete-conflicting-outputs`: passed, wrote regenerated outputs.
- `bash tool/architecture/run_architecture_guards.sh`: passed with source/generated/total counts `643/228/871`.
- `flutter analyze --no-fatal-infos --no-fatal-warnings`: exit 0 with existing info-only lint noise.
- Focused architecture/profile/video tests: passed.
- `gitnexus_detect_changes(scope: "all")`: low risk, 6 changed symbols, 0 affected processes.

## Self-Review Checklist

- [x] No stale active Phase 24 pointers outside archive history.
- [x] No new barrel or alias file added.
- [x] No generated file counted as source debt.
- [x] No dependency removed without usage evidence.
- [x] Tests/guards run and results recorded.
