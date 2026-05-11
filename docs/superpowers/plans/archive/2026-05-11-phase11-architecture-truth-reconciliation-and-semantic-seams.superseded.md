# Phase 11 Architecture Truth Reconciliation & Semantic Seam Convergence Implementation Plan

**Status:** SUPERSEDED (historical archive)
**Superseded by:** `docs/superpowers/plans/2026-05-12-phase12-capability-facade-simplification-and-generator-first.md`
**Why archived:** This plan focused on semantic seam correctness, but the active direction moved to simplification-first execution: collapse thin facades and repository-provider wrappers, reduce public-contract drift, and use the existing popular codegen stack more aggressively.

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Reconcile Culcul's architecture truth, then converge feature public seams so the repo's root contracts are deliberate, capability-oriented, and guarded against regression.

**Architecture:** Keep the stable top-level shape (`app/`, `core/`, `features/`, `ui/`). Phase 11 is a semantic cleanup phase, not another broad rebaseline. The order is: archive and align docs, harden guard semantics, fix the most misleading facades (`home`, `notification`), finish the lingering public-API cleanup in `dynamic` and `video`, then sweep the remaining repo for the same rules.

**Tech Stack:** Flutter, Riverpod, Hooks Riverpod, Freezed, Hive, Dio

---

### Task 1: Archive Phase 10 honestly and establish one active Phase 11 baseline

**Files:**
- Modify: `CLAUDE.md`
- Modify: `docs/architecture/architecture-guide.md`
- Move/Modify: `docs/superpowers/specs/archive/2026-05-11-phase10-slice-normalization-and-public-seam-hardening-design.superseded.md`
- Move/Modify: `docs/superpowers/plans/archive/2026-05-11-phase10-slice-normalization-and-public-seam-hardening.superseded.md`
- Create: `docs/superpowers/specs/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams-design.md`
- Create: `docs/superpowers/plans/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams.md`

- [ ] **Step 1: Verify the current contradiction before editing**

Run:

```bash
rg -n "Phase 10|phase10|phase11|Active spec|Active plan" CLAUDE.md docs/architecture docs/superpowers
find docs/superpowers/specs -maxdepth 2 -type f | sort
find docs/superpowers/plans -maxdepth 2 -type f | sort
```

Expected: Phase 10 appears as active in `CLAUDE.md` and root docs while `architecture-guide.md` speaks as if it is already archived/completed.

- [ ] **Step 2: Move the old Phase 10 root docs into `archive/` and prepend an honest superseded note**

Archive note requirements:

```md
> **Superseded on 2026-05-11 after partial landing:** ...
> **Replaced by spec:** `docs/superpowers/specs/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams-design.md`
> **Replaced by plan:** `docs/superpowers/plans/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams.md`
```

- [ ] **Step 3: Update `CLAUDE.md` and `architecture-guide.md` to point at Phase 11 only**

Required truth changes:

```md
- Active spec: `docs/superpowers/specs/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams-design.md`
- Active plan: `docs/superpowers/plans/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams.md`
```

- [ ] **Step 4: Re-scan for contradictory active/archive language**

Run:

```bash
rg -n "Phase 10|phase10|phase11|Archived spec|Archived plan|Active spec|Active plan" CLAUDE.md docs/architecture docs/superpowers
```

Expected: Phase 10 appears only in archive or historical sections; active pointers resolve to Phase 11 only.

- [ ] **Step 5: Commit**

```bash
git add CLAUDE.md docs/architecture docs/superpowers/specs docs/superpowers/plans
git commit -m "docs(phase11): reconcile architecture truth and archive phase10"
```

---

### Task 2: Replace syntactic seam checks with semantic architecture guards

**Files:**
- Create: `test/architecture/phase11_barrel_semantic_public_api_guard_test.dart`
- Create: `test/architecture/phase11_facade_semantic_guard_test.dart`
- Create: `test/architecture/phase11_presentation_data_shortcut_guard_test.dart`
- Create: `test/architecture/phase11_application_impl_dependency_guard_test.dart`
- Modify: `tool/architecture/phase10_boundary_snapshot.sh` or create `tool/architecture/phase11_boundary_snapshot.sh`

- [ ] **Step 1: Write a failing barrel guard that catches any root export of `presentation/**` or `data/**`, including `show` / `hide` forms**

Test shape:

```dart
test('feature barrels do not export presentation or data internals', () async {
  final violations = await findFeatureBarrelInternalExports();
  expect(violations, isEmpty);
});
```

The scanner must flag lines like:

```dart
export 'presentation/widgets/foo.dart' show FooWidget;
export 'presentation/view_models/bar.dart';
```

- [ ] **Step 2: Write a failing facade guard that catches public repository fields and repository-shaped seam leaks**

Test shape:

```dart
test('facades do not expose repositories as public contract', () async {
  final violations = await findPublicRepositoryFieldsInFacades();
  expect(violations, isEmpty);
});
```

- [ ] **Step 3: Write a failing shortcut guard for features whose presentation still imports local `data/` directly**

