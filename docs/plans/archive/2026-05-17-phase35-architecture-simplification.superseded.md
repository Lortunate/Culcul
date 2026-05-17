# Phase 35 Architecture Simplification Plan

Spec: `docs/specs/archive/2026-05-17-phase35-architecture-simplification.superseded.md`

Status: Superseded by `docs/specs/2026-05-18-phase36-aggressive-architecture-cleanup.md`.

## Global Rules

- Use Git Bash on Windows.
- Use bd for issue state. Do not create a second tracker in markdown.
- Refresh GitNexus before code edits because the current MCP index is two
  commits behind HEAD.
- Run GitNexus impact before editing any function, class, or method.
- Stop and report before editing HIGH or CRITICAL risk symbols.
- Keep generated files consistent with `dart run build_runner build`.
- Prefer generated Riverpod providers and `Notifier` or `AsyncNotifier` when
  state owns behavior.
- Do not add pass-through wrappers, alias providers, or new barrel files.
- Run `gitnexus_detect_changes(scope: "all")` before committing code changes.

## File Map

Former active docs:

- `docs/specs/archive/2026-05-17-phase35-architecture-simplification.superseded.md`
- `docs/plans/archive/2026-05-17-phase35-architecture-simplification.superseded.md`

Archived docs:

- `docs/specs/archive/2026-05-17-phase34-architecture-modernization.completed.md`
- `docs/plans/archive/2026-05-17-phase34-architecture-modernization.completed.md`

Pointers:

- `CLAUDE.md`
- `docs/architecture/architecture-guide.md`

## Task 0: Activate Phase 35 Docs

Issue: `culcul-jlg`

Files:

- Create: `docs/specs/2026-05-17-phase35-architecture-simplification.md`
- Create: `docs/plans/2026-05-17-phase35-architecture-simplification.md`
- Move: `docs/specs/2026-05-17-phase34-architecture-modernization.md`
- Move: `docs/plans/2026-05-17-phase34-architecture-modernization.md`
- Modify: `CLAUDE.md`
- Modify: `docs/architecture/architecture-guide.md`

Steps:

1. Archive Phase 34 docs with `.completed.md` suffixes.
2. Write the Phase 35 spec.
3. Write this Phase 35 plan.
4. Update active pointers in `CLAUDE.md`.
5. Update active pointers in `docs/architecture/architecture-guide.md`.
6. Verify:

```bash
rg -n "Active spec|Active plan|Phase 34|Phase 35|2026-05-17-phase34|2026-05-17-phase35" \
  CLAUDE.md docs/architecture docs/specs docs/plans
```

Expected:

- Active pointers name Phase 35.
- Phase 34 hits are archived or historical.

## Task 1: Extract Shared Comment Service

Issue: `culcul-mt9`

Likely files:

- `lib/core/services/comment_service.dart`
- `lib/features/video/data/video_repository_impl.dart`
- `lib/features/dynamic/data/dynamic_repository_impl.dart`
- `lib/features/video/presentation/comments/**`
- `lib/features/dynamic/**`
- `test/architecture/architecture_boundary_guard_test.dart`

Steps:

1. Refresh GitNexus:

```bash
npx gitnexus analyze
```

2. Locate current comment API owners:

```bash
rg -n "comment|reply|ResourceApi|x/v2/reply|mainReply|replyList" lib/features lib/core --glob "*.dart" --glob "!*.g.dart" --glob "!*.freezed.dart"
```

3. Run GitNexus impact for each edited class or method before changes.
4. Move shared BiliBili comment endpoint calls behind one `core/services`
   owner.
5. Keep article cursor-specific behavior in Dynamic.
6. Remove pass-through wrappers after all callers use the shared owner.

Verification:

```bash
rg -n "x/v2/reply|mainReply|replyList|ResourceApi\\(" lib/features lib/core --glob "*.dart" --glob "!*.g.dart" --glob "!*.freezed.dart"
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

## Task 2: Unify Feedback And Toast Pattern

Issue: `culcul-phn`

Likely files:

- `lib/core/feedback/app_feedback.dart`
- `lib/features/**/presentation/**`
- `lib/ui/**`
- `test/architecture/architecture_feedback_guard_test.dart`

Steps:

1. Locate feedback surfaces:

```bash
rg -n "ScaffoldMessenger|SnackBar|showToast|toast|AppFeedback|showSnackBar" lib test --glob "*.dart"
```

2. Run GitNexus impact before editing any helper or extension.
3. Route feature-facing notifications through `AppFeedback`.
4. Delete feature-local helpers that only wrap the same behavior.
5. Keep platform-specific behavior only if it has a distinct runtime reason.

Verification:

```bash
flutter test test/architecture/architecture_feedback_guard_test.dart --reporter compact
flutter analyze --no-fatal-infos
```

## Task 3: Reduce Analyzer Info Debt

Issue: `culcul-xap`

Files:

- Any source file reported by `flutter analyze --no-fatal-infos`.

Steps:

1. Capture current count and top lint codes:

```bash
flutter analyze --no-fatal-infos
```

2. Fix one lint family at a time.
3. Prefer mechanical fixes with low behavioral risk.
4. Do not weaken `analysis_options.yaml`.
5. Do not add broad ignore comments.

Verification:

```bash
flutter analyze --no-fatal-infos
```

Expected:

- Analyzer exits 0.
- Info count decreases.
- No rule is disabled to hide debt.

## Task 4: Split Large Files Only At Real Boundaries

Issue: `culcul-jlg`

Initial candidates:

- `lib/features/notification/data/notification_repository_impl.dart`
- `lib/features/video/presentation/detail/video_detail_view_model.dart`
- `lib/features/video/data/video_repository_impl.dart`
- `lib/core/services/audio_handler.dart`
- `lib/core/data/network/endpoint_policy.dart`
- `lib/core/data/network/providers/wbi_helper_provider.dart`

Steps:

1. Pick one candidate per commit.
2. Run GitNexus context and impact for the edited symbol.
3. Extract behavior only when the new file owns a named responsibility.
4. Keep imports direct.
5. Avoid part files, wrappers, alias providers, or barrel exports.

Verification:

```bash
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

## Task 5: Dependency And Codegen Cleanup

Issue: `culcul-jlg`

Files:

- `pubspec.yaml`
- `pubspec.lock`
- Generated Dart files only if builder output changes.

Steps:

1. Inspect outdated packages:

```bash
flutter pub outdated
```

2. Use Context7 or official docs for Riverpod, go_router, Drift, Retrofit,
   Freezed, Slang, and build_runner before API changes.
3. Update only packages that simplify source, fix known issues, or reduce custom
   code.
4. Regenerate:

```bash
dart run build_runner build --delete-conflicting-outputs
```

5. Review generated diff:

```bash
git diff -- pubspec.yaml pubspec.lock lib
```

Verification:

```bash
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

## Phase Close

Run:

```bash
dart run build_runner build
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
npx gitnexus analyze
gitnexus_detect_changes(scope: "all")
bd ready --json
```

Then close finished bd issues with concrete reasons, commit, pull with rebase,
push bd, push git, and confirm `git status` is up to date with origin.
