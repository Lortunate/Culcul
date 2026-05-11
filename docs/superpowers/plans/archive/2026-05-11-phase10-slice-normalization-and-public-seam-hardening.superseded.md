> **Superseded on 2026-05-11 after partial landing:** Keep this plan as historical execution context only. Several structural moves from Phase 10 landed in code, but the repo did not end the phase with a truthful, unified baseline. The follow-up work is no longer "finish the same narrow slice cleanup" but "reconcile repo truth and converge semantic seams."
>
> **Replaced by spec:** `docs/superpowers/specs/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams-design.md`
> **Replaced by plan:** `docs/superpowers/plans/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams.md`

# Phase 10 Slice Normalization & Public Seam Hardening Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Normalize the remaining high-debt feature slices and shrink feature public seams so Culcul becomes easier to navigate and safer to evolve after the successful Phase 9 boundary rebaseline.

**Architecture:** Phase 10 is a narrow follow-on phase. The order is: lock the new baseline and guard expectations, normalize `notification`, normalize `dynamic`, decompose `video` presentation, then harden `home` and the remaining feature seams. The main rule is that legal seams are no longer enough; seams must also be deliberate, small, and readable.

**Tech Stack:** Flutter, Riverpod, Hooks Riverpod, Freezed, Hive, Dio

---

### Task 1: Lock the Phase 10 baseline and add public-seam guard coverage

**Files:**
- Modify: `CLAUDE.md`
- Modify: `docs/architecture/architecture-guide.md`
- Create: `test/architecture/phase10_barrel_public_api_guard_test.dart`
- Create: `test/architecture/phase10_feature_scope_facade_guard_test.dart`
- Modify: `tool/architecture/phase9_boundary_snapshot.sh` or create `tool/architecture/phase10_boundary_snapshot.sh`

- [ ] **Step 1: Verify the new active baseline points to Phase 10 only**

Run:

```bash
find docs/superpowers/specs -maxdepth 2 -type f | sort
find docs/superpowers/plans -maxdepth 2 -type f | sort
rg -n "phase9|phase10" CLAUDE.md docs/architecture docs/superpowers
```

Expected: only archive references point at Phase 9; active pointers point at the new 2026-05-11 Phase 10 pair.

- [ ] **Step 2: Add a barrel guard that flags broad `presentation/**` re-exports from feature barrels**

Test shape:

```dart
test('feature barrels do not broadly re-export presentation internals', () async {
  final violations = await findBarrelPresentationExports();
  expect(
    violations,
    isEmpty,
    reason: 'Feature barrels should expose deliberate public APIs, not whole presentation surfaces.',
  );
});
```

- [ ] **Step 3: Add a feature-scope guard that flags raw data-provider leakage**

Test shape:

```dart
test('feature_scope exposes facades instead of raw data providers', () async {
  final violations = await findFeatureScopeDataProviderLeaks();
  expect(
    violations,
    isEmpty,
    reason: 'feature_scope.dart should act as a facade seam, not a repository-provider dump.',
  );
});
```

- [ ] **Step 4: Update the boundary snapshot script so it also reports Phase 10 seam violations**

Example checks:

```bash
rg -n "^export 'presentation/" lib/features/*/*.dart
rg -n "RepositoryProvider|ApiProvider" lib/features/*/feature_scope.dart
```

- [ ] **Step 5: Run the architecture tests**

Run:

```bash
flutter test test/architecture/phase9_* test/architecture/phase10_* --reporter compact
```

Expected: Phase 9 stays green; new Phase 10 guards start red only if the repo still leaks broad seams.

- [ ] **Step 6: Commit**

```bash
git add CLAUDE.md docs/architecture/architecture-guide.md test/architecture tool/architecture
git commit -m "test(phase10): add public seam guardrails"
```

---

### Task 2: Normalize `notification` into explicit workflows and a real facade

**Files:**
- Modify: `lib/features/notification/feature_scope.dart`
- Modify: `lib/features/notification/notification.dart`
- Create: `lib/features/notification/application/services/`
- Create: `lib/features/notification/application/use_cases/`
- Modify: `lib/features/notification/application/notification_application.dart` or equivalent facade file
- Modify: `lib/features/notification/data/notification_repository_impl.dart`
- Modify: `lib/features/notification/data/notification_repository_impl.*.dart`
- Modify: `lib/features/notification/presentation/view_models/chat_view_model.dart`
- Modify: `lib/features/notification/presentation/view_models/notification_feed_view_model.dart`
- Modify: `lib/features/notification/presentation/view_models/notification_lifecycle_sync_view_model.dart`
- Test: `test/features/notification/**`

- [ ] **Step 1: Write failing tests for the intended application facade**

Test examples:

