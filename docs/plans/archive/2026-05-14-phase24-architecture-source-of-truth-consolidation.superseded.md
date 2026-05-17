# Phase 24 Architecture Source-of-Truth Consolidation Plan

> Superseded on 2026-05-14 by `docs/plans/phase25-architecture-surface-reduction.md`.
> Phase 24 verification and commits are preserved below; remaining surface-area cleanup moved to Phase 25.

Spec: `docs/specs/archive/2026-05-14-phase24-architecture-source-of-truth-consolidation.superseded.md`

## Ground Rules

- Execute one task at a time.
- Before editing a function, class, or method, run GitNexus impact analysis and record the risk in this plan.
- If impact risk is HIGH or CRITICAL, stop and report before editing.
- Do not preserve compatibility shims for old internal APIs after all call sites are migrated.
- Prefer deleting empty seams over adding another abstraction.
- Keep user-local unrelated changes intact.

## Phase Map

- Task 1: Planning surface and architecture guide consolidation.
- Task 2: Automated architecture audit and guard tests.
- Task 3: Provider/bootstrap/session placeholder removal.
- Task 4: Network/request execution single path.
- Task 5: Feature source-of-truth cleanup.
- Task 6: Build/config closeout from Phase 22.
- Task 7: Final verification and commit split.

## Task 1: Planning Surface And Architecture Guide Consolidation

- [x] Archive superseded Phase 22 spec/plan.
- [x] Archive superseded Phase 23 performance-only draft.
- [x] Create active Phase 24 spec.
- [x] Create active Phase 24 plan.
- [x] Create/update `docs/architecture/architecture-guide.md`.
- [x] Update `CLAUDE.md` active pointers.
- [x] Verify no stale Phase 21/22/23 active references remain.

Verification:

- `git status --short`
- pointer grep across `CLAUDE.md`, `docs/specs`, `docs/plans`, and `docs/architecture`

## Task 2: Automated Architecture Audit And Guard Tests

- [x] Add or update a repo-local architecture check script/test covering:
  - `core/` and `ui/` do not import `features/`.
  - feature code does not import another feature's `data/**` or `presentation/**`.
  - only approved barrel-like files remain.
  - no provider/bootstrap/session seam contains `UnimplementedError` or `TODO()`.
  - no `lib/shared/` import or directory returns.
- [x] Record baseline counts in `docs/architecture/architecture-guide.md`.
- [x] Keep checks cheap enough for normal local verification.

Candidate files:

- `test/architecture/**`
- `tool/architecture/**`

Verification:

- architecture tests/scripts pass
  - `bash tool/architecture/run_architecture_guards.sh`

## Task 3: Provider, Bootstrap, And Session Placeholder Removal

- [x] Impact analysis targets before editing:
  - `cacheStoreProvider`
  - `cookieJarProvider`
  - `storageProvider`
  - session provider files under `lib/core/session/`
- [x] Replace root-only placeholders with real generated Riverpod providers or remove the seam entirely.
- [x] Collapse session action provider wrappers that only forward to one feature-owned implementation.
- [x] Keep provider ownership clear:
  - app bootstrap creates concrete infrastructure;
  - core session exposes app-wide contracts only;
  - feature scope owns feature-local wiring.
- [x] Delete unused provider files after call sites move.

Verification:

- targeted provider tests
- placeholder scan returns zero for provider/bootstrap/session files
- relevant app startup/root override tests pass
  - placeholder scan result: `0`

## Task 4: Network And Request Execution Single Path

- [x] Impact analysis targets before editing:
  - `DioClient`
  - `RequestExecutor`
  - `RequestExecutorBinding`
  - `CacheInterceptor`
  - `InFlightDedupInterceptor`
  - `NetworkQualityInterceptor`
- [x] Make `DioClient` the single owner of:
  - `BaseOptions`
  - interceptor ordering
  - cancellation policy
  - retry/cache policy
  - client lifecycle cleanup
- [x] Remove duplicate request error mapping from repositories already expressible through `RequestExecutor`.
- [x] Prefer Dio's current primitives (`CancelToken`, `QueuedInterceptor`, options `extra`) over custom side channels when possible.
- [x] Keep endpoint policy explicit and testable; do not hide behavior in stringly typed request metadata.

Verification:

- network policy tests
- request executor tests
- affected repository tests
  - GitNexus impact attempts on Task 4 symbols returned `UNKNOWN` / target not found; no HIGH/CRITICAL risk was reported.
  - `flutter analyze lib/core/data/network/dio_client.dart lib/core/data/network/interceptors/cache_interceptor.dart lib/core/data/network/request_executor.dart lib/core/data/network/request_executor_binding.dart lib/features/search/data/search_repository_impl.dart test/core/data/network/request_executor_test.dart` -> no issues.
  - `flutter test test/core/data/network/endpoint_policy_test.dart test/core/data/network/network_quality_policy_test.dart test/core/data/network/request_executor_test.dart --reporter compact` -> all passed.

## Task 5: Feature Source-of-Truth Cleanup

- [x] Impact analysis target set per feature before editing.
- [x] Prioritize current changed/high-traffic features:
  - auth
  - home
  - live
  - notification
  - profile
  - search
  - video player
