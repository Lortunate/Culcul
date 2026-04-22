# Culcul Architecture Boundary Cleanup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove the highest-risk architectural boundary violations, move business commands out of shared UI and heavy pages, reduce route coupling, and prepare the codebase for a later `shared -> core/ui` split.

**Architecture:** Treat this as a phased refactor, not a big-bang rewrite. Phase 0 restores a runnable baseline in the isolated worktree. Phase 1 removes illegal `shared/app -> features` dependencies and makes shared UI callback-driven. Phase 2 moves page-side command orchestration into explicit controller/application units. Phase 3 tightens route ownership and starts structural normalization only after the earlier phases are green.

**Tech Stack:** Flutter, Dart 3.10, hooks_riverpod / flutter_riverpod, go_router + go_router_builder, build_runner, Freezed / json_serializable, Slang, flutter_test

---

## File Structure Map

### Existing files to modify during the plan

- `lib/app/app.dart`
- `lib/app/router/app_routes.dart`
- `lib/features/auth/feature_scope.dart`
- `lib/features/home/home.dart`
- `lib/features/home/presentation/widgets/popular_video_card.dart`
- `lib/features/live/presentation/widgets/live_header.anchor.dart`
- `lib/features/profile/presentation/widgets/relation_user_item.dart`
- `lib/features/profile/presentation/widgets/user_profile_buttons.dart`
- `lib/features/video/presentation/widgets/info/uploader_section.dart`
- `lib/features/dynamic/presentation/pages/dynamic_detail_page.dart`
- `lib/shared/network/interceptors/token_interceptor.dart`
- `lib/shared/widgets/follow_button.dart`
- `lib/shared/widgets/video_card.dart`
- `test/app/router/route_input_test.dart`
- `test/architecture/auth_video_architecture_guard_test.dart`

### New files to create during the plan

- `lib/shared/session/session_cookie_refresher.dart`
- `lib/features/auth/application/auth_session_cookie_refresher.dart`
- `lib/shared/widgets/video_actions_bottom_sheet.dart`
- `lib/features/dynamic/application/dynamic_detail_actions.dart`
- `test/shared/network/token_interceptor_test.dart`
- `test/shared/widgets/follow_button_test.dart`
- `test/shared/widgets/video_actions_bottom_sheet_test.dart`
- `test/features/dynamic/application/dynamic_detail_actions_test.dart`
- `test/architecture/shared_boundary_guard_test.dart`
- `docs/architecture/shared-boundary-rules.md`

### Existing files expected to be deleted later in the plan

- `lib/features/home/presentation/widgets/video_more_bottom_sheet.dart`

---

### Task 0: Restore a Runnable Baseline in the Worktree

**Files:**
- Modify: local generated artifacts under `lib/**.g.dart`, `lib/**.freezed.dart`, `lib/i18n/strings.g.dart` if regenerated
- Test: full suite bootstrap only, no functional code changes yet

- [ ] **Step 1: Generate codegen artifacts**

Run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: missing `*.g.dart` / `*.freezed.dart` files are generated locally and the previous compile-time “part file not found” failures disappear.

- [ ] **Step 2: Generate i18n output**

Run:

```bash
dart run slang
```

Expected: `lib/i18n/strings.g.dart` exists locally.

- [ ] **Step 3: Verify the worktree can at least compile tests**

Run:

```bash
flutter test test/app/router/route_input_test.dart
flutter test test/architecture/auth_video_architecture_guard_test.dart
```

Expected: either both pass, or any remaining failures are now real code failures instead of missing generated files.

- [ ] **Step 4: Record remaining baseline failures before refactoring**

Run:

```bash
flutter test
```

Expected: collect any remaining non-codegen failures in the task log before continuing. Do not start boundary refactors until missing-generated-file errors are resolved.

- [ ] **Step 5: Commit only if tracked source files changed**

Run:

```bash
git status --short
```

If only ignored generated files changed, do not create a commit. If tracked setup files changed unexpectedly, stage only those intentional files and commit:

```bash
git add <tracked-files>
git commit -m "chore: restore local refactor baseline"
```