```dart
test('notification facade sends chat messages through an application service', () async {
  final facade = makeNotificationFacade();
  await facade.sendPrivateMessage(sessionId: 1, text: 'hi');
  expect(fakeRepository.sentMessages, hasLength(1));
});

test('notification facade refreshes unread and feed state through explicit workflows', () async {
  final facade = makeNotificationFacade();
  await facade.refreshUnreadAndFeed();
  expect(fakeRepository.refreshCalls, ['unread', 'feed']);
});
```

- [ ] **Step 2: Run only the new notification tests**

Run:

```bash
flutter test test/features/notification --reporter compact
```

Expected: new facade tests fail because the current seam is still too thin or too implementation-shaped.

- [ ] **Step 3: Introduce explicit application services / use cases**

Implementation sketch:

```dart
class SendPrivateMessageUseCase {
  SendPrivateMessageUseCase(this._repository, this._imageUploader);

  final NotificationRepository _repository;
  final NotificationImageUploader _imageUploader;

  Future<void> call(SendPrivateMessageCommand command) async {
    // orchestration only
  }
}
```

- [ ] **Step 4: Make `feature_scope.dart` expose the facade-level capabilities instead of raw repository assembly**

Facade example:

```dart
@riverpod
NotificationFacade notificationFacade(NotificationFacadeRef ref) {
  return NotificationFacade(
    sendPrivateMessage: ref.watch(sendPrivateMessageUseCaseProvider),
    refreshUnreadAndFeed: ref.watch(refreshNotificationStateUseCaseProvider),
  );
}
```

- [ ] **Step 5: Simplify the repository collaborator surface where responsibilities are artificial**

Rule: merge or rename collaborator files when the current split hides workflow meaning instead of clarifying it.

- [ ] **Step 6: Re-run tests and focused analysis**

Run:

```bash
flutter test test/features/notification --reporter compact
flutter analyze lib/features/notification test/features/notification
```

Expected: notification tests pass; analysis stays clean in the slice.

- [ ] **Step 7: Commit**

```bash
git add lib/features/notification test/features/notification
git commit -m "refactor(phase10): normalize notification application seam"
```

---

### Task 3: Split `dynamic` by capability and remove infrastructure-shaped domain seams

**Files:**
- Modify: `lib/features/dynamic/dynamic.dart`
- Modify: `lib/features/dynamic/feature_scope.dart`
- Modify: `lib/features/dynamic/domain/repositories/dynamic_repository.dart`
- Modify: `lib/features/dynamic/domain/entities/**`
- Create: `lib/features/dynamic/application/publish/`
- Create: `lib/features/dynamic/data/article_parsing/`
- Create: `lib/features/dynamic/data/publish/`
- Modify: `lib/features/dynamic/data/dynamic_repository_impl.dart`
- Modify: `lib/features/dynamic/data/dynamic_repository_impl.*.dart`
- Test: `test/features/dynamic/**`

- [ ] **Step 1: Add a failing test that proves the domain seam should not depend on upload primitives**

Test shape:

```dart
test('dynamic publish contract accepts a feature command object, not File', () {
  final command = PublishDynamicCommand(text: 'hello', media: []);
  expect(command.media, isEmpty);
});
```

- [ ] **Step 2: Add a failing architecture test or focused assertion for domain purity**

Example:

```dart
test('dynamic domain repository does not import dart:io', () async {
  final source = await File(dynamicRepositoryPath).readAsString();
  expect(source, isNot(contains(\"import 'dart:io'\")));
});
```

- [ ] **Step 3: Move article parsing / tokenizer / mapper support out of the domain-facing surface when they are infrastructure concerns**

Implementation direction:

```dart
lib/features/dynamic/data/article_parsing/
lib/features/dynamic/application/publish/
```

- [ ] **Step 4: Replace upload-shaped parameters with explicit commands / value objects**

Command example:

```dart
class PublishDynamicCommand {
  const PublishDynamicCommand({
    required this.text,
    required this.media,
  });

  final String text;
  final List<PublishMediaAsset> media;
}
```

- [ ] **Step 5: Shrink the public barrel and facade**

Rule: export route entrypoints, public widgets intentionally reused, and facade contracts only.

- [ ] **Step 6: Re-run focused verification**

Run:

```bash
flutter test test/features/dynamic --reporter compact
flutter test test/architecture/phase10_* --reporter compact
flutter analyze lib/features/dynamic test/features/dynamic
```

Expected: dynamic-specific tests and Phase 10 seam guards pass for this slice.

- [ ] **Step 7: Commit**

```bash
git add lib/features/dynamic test/features/dynamic test/architecture
git commit -m "refactor(phase10): split dynamic capabilities and harden seams"
```

---