- [x] Remove feature-local duplicates of shared contracts.
- [x] Delete DTO/domain duplication where no business behavior exists.
- [x] Move cross-feature endpoint/service behavior into `core/services/` only when at least two features actually use it.
- [x] Remove TODO/FIXME placeholders in touched presentation files or convert them into tracked work outside code.

Verification:

- focused tests for each touched feature
- duplicate model scan
- TODO/FIXME scan for touched areas
  - shared-contract scan across prioritized features found no second definitions for `UserSession`, `UserCardModel`, `UserProfileInfo`, `SearchQuery`, `SearchResultPage`, `WatchLaterPort`, or `RelationPort`.
  - shared relation follow/follower behavior now lives in `lib/core/services/relation_service.dart`; live/video/dynamic/profile callers no longer import profile-owned relation providers, and the old profile relation api/repository/dto files were deleted.
  - notification unread/image/send-message result parsing now uses a single domain-owned representation; `UnreadCountModel`, `ImageUploadResponse`, and `SendMessageResponse` call paths were removed.
  - auth cache/country parsing now maps directly to `UserEntity` / `CountryCode`; `AuthUserDto` and `CountryCodeDto` call paths were removed.
  - touched-area/global presentation TODO/FIXME scan result: `0`

## Task 6: Build And Configuration Closeout

- [x] Finish or explicitly delete obsolete Phase 22 Tasks 8-9.
- [x] Review `build.yaml` and generated file policy.
- [x] Confirm dependency versions are pinned and no unused performance dependency remains.
- [x] Add cheap CI/local guard for architecture checks if current workflow supports it.
- [x] Do not add `sentry_flutter`, image/cache replacements, or isolate pools until Tasks 2-5 are green.

Verification:

- analyzer
- codegen/localization
- architecture checks
- focused Flutter tests
  - Phase 22 archive now explicitly states incomplete closeout was folded into Phase 24.
  - `build.yaml` drift scope includes `lib/features/profile/data/local/**` for Drift generation.
  - `pubspec.yaml` dependencies remain version-pinned; no new performance dependency added.
  - local guard entrypoint: `bash tool/architecture/run_architecture_guards.sh`

## Task 7: Final Verification And Commit Split

- [x] Run:
  - `dart run slang`
  - `dart run build_runner build --delete-conflicting-outputs`
  - `flutter analyze`
  - focused tests from each task
- [x] Run `gitnexus_detect_changes(scope: "all")`.
- [x] Split commits by coherent boundary:
  - docs/planning
  - guard tests/scripts
  - provider/session cleanup
  - network/request cleanup
  - feature cleanup
  - config closeout
- [x] Leave unrelated user changes unstaged.

Verification notes:

- `dart run slang` -> passed.
- `dart run build_runner build --delete-conflicting-outputs` -> passed; current build warns the flag is ignored and wrote generated outputs.
- `flutter analyze` -> `290 issues found`, all repo-wide info-level baseline noise; no new hard errors from current Phase 24 slices.
- focused tests passed:
  - `test/core/data/network/endpoint_policy_test.dart`
  - `test/core/data/network/network_quality_policy_test.dart`
  - `test/core/data/network/request_executor_test.dart`
  - `test/core/hooks/use_scroll_precache_test.dart`
  - `test/core/runtime/runtime_performance_policy_test.dart`
  - `test/features/profile/data/profile_cache_database_test.dart`
  - `test/features/video/presentation/player/player_wakelock_test.dart`
  - `test/architecture/architecture_boundary_guard_test.dart`
  - `test/architecture/architecture_domain_dto_guard_test.dart`
  - `test/architecture/architecture_feedback_guard_test.dart`
- `bash tool/architecture/run_architecture_guards.sh` -> passed.
- `gitnexus_detect_changes(scope: "all")` -> `risk_level: low`, `affected_count: 0`, but symbol mapping still only surfaced `AGENTS.md` / `CLAUDE.md` sections rather than the Dart symbols edited in this slice.
- 2026-05-14 relation centralization slice:
  - touched-file `flutter analyze` -> 4 info-level baseline lints, no new errors.
  - `flutter test test/architecture/architecture_boundary_guard_test.dart` -> passed.
- 2026-05-14 notification duplicate-model slice:
  - touched-file `flutter analyze` for notification data files -> passed with no issues.
  - `flutter test test/architecture/architecture_boundary_guard_test.dart test/architecture/architecture_domain_dto_guard_test.dart` -> passed.
- 2026-05-14 auth duplicate-model slice:
  - touched-file `flutter analyze` for auth data files -> passed with no issues.
  - `rg -n "CountryCodeDto|AuthUserDto|UnreadCountModel|ImageUploadResponse|SendMessageResponse|fromDomain\\(" lib test` -> no matches.
  - `flutter test test/architecture/architecture_boundary_guard_test.dart test/architecture/architecture_domain_dto_guard_test.dart` -> passed.
- 2026-05-14 Task 6/7 closeout:
  - no new `sentry_flutter`, cache replacement, or isolate-pool dependency was introduced.
  - work split into two coherent commits: `6a94c2b2` and `1a9403ca`.
  - unrelated local edits remain unstaged: `AGENTS.md`, `CLAUDE.md`.

## Self-Review Checklist

- One active spec.
- One active plan.
- One architecture guide.
- One owner per shared concept.
- No placeholder providers.
- No accidental broad compatibility layer.
- Verification output recorded in this plan before closeout.