---

### Task 1: Add Architecture Guardrails Before Editing Shared Boundaries

**Files:**
- Create: `test/architecture/shared_boundary_guard_test.dart`
- Create: `docs/architecture/shared-boundary-rules.md`
- Modify: `test/architecture/auth_video_architecture_guard_test.dart`

- [ ] **Step 1: Write the failing architecture boundary tests**

Create `test/architecture/shared_boundary_guard_test.dart`:

```dart
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('shared layer does not import feature packages', () async {
    final forbiddenImport = RegExp(
      r'''import\s+['"]package:culcul/features/''',
    );
    final violations = <String>[];
    final sharedDir = Directory('lib/shared');

    for (final file in sharedDir.listSync(recursive: true)) {
      if (file is! File || !file.path.endsWith('.dart')) continue;
      final content = await file.readAsString();
      if (forbiddenImport.hasMatch(content)) {
        violations.add(file.path);
      }
    }

    expect(
      violations,
      isEmpty,
      reason: 'Found shared -> feature imports: ${violations.join(', ')}',
    );
  });

  test('app layer imports route entry files instead of feature barrels where possible', () async {
    final appRoutes = File('lib/app/router/app_routes.dart');
    final content = await appRoutes.readAsString();
    expect(
      content.contains(\"package:culcul/features/auth/auth.dart\"),
      isFalse,
      reason: 'app_routes.dart should avoid broad feature barrels',
    );
  });
}
```

- [ ] **Step 2: Extend the existing architecture guard file with phase-1 comments**

Modify `test/architecture/auth_video_architecture_guard_test.dart` to keep the existing tests and add one comment block at the top:

```dart
// Phase-1 boundary cleanup keeps these legacy guard tests
// and adds shared/app boundary guards in a separate file.
```

- [ ] **Step 3: Write the short boundary rules document**

Create `docs/architecture/shared-boundary-rules.md`:

```md
# Shared Boundary Rules

- `lib/shared/**` must not import `lib/features/**`
- `lib/shared/widgets/**` may expose callbacks and immutable view data only
- login gating, navigation decisions, provider writes, and toasts belong in feature/application layers
- `lib/app/router/**` should prefer feature `route_entry.dart` imports over broad `feature.dart` barrels
```

- [ ] **Step 4: Run the architecture guard tests and verify they fail**

Run:

```bash
flutter test test/architecture/shared_boundary_guard_test.dart
```

Expected: FAIL because `token_interceptor.dart`, `follow_button.dart`, and `video_card.dart` still import feature packages.

- [ ] **Step 5: Commit**

```bash
git add \
  docs/architecture/shared-boundary-rules.md \
  test/architecture/auth_video_architecture_guard_test.dart \
  test/architecture/shared_boundary_guard_test.dart
git commit -m "test: add shared boundary architecture guards"
```

---

### Task 2: Introduce a Shared Session Cookie Refresh Contract and Refactor `TokenInterceptor`

**Files:**
- Create: `lib/shared/session/session_cookie_refresher.dart`
- Create: `lib/features/auth/application/auth_session_cookie_refresher.dart`
- Modify: `lib/features/auth/feature_scope.dart`
- Modify: `lib/app/app.dart`
- Modify: `lib/shared/network/interceptors/token_interceptor.dart`
- Create: `test/shared/network/token_interceptor_test.dart`

- [ ] **Step 1: Write the failing token interceptor test**

Create `test/shared/network/token_interceptor_test.dart`:

```dart
import 'package:culcul/shared/session/session_cookie_refresher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeSessionCookieRefresher implements SessionCookieRefresher {
  int callCount = 0;

  @override
  Future<void> refreshCookies() async {
    callCount += 1;
  }
}

void main() {
  test('shared session contract is overridable for token refresh', () async {
    final fake = _FakeSessionCookieRefresher();
    final container = ProviderContainer(
      overrides: [
        sessionCookieRefresherProvider.overrideWithValue(fake),
      ],
    );

    await container.read(sessionCookieRefresherProvider).refreshCookies();
    expect(fake.callCount, 1);
  });
}
```

- [ ] **Step 2: Define the shared contract**

Create `lib/shared/session/session_cookie_refresher.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class SessionCookieRefresher {
  Future<void> refreshCookies();
}

final sessionCookieRefresherProvider = Provider<SessionCookieRefresher>((ref) {
  throw UnimplementedError(
    'sessionCookieRefresherProvider must be overridden at app bootstrap',
  );
});
```

- [ ] **Step 3: Create the auth-backed implementation**

Create `lib/features/auth/application/auth_session_cookie_refresher.dart`:

```dart
import 'package:culcul/features/auth/feature_scope.dart';
import 'package:culcul/shared/session/session_cookie_refresher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthSessionCookieRefresher implements SessionCookieRefresher {
  AuthSessionCookieRefresher(this._ref);

  final Ref _ref;

  @override
  Future<void> refreshCookies() {
    final authRepository = _ref.read(authRepositoryProvider);
    return authRepository.refreshCookies();
  }
}
```

- [ ] **Step 4: Wire the override in app bootstrap**

Modify `lib/app/app.dart` so the root `ProviderScope` provides the auth-backed override:

```dart
ProviderScope(
  overrides: [
    sessionCookieRefresherProvider.overrideWith(
      (ref) => AuthSessionCookieRefresher(ref),
    ),
  ],
  child: const CulculAppView(),
)
```

Add the needed imports:

```dart
import 'package:culcul/features/auth/application/auth_session_cookie_refresher.dart';
import 'package:culcul/shared/session/session_cookie_refresher.dart';
```

- [ ] **Step 5: Refactor `TokenInterceptor` to use the shared contract**

Modify `lib/shared/network/interceptors/token_interceptor.dart`:

```dart
import 'package:culcul/shared/network/dio_client.dart';
import 'package:culcul/shared/session/session_cookie_refresher.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenInterceptor extends QueuedInterceptor {
  TokenInterceptor(this._ref);

  final Ref _ref;
  Future<void>? _refreshCookieFuture;

  Future<void> _ensureCookieRefreshed() {
    return _refreshCookieFuture ??=
        _ref.read(sessionCookieRefresherProvider).refreshCookies().whenComplete(() {
          _refreshCookieFuture = null;
        });
  }
}
```

- [ ] **Step 6: Re-export only the repository provider from auth scope**

Keep `lib/features/auth/feature_scope.dart` focused:

```dart
export 'data/auth_repository_impl.dart' show authRepositoryProvider;
```

- [ ] **Step 7: Run the tests**

Run:

```bash
flutter test test/shared/network/token_interceptor_test.dart
flutter test test/architecture/shared_boundary_guard_test.dart
```

- [ ] **Step 8: Commit**

```bash
git add \
  lib/app/app.dart \
  lib/features/auth/application/auth_session_cookie_refresher.dart \
  lib/features/auth/feature_scope.dart \
  lib/shared/network/interceptors/token_interceptor.dart \
  lib/shared/session/session_cookie_refresher.dart \
  test/shared/network/token_interceptor_test.dart
git commit -m "refactor: decouple token interceptor from auth feature"
```

---

### Task 3: Make `FollowButton` UI-Only and Push Auth Gating to Feature Call Sites

**Files:**
- Modify: `lib/shared/widgets/follow_button.dart`
- Modify: `lib/features/live/presentation/widgets/live_header.anchor.dart`
- Modify: `lib/features/video/presentation/widgets/info/uploader_section.dart`
- Modify: `lib/features/profile/presentation/widgets/user_profile_buttons.dart`
- Modify: `lib/features/profile/presentation/widgets/relation_user_item.dart`
- Create: `test/shared/widgets/follow_button_test.dart`

- [ ] **Step 1: Write the failing widget test**

Create `test/shared/widgets/follow_button_test.dart`:

```dart
import 'package:culcul/shared/widgets/follow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FollowButton delegates taps without reading auth state', (tester) async {
    var tapped = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FollowButton(
            isFollowed: false,
            onTap: () => tapped += 1,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(FollowButton));
    await tester.pump();

    expect(tapped, 1);
  });
}
```

- [ ] **Step 2: Remove feature and navigation dependencies from the shared widget**

Modify `lib/shared/widgets/follow_button.dart`:

```dart
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
    super.key,
    required this.isFollowed,
    required this.onTap,
    this.width,
    this.height,
    this.text,
    this.shape,
  });

  final bool isFollowed;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final String? text;
  final OutlinedBorder? shape;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return FilledButton.tonal(
      onPressed: onTap,
      child: Text(text ?? (isFollowed ? t.common.following : t.common.follow)),
    );
  }
}
```

- [ ] **Step 3: Push login gating to the live header call site**

Modify `lib/features/live/presentation/widgets/live_header.anchor.dart`:

```dart
Future<void> _handleFollowPressed(BuildContext context, WidgetRef ref) async {
  final authState = ref.read(authProvider);
  if (!authState.isLogin) {
    context.push('/login');
    return;
  }
  await onToggleFollow();
}
```

Wire it into `FollowButton(onTap: () => _handleFollowPressed(context, ref))`.

- [ ] **Step 4: Apply the same call-site pattern in video and profile widgets**

Modify:
- `lib/features/video/presentation/widgets/info/uploader_section.dart`
- `lib/features/profile/presentation/widgets/user_profile_buttons.dart`
- `lib/features/profile/presentation/widgets/relation_user_item.dart`

Use the same shape in each file:

```dart
Future<void> handleFollowTap() async {
  final authState = ref.read(authProvider);
  if (!authState.isLogin) {
    context.push('/login');
    return;
  }
  await onToggleFollow();
}
```

- [ ] **Step 5: Run the tests**

Run:

```bash
flutter test test/shared/widgets/follow_button_test.dart
flutter test test/architecture/shared_boundary_guard_test.dart
```

Expected: `follow_button.dart` is no longer reported as a `shared -> features` violation.

- [ ] **Step 6: Commit**

```bash
git add \
  lib/shared/widgets/follow_button.dart \
  lib/features/live/presentation/widgets/live_header.anchor.dart \
  lib/features/video/presentation/widgets/info/uploader_section.dart \
  lib/features/profile/presentation/widgets/user_profile_buttons.dart \
  lib/features/profile/presentation/widgets/relation_user_item.dart \
  test/shared/widgets/follow_button_test.dart
git commit -m "refactor: move follow auth gating out of shared widget"
```

---

### Task 4: Replace `VideoMoreBottomSheet` With a Shared UI-Only `VideoActionsBottomSheet` and Clean Up `VideoCard`

**Files:**
- Create: `lib/shared/widgets/video_actions_bottom_sheet.dart`
- Modify: `lib/shared/widgets/video_card.dart`
- Modify: `lib/features/home/presentation/widgets/popular_video_card.dart`
- Modify: `lib/features/home/home.dart`
- Delete: `lib/features/home/presentation/widgets/video_more_bottom_sheet.dart`
- Create: `test/shared/widgets/video_actions_bottom_sheet_test.dart`

- [ ] **Step 1: Write the failing shared widget test**

Create `test/shared/widgets/video_actions_bottom_sheet_test.dart`:

```dart
import 'package:culcul/shared/widgets/video_actions_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('VideoActionsBottomSheet renders callback-driven actions', (tester) async {
    var watchLaterTapped = 0;
    var downloadTapped = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VideoActionsBottomSheet(
            onAddToWatchLater: () => watchLaterTapped += 1,
            onDownloadCover: () => downloadTapped += 1,
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.watch_later_outlined));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.image_outlined));
    await tester.pump();

    expect(watchLaterTapped, 1);
    expect(downloadTapped, 1);
  });
}
```

- [ ] **Step 2: Create the new UI-only shared bottom sheet**

Create `lib/shared/widgets/video_actions_bottom_sheet.dart`:

```dart
import 'package:flutter/material.dart';

class VideoActionsBottomSheet extends StatelessWidget {
  const VideoActionsBottomSheet({
    super.key,
    required this.onAddToWatchLater,
    required this.onDownloadCover,
  });

  final VoidCallback onAddToWatchLater;
  final VoidCallback onDownloadCover;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.watch_later_outlined),
            title: const Text('Watch later'),
            onTap: onAddToWatchLater,
          ),
          ListTile(
            leading: const Icon(Icons.image_outlined),
            title: const Text('Download cover'),
            onTap: onDownloadCover,
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Refactor `VideoCard` to stop importing feature barrels**

Modify `lib/shared/widgets/video_card.dart`:

```dart
import 'package:culcul/shared/contracts/video_model_contract.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    super.key,
    this.video,
    this.bvid,
    this.coverUrl,
    this.onMoreTap,
  });

  final VideoModel? video;
  final String? bvid;
  final String? coverUrl;
  final VoidCallback? onMoreTap;
}
```

Replace the direct bottom-sheet launch with:

```dart
IconButton(
  onPressed: onMoreTap,
  icon: const Icon(Icons.more_vert),
)
```

- [ ] **Step 4: Move watch-later and cover-download behavior into the home call site**

Modify `lib/features/home/presentation/widgets/popular_video_card.dart` to own the feature commands:

```dart
Future<void> _showVideoActions(BuildContext context, WidgetRef ref) async {
  await showModalBottomSheet<void>(
    context: context,
    builder: (_) => VideoActionsBottomSheet(
      onAddToWatchLater: () async {
        Navigator.pop(context);
        await ref.read(toViewListProvider.notifier).add(aid);
      },
      onDownloadCover: () async {
        Navigator.pop(context);
        await ref.read(mediaServiceProvider).saveImage(coverUrl);
      },
    ),
  );
}
```

If `lib/features/home/presentation/widgets/video_more_bottom_sheet.dart` still exists after the migration, remove it and remove its export from `lib/features/home/home.dart`.

- [ ] **Step 5: Run the tests**

Run:

```bash
flutter test test/shared/widgets/video_actions_bottom_sheet_test.dart
flutter test test/architecture/shared_boundary_guard_test.dart
```

Expected: `video_card.dart` no longer contributes a `shared -> features` violation; the new shared bottom sheet test passes.

- [ ] **Step 6: Commit**

```bash
git add \
  lib/shared/widgets/video_actions_bottom_sheet.dart \
  lib/shared/widgets/video_card.dart \
  lib/features/home/presentation/widgets/popular_video_card.dart \
  lib/features/home/home.dart \
  test/shared/widgets/video_actions_bottom_sheet_test.dart
git rm lib/features/home/presentation/widgets/video_more_bottom_sheet.dart
git commit -m "refactor: move video action commands out of shared ui"
```

---

### Task 5: Extract Dynamic Detail Page Commands Into an Application Unit

**Files:**
- Create: `lib/features/dynamic/application/dynamic_detail_actions.dart`
- Modify: `lib/features/dynamic/presentation/pages/dynamic_detail_page.dart`
- Create: `test/features/dynamic/application/dynamic_detail_actions_test.dart`

- [ ] **Step 1: Write the failing application-level test**

Create `test/features/dynamic/application/dynamic_detail_actions_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DynamicDetailActions rejects blank comment submissions', () async {
    final actions = DynamicDetailActions(
      toggleLike: () async => null,
      addReply: (_, __, text) async => text,
    );

    final result = await actions.submitComment('   ');
    expect(result, isNull);
  });
}
```

- [ ] **Step 2: Create the action coordinator**

Create `lib/features/dynamic/application/dynamic_detail_actions.dart`:

```dart
typedef ToggleLike = Future<String?> Function();
typedef AddReply = Future<Object?> Function(int root, int parent, String text);

class DynamicDetailActions {
  DynamicDetailActions({
    required this.toggleLike,
    required this.addReply,
  });

  final ToggleLike toggleLike;
  final AddReply addReply;

  Future<String?> handleLike() => toggleLike();

  Future<Object?> submitComment(String rawText) {
    final text = rawText.trim();
    if (text.isEmpty) return Future.value(null);
    return addReply(0, 0, text);
  }
}
```

- [ ] **Step 3: Update the page to delegate commands**

Modify `lib/features/dynamic/presentation/pages/dynamic_detail_page.dart`:

```dart
final actions = DynamicDetailActions(
  toggleLike: notifier.toggleLike,
  addReply: (root, parent, text) {
    return ref.read(dynamicCommentControllerProvider(post).notifier)
        .addReply(root, parent, text);
  },
);

void submitComment() async {
  await actions.submitComment(commentController.text);
  commentController.clear();
  FocusScope.of(context).unfocus();
}
```

Also move the snackbar decision close to the page, but keep command execution inside `DynamicDetailActions`.

- [ ] **Step 4: Run the tests**

Run:

```bash
flutter test test/features/dynamic/application/dynamic_detail_actions_test.dart
```

Expected: the new action unit is independently testable and the page’s command body is slimmer.

- [ ] **Step 5: Commit**

```bash
git add \
  lib/features/dynamic/application/dynamic_detail_actions.dart \
  lib/features/dynamic/presentation/pages/dynamic_detail_page.dart \
  test/features/dynamic/application/dynamic_detail_actions_test.dart
git commit -m "refactor: extract dynamic detail page actions"
```

---

### Task 6: Normalize Heavy Presentation Command Owners Across Features

**Files:**
- Modify: `lib/features/video/presentation/pages/video_detail_page.dart`
- Modify: `lib/features/live/presentation/pages/live_room_page.dart`
- Modify: `lib/features/notification/presentation/pages/chat_page.dart`
- Modify: `lib/features/favorites/presentation/pages/favorite_detail_page.dart`
- Create as needed:
  - `lib/features/video/application/video_detail_actions.dart`
  - `lib/features/live/application/live_room_actions.dart`
  - `lib/features/notification/application/chat_actions.dart`
  - `lib/features/favorites/application/favorite_detail_actions.dart`

- [ ] **Step 1: Add one application action file per heavy page**

Create one file per feature using this exact pattern:

```dart
class FeaturePageActions {
  FeaturePageActions({
    required this.primaryCommand,
    required this.secondaryCommand,
  });

  final Future<void> Function() primaryCommand;
  final Future<void> Function() secondaryCommand;

  Future<void> runPrimary() => primaryCommand();
  Future<void> runSecondary() => secondaryCommand();
}
```

Use concrete names in each feature file, for example `VideoDetailActions`, `LiveRoomActions`, `ChatActions`, `FavoriteDetailActions`.

- [ ] **Step 2: Move direct mutation branching out of the pages**

For each target page, replace bodies that directly chain `ref.read(...notifier)` and imperative mutations with coordinator construction:

```dart
final actions = VideoDetailActions(
  primaryCommand: () => ref.read(videoDetailControllerProvider(bvid).notifier).refresh(),
  secondaryCommand: () => ref.read(playerControllerProvider.notifier).toggleFullscreen(),
);
```

Keep the UI responsible for:
- reading immutable state with `watch`
- showing snackbars/dialogs
- handling layout-only branches

- [ ] **Step 3: Add one focused unit test per new action file**

Use this pattern in each test file:

```dart
test('runPrimary delegates to the injected command', () async {
  var called = 0;
  final actions = FeaturePageActions(
    primaryCommand: () async => called += 1,
    secondaryCommand: () async {},
  );

  await actions.runPrimary();
  expect(called, 1);
});
```

- [ ] **Step 4: Run targeted tests for the touched features**

Run:

```bash
flutter test test/features/video
flutter test test/features/live
flutter test test/features/notification
flutter test test/features/favorites
```

Expected: the feature suites remain green after command ownership moves.

- [ ] **Step 5: Commit**

```bash
git add \
  lib/features/video/application \
  lib/features/live/application \
  lib/features/notification/application \
  lib/features/favorites/application \
  lib/features/video/presentation/pages/video_detail_page.dart \
  lib/features/live/presentation/pages/live_room_page.dart \
  lib/features/notification/presentation/pages/chat_page.dart \
  lib/features/favorites/presentation/pages/favorite_detail_page.dart \
  test/features/video \
  test/features/live \
  test/features/notification \
  test/features/favorites
git commit -m "refactor: move heavy page commands into application units"
```

---

### Task 7: Reduce Route Coupling and Narrow Feature Barrel Exports

**Files:**
- Modify: `lib/app/router/app_routes.dart`
- Modify: `lib/features/auth/auth.dart`
- Modify: `lib/features/dynamic/dynamic.dart`
- Modify: `lib/features/home/home.dart`
- Modify: `lib/features/live/live.dart`
- Modify: `lib/features/notification/notification.dart`
- Modify: `lib/features/profile/profile.dart`
- Modify: `lib/features/search/search.dart`
- Modify: `lib/features/settings/settings.dart`
- Modify: `lib/features/to_view/to_view.dart`
- Modify: `lib/features/video/video.dart`
- Test: `test/app/router/route_input_test.dart`

- [ ] **Step 1: Rewrite `app_routes.dart` imports to prefer `route_entry.dart`**

Replace broad barrel imports with narrow route imports, for example:

```dart
import 'package:culcul/features/auth/route_entry.dart';
import 'package:culcul/features/dynamic/route_entry.dart';
import 'package:culcul/features/favorites/route_entry.dart';
import 'package:culcul/features/history/route_entry.dart';
import 'package:culcul/features/live/route_entry.dart';
import 'package:culcul/features/notification/route_entry.dart';
import 'package:culcul/features/profile/route_entry.dart';
import 'package:culcul/features/ranking/route_entry.dart';
import 'package:culcul/features/search/route_entry.dart';
import 'package:culcul/features/settings/route_entry.dart';
import 'package:culcul/features/to_view/route_entry.dart';
import 'package:culcul/features/video/route_entry.dart';
```

Keep direct page imports only where a route has no route-entry representation yet.

- [ ] **Step 2: Trim feature barrel exports**

Each `feature.dart` file should export:

```dart
export 'feature_scope.dart';
export 'route_entry.dart';
```

Keep extra exports only if a non-routing external consumer inside another feature truly depends on them. Remove presentation widget exports such as:

```dart
export 'presentation/widgets/login_dialog.dart';
export 'presentation/widgets/video_more_bottom_sheet.dart';
```

- [ ] **Step 3: Update any broken imports at call sites**

When a consumer depended on a broad feature barrel, replace it with the narrow path it actually needs:

```dart
import 'package:culcul/features/auth/presentation/widgets/login_dialog.dart';
```

instead of:

```dart
import 'package:culcul/features/auth/auth.dart';
```

- [ ] **Step 4: Run the router tests**

Run:

```bash
flutter test test/app/router/route_input_test.dart
flutter test test/architecture/shared_boundary_guard_test.dart
```

Expected: route tests still pass and the broad barrel import assertion now passes.

- [ ] **Step 5: Commit**

```bash
git add \
  lib/app/router/app_routes.dart \
  lib/features/auth/auth.dart \
  lib/features/dynamic/dynamic.dart \
  lib/features/home/home.dart \
  lib/features/live/live.dart \
  lib/features/notification/notification.dart \
  lib/features/profile/profile.dart \
  lib/features/search/search.dart \
  lib/features/settings/settings.dart \
  lib/features/to_view/to_view.dart \
  lib/features/video/video.dart
git commit -m "refactor: narrow route and barrel dependencies"
```

---

### Task 8: Prepare the `shared -> core/ui` Split With Safe Pilot Moves

**Files:**
- Create:
  - `lib/core/core.dart`
  - `lib/ui/ui.dart`
- Move pilot files:
  - `lib/shared/errors/app_error.dart` -> `lib/core/errors/app_error.dart`
  - `lib/shared/result/result.dart` -> `lib/core/result/result.dart`
  - `lib/shared/theme/app_theme.dart` -> `lib/ui/theme/app_theme.dart`
  - `lib/shared/responsive/app_breakpoints.dart` -> `lib/ui/responsive/app_breakpoints.dart`
- Modify imports in touched consumers

- [ ] **Step 1: Create root pilot entrypoints**

Create `lib/core/core.dart`:

```dart
export 'errors/app_error.dart';
export 'result/result.dart';
```

Create `lib/ui/ui.dart`:

```dart
export 'theme/app_theme.dart';
export 'responsive/app_breakpoints.dart';
```

- [ ] **Step 2: Move the pilot infra files**

Move:

```text
lib/shared/errors/app_error.dart -> lib/core/errors/app_error.dart
lib/shared/result/result.dart -> lib/core/result/result.dart
```

Update imports to:

```dart
import 'package:culcul/core/core.dart';
```

- [ ] **Step 3: Move the pilot UI files**

Move:

```text
lib/shared/theme/app_theme.dart -> lib/ui/theme/app_theme.dart
lib/shared/responsive/app_breakpoints.dart -> lib/ui/responsive/app_breakpoints.dart
```

Update imports to:

```dart
import 'package:culcul/ui/ui.dart';
```

- [ ] **Step 4: Keep temporary compatibility exports only if the batch is too wide**

If import churn is too large for one batch, add temporary pass-through exports:

```dart
// lib/shared/theme/app_theme.dart
export 'package:culcul/ui/theme/app_theme.dart';
```

and remove them in the next cleanup batch.

- [ ] **Step 5: Run analyze and architecture guards**

Run:

```bash
flutter analyze
flutter test test/architecture
```

Expected: pilot moves compile cleanly and do not reintroduce `shared -> features` dependencies.

- [ ] **Step 6: Commit**

```bash
git add lib/core lib/ui lib/shared test/architecture
git commit -m "refactor: add core and ui pilot modules"
```

---

### Task 9: Full Validation, Impact Review, and Branch Hygiene

**Files:**
- Modify: none expected
- Test: all touched suites plus full project validation

- [ ] **Step 1: Run targeted test groups**

Run:

```bash
flutter test test/shared
flutter test test/features/dynamic
flutter test test/app/router
flutter test test/architecture
```

Expected: all targeted suites pass.

- [ ] **Step 2: Run project-wide analysis**

Run:

```bash
flutter analyze
```

Expected: no new analyzer errors.

- [ ] **Step 3: Run the full suite**

Run:

```bash
flutter test
```

Expected: full suite passes, or any unrelated pre-existing failures are explicitly documented and spun out into new `bd` issues.

- [ ] **Step 4: Run GitNexus checks if the MCP or CLI is available in the execution session**

Required by project `AGENTS.md` before code-review completion:

```text
gitnexus_impact({target: "<edited symbol>", direction: "upstream"})
gitnexus_detect_changes({scope: "all"})
```

If MCP is unavailable but CLI indexing is available, refresh the index first:

```bash
npx gitnexus analyze
```

- [ ] **Step 5: Final commit series**

If any validation fixes were needed, commit them explicitly:

```bash
git add .
git commit -m "test: finish architecture boundary cleanup validation"
```

- [ ] **Step 6: Update beads issue status and prepare handoff**

Run:

```bash
bd show Culcul-tnl
bd close Culcul-tnl --reason "Completed"
```

If follow-up work remains for a wider `shared` migration, create linked issues before closing:

```bash
bd create "Continue shared to core/ui migration" \
  --description="Move remaining shared infra and widgets after pilot batch" \
  -t task -p 1 --deps discovered-from:Culcul-tnl --json
```

---

## Self-Review

- Spec coverage: this plan covers baseline restoration, phase-1 boundary cleanup, phase-2 command extraction, route narrowing, guard tests, and a controlled pilot for `shared -> core/ui`.
- Placeholder scan: no `TODO`, `TBD`, or “implement later” placeholders remain.
- Type consistency: the introduced abstractions use stable names across tasks:
  - `SessionCookieRefresher`
  - `VideoActionsBottomSheet`
  - `DynamicDetailActions`

---

Plan complete and saved to `docs/superpowers/plans/2026-04-17-architecture-boundary-cleanup-plan.md`. Two execution options:

**1. Subagent-Driven (recommended)** - I dispatch a fresh subagent per task, review between tasks, fast iteration

**2. Inline Execution** - Execute tasks in this session using executing-plans, batch execution with checkpoints

**Which approach?**