### Task 4: Decompose `video` presentation into clearer subdomains

**Files:**
- Modify: `lib/features/video/video.dart`
- Modify: `lib/features/video/feature_scope.dart`
- Create: `lib/features/video/presentation/detail/`
- Create: `lib/features/video/presentation/player/`
- Create: `lib/features/video/presentation/comments/`
- Create: `lib/features/video/presentation/overlays/`
- Modify: `lib/features/video/presentation/pages/**`
- Modify: `lib/features/video/presentation/view_models/**`
- Modify: `lib/features/video/presentation/widgets/**`
- Test: `test/features/video/**`

- [ ] **Step 1: Add a failing navigation / organization test for the intended public seam**

Test example:

```dart
test('video barrel exposes route and public capabilities without re-exporting broad presentation internals', () async {
  final exports = await readExports('lib/features/video/video.dart');
  expect(exports, isNot(anyElement(contains('/presentation/'))));
});
```

- [ ] **Step 2: Identify the first split around `detail`, `player`, `comments`, and `overlays`**

Run:

```bash
rg -n "video_detail|player|comment|danmaku|overlay" lib/features/video/presentation
```

Expected: enough clustering to move files by responsibility rather than alphabetically.

- [ ] **Step 3: Move files into clearer subdirectories without changing behavior first**

Example target shape:

```text
lib/features/video/presentation/
  detail/
  player/
  comments/
  overlays/
```

- [ ] **Step 4: Rewire imports so public exports stay narrow**

Rule: external consumers should keep using `video.dart`, `feature_scope.dart`, or `route_entry.dart`, not new deep paths.

- [ ] **Step 5: Run focused verification**

Run:

```bash
flutter test test/features/video --reporter compact
flutter test test/architecture/phase10_* --reporter compact
flutter analyze lib/features/video test/features/video
```

Expected: no new seam leaks; video tests remain green after the directory decomposition.

- [ ] **Step 6: Commit**

```bash
git add lib/features/video test/features/video test/architecture
git commit -m "refactor(phase10): decompose video presentation subdomains"
```

---

### Task 5: Thin `home` and finish feature public-seam hardening

**Files:**
- Modify: `lib/features/home/home.dart`
- Modify: `lib/features/home/feature_scope.dart`
- Modify: `lib/features/home/presentation/pages/home_page.dart`
- Modify: `lib/features/home/presentation/widgets/live_view.dart`
- Modify: `lib/features/home/presentation/widgets/home_app_bar.dart`
- Modify: `lib/features/home/presentation/widgets/home_video_actions.dart`
- Modify: `lib/features/search/search.dart`
- Modify: `lib/features/live/live.dart`
- Modify: `lib/features/dynamic/dynamic.dart`
- Modify: `lib/features/video/video.dart`
- Test: `test/architecture/phase10_*`

- [ ] **Step 1: Add a failing test for `home`'s allowed dependency shape**

Test shape:

```dart
test('home composes approved feature facades instead of deep implementation exports', () async {
  final violations = await findHomeDeepFeatureDependencies();
  expect(
    violations,
    isEmpty,
    reason: 'home should depend on small public contracts from other features.',
  );
});
```

- [ ] **Step 2: Replace implementation-shaped imports with facade-level imports**

Examples:

```dart
import 'package:culcul/features/live/live.dart';
import 'package:culcul/features/search/search.dart';
```

Rule: after this task, those barrels should expose only the intentionally small symbols `home` actually needs.

- [ ] **Step 3: Trim barrels and `feature_scope.dart` exports**

Expected direction:

```dart
export 'route_entry.dart';
export 'feature_scope.dart' show liveFeedFacadeProvider;
```

- [ ] **Step 4: Re-run full architecture verification**

Run:

```bash
flutter test test/architecture/phase9_* test/architecture/phase10_* --reporter compact
rg -n "^export 'presentation/" lib/features/*/*.dart
rg -n "RepositoryProvider|ApiProvider" lib/features/*/feature_scope.dart
```

Expected: no broad presentation exports remain; no raw provider leaks remain in intended facade seams.

- [ ] **Step 5: Refresh architecture docs to the post-Phase-10 truth**

Files:

```text
docs/architecture/architecture-guide.md
CLAUDE.md
```

Update them only after the code and tests match the new seam expectations.

- [ ] **Step 6: Run final verification**

Run:

```bash
flutter analyze
flutter test --reporter compact
```

Expected: repo verification green or back to the known project baseline, with Phase 9 and Phase 10 architecture guards passing.

- [ ] **Step 7: Commit**

```bash
git add CLAUDE.md docs/architecture/architecture-guide.md lib/features test/architecture
git commit -m "refactor(phase10): harden feature public seams"
```