Initial expected targets:

```text
lib/features/home/presentation/**
```

Test shape:

```dart
test('presentation does not import feature-local data when a facade seam exists', () async {
  final violations = await findPresentationDataShortcuts();
  expect(violations, isEmpty);
});
```

- [ ] **Step 4: Write a failing application seam guard for imports of `*_repository_impl.dart` from public seam files**

Target files:

```text
lib/features/*/application/**/facade*.dart
lib/features/*/application/*_facade.dart
lib/features/*/feature_scope.dart
```

- [ ] **Step 5: Add a boundary snapshot command for the new failure modes**

Command examples:

```bash
rg -n "^export .*presentation/|^export .*data/" lib/features/*/*.dart
rg -n "final .*Repository\\b" lib/features/*/application/*facade*.dart
rg -n "features/.*/data/" lib/features/*/presentation/**/*.dart
rg -n "_repository_impl\\.dart" lib/features/*/application lib/features/*/feature_scope.dart
```

- [ ] **Step 6: Run the architecture suite**

Run:

```bash
flutter test test/architecture/phase9_* test/architecture/phase10_* test/architecture/phase11_* --reporter compact
```

Expected: inherited Phase 9/10 tests stay green; the new Phase 11 tests start red exactly on the semantic seam leaks we intend to clean up.

- [ ] **Step 7: Commit**

```bash
git add test/architecture tool/architecture
git commit -m "test(phase11): add semantic seam guardrails"
```

---

### Task 3: Convert `home` and `notification` into real capability facades

**Files:**
- Modify: `lib/features/home/home.dart`
- Modify: `lib/features/home/feature_scope.dart`
- Modify: `lib/features/home/application/home_facade.dart`
- Modify: `lib/features/home/data/home_feed_data_source.dart`
- Modify: `lib/features/home/presentation/view_models/home_recommend_view_model.dart`
- Modify: `lib/features/home/presentation/view_models/home_popular_view_model.dart`
- Modify: `lib/features/home/presentation/view_models/weekly_view_model.dart`
- Modify: `lib/features/notification/feature_scope.dart`
- Modify: `lib/features/notification/application/notification_facade.dart`
- Modify: `lib/features/notification/application/use_cases/send_private_message_use_case.dart`
- Modify: `lib/features/notification/application/use_cases/refresh_unread_and_feed_use_case.dart`
- Modify: `lib/features/notification/data/notification_repository_impl.dart`
- Modify: `lib/features/notification/presentation/view_models/chat_view_model.dart`
- Modify: `lib/features/notification/presentation/view_models/notification_feed_view_model.dart`
- Test: `test/features/home/**`
- Test: `test/features/notification/**`

- [ ] **Step 1: Add failing tests that describe capability-oriented facades instead of data/provider shortcuts**

Example test shapes:

```dart
test('HomeFacade loads recommend feed without presentation importing data source directly', () async {
  final facade = makeHomeFacade();
  await facade.loadRecommendFeed();
  expect(fakeHomeGateway.recommendCalls, 1);
});

test('NotificationFacade does not expose a public repository field', () {
  final source = File(notificationFacadePath).readAsStringSync();
  expect(source, isNot(contains('final NotificationRepository repository;')));
});
```

- [ ] **Step 2: Introduce explicit home capabilities**

Target direction:

```dart
class HomeFacade {
  Future<HomeRecommendPageState> loadRecommendFeed(...);
  Future<HomePopularPageState> loadPopularFeed(...);
  Future<WeeklyPageState> loadWeeklyFeed(...);
}
```

Presentation view models should depend on `homeFacadeEntryProvider` or smaller home capability providers, not `homeFeedDataSourceProvider`.

- [ ] **Step 3: Shrink `NotificationFacade` to capability methods only**

Target direction:

```dart
class NotificationFacade {
  Future<Result<SendMessageResult, AppError>> sendPrivateMessage(...);
  Future<void> refreshUnreadAndFeed(...);
  Stream<NotificationSummary> watchUnreadCount(...);
  Future<NotificationPageState> loadSessions(...);
}
```

Rules:

- no public repository field
- no broad repository-shaped sync/page passthroughs unless promoted as explicit capability methods
- compose through internal providers or domain/provider ports instead of importing `data/notification_repository_impl.dart` into the facade and use cases

- [ ] **Step 4: Re-run focused tests and analysis**

Run:

```bash
flutter test test/features/home test/features/notification --reporter compact
flutter test test/architecture/phase11_* --reporter compact
flutter analyze lib/features/home lib/features/notification test/features/home test/features/notification
```

Expected: home and notification tests pass; Phase 11 semantic seam tests go green for these two slices.

- [ ] **Step 5: Commit**

```bash
git add lib/features/home lib/features/notification test/features/home test/features/notification test/architecture
git commit -m "refactor(phase11): harden home and notification capability seams"
```

---

### Task 4: Finish semantic seam cleanup for `dynamic` and `video`

**Files:**
- Modify: `lib/features/dynamic/dynamic.dart`
- Modify: `lib/features/dynamic/feature_scope.dart`
- Modify: `lib/features/dynamic/application/dynamic_facade.dart`
- Modify: `lib/features/dynamic/presentation/**`
- Modify: `lib/features/video/video.dart`
- Modify: `lib/features/video/feature_scope.dart`
- Modify: `lib/features/video/application/video_facade.dart`
- Modify: `lib/features/video/presentation/**`
- Test: `test/features/dynamic/**`
- Test: `test/features/video/**`

- [ ] **Step 1: Add failing tests for forbidden public presentation exports**

Example:

```dart
test('dynamic barrel does not export presentation internals', () async {
  final exports = await readExports('lib/features/dynamic/dynamic.dart');
  expect(exports, isNot(anyElement(contains('/presentation/'))));
});

test('video barrel does not export presentation internals', () async {
  final exports = await readExports('lib/features/video/video.dart');
  expect(exports, isNot(anyElement(contains('/presentation/'))));
});
```

- [ ] **Step 2: Remove presentation re-exports from the public barrels**

Current known targets:

```text
lib/features/dynamic/dynamic.dart
lib/features/video/video.dart
```

If a symbol still needs cross-feature reuse:

- move it to `ui/compositions/**`, or
- re-home it under a clearly public contract surface

- [ ] **Step 3: Make `DynamicFacade` and `VideoFacade` advertise capabilities, not repositories**

Target shape:

```dart
class DynamicFacade {
  Future<UserDynamicState> loadUserDynamics(...);
  Future<void> publishDynamic(...);
}

class VideoFacade {
  Future<VideoDetailState> loadVideoDetail(...);
  Future<void> openVideoActions(...);
}
```

Rules:

- no public repository fields on either facade
- retain the useful Phase 10 directory splits
- fix the current drift where callers still expect repository providers from `feature_scope.dart`
- reduce domain/data mirroring by moving transport-shaped DTO ownership back to `data/` or by renaming domain-facing contracts so the two layers stop pretending to be different files for the same model
- do not reopen the old broad boundary question

- [ ] **Step 4: Re-run focused verification**

Run:

```bash
flutter test test/features/dynamic test/features/video --reporter compact
flutter test test/architecture/phase10_* test/architecture/phase11_* --reporter compact
dart analyze lib/features/dynamic lib/features/video
flutter analyze lib/features/dynamic lib/features/video test/features/dynamic test/features/video
```

Expected: structural gains remain intact; semantic seam leaks are removed; the current undefined-provider drift around `feature_scope.dart` consumers is gone.

- [ ] **Step 5: Commit**

```bash
git add lib/features/dynamic lib/features/video test/features/dynamic test/features/video test/architecture
git commit -m "refactor(phase11): converge dynamic and video semantic seams"
```

---

### Task 5: Sweep the remaining repo for consistency and refresh the verified guide

**Files:**
- Modify: remaining `lib/features/*/*.dart` barrels as needed
- Modify: remaining `lib/features/*/feature_scope.dart` files as needed
- Modify: `docs/architecture/architecture-guide.md`
- Modify: `CLAUDE.md`

- [ ] **Step 1: Run repo-wide seam scans**

Run:

```bash
rg -n "^export .*presentation/|^export .*data/" lib/features/*/*.dart
rg -n "final .*Repository\\b" lib/features/*/application/*facade*.dart
rg -n "features/.*/data/" lib/features/*/presentation/**/*.dart
rg -n "_repository_impl\\.dart" lib/features/*/application lib/features/*/feature_scope.dart
```

Expected: no remaining hits except intentional test fixtures or archive references.

- [ ] **Step 2: Apply the same seam semantics to any remaining outliers**

Likely follow-up files:

```text
lib/features/live/live.dart
lib/features/search/search.dart
other feature facades/barrels surfaced by the scan
```

- [ ] **Step 3: Refresh the architecture guide with verified end-state only**

Required guide updates:

- what `route_entry.dart` means
- what `feature_scope.dart` may export
- what `<feature>.dart` may export
- which Phase 10 assets were inherited
- why Phase 11 is now the truthful active baseline

- [ ] **Step 4: Run final verification**

Run:

```bash
flutter test test/architecture --reporter compact
flutter analyze
git diff --stat
```

Expected: architecture suite green, analyzer green or only known pre-existing unrelated failures recorded before edits, and diff scope matches the planned seam-cleanup work.

- [ ] **Step 5: Commit**

```bash
git add CLAUDE.md docs/architecture lib/features test/architecture
git commit -m "docs(phase11): finalize semantic seam convergence baseline"
```

---

### Exit Criteria

- Phase 10 root docs no longer exist; the archived superseded copies are the only Phase 10 planning files.
- `CLAUDE.md`, `architecture-guide.md`, and the root spec/plan agree on Phase 11.
- `home`, `notification`, `dynamic`, and `video` no longer rely on implementation-shaped public seams.
- Phase 11 architecture tests encode the new semantic rules and stay green with the inherited Phase 9/10 suites.
