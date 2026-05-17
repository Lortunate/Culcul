# Phase 36 Aggressive Architecture Cleanup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development
> (recommended) or superpowers:executing-plans to implement this plan
> task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Simplify Culcul's architecture aggressively while preserving the approved top-level app/core/features/ui boundary.

**Architecture:** Keep the macro layout stable and refactor within it. Collapse
duplicate source owners, remove compatibility shims, and split only around named
behavior with tests or architecture guards.

**Tech Stack:** Flutter, Dart, Riverpod generated providers, go_router/go_router_builder, Drift, Dio/Retrofit, Freezed, Slang, GitNexus, bd.

---

Spec: `docs/specs/2026-05-18-phase36-aggressive-architecture-cleanup.md`

## Global Rules

- Use Git Bash on Windows.
- Use bd for issue state. Do not create markdown task trackers.
- Run GitNexus impact before editing any function, class, or method.
- Stop and report before editing HIGH or CRITICAL risk symbols.
- Use Context7 before changing library APIs for Riverpod, go_router, Drift,
  Freezed, Retrofit, Slang, Dio, or build_runner.
- Keep generated output consistent with
  `dart run build_runner build --delete-conflicting-outputs`.
- Do not add pass-through wrappers, alias providers, compatibility shims, or new
  barrel chains.
- Run `gitnexus_detect_changes(scope: "all")` before committing code changes.
- End sessions by pushing git and bd state.

## File Map

Active docs:

- `docs/specs/2026-05-18-phase36-aggressive-architecture-cleanup.md`
- `docs/plans/2026-05-18-phase36-aggressive-architecture-cleanup.md`

Archived docs:

- `docs/specs/archive/2026-05-17-phase35-architecture-simplification.superseded.md`
- `docs/plans/archive/2026-05-17-phase35-architecture-simplification.superseded.md`

Pointers:

- `CLAUDE.md`
- `docs/architecture/architecture-guide.md`

## Task 0: Activate Phase 36 Docs And bd Tracking

Issue: `culcul-rg4`

**Files:**

- Create: `docs/specs/2026-05-18-phase36-aggressive-architecture-cleanup.md`
- Create: `docs/plans/2026-05-18-phase36-aggressive-architecture-cleanup.md`
- Move: `docs/specs/2026-05-17-phase35-architecture-simplification.md`
- Move: `docs/plans/2026-05-17-phase35-architecture-simplification.md`
- Modify: `CLAUDE.md`
- Modify: `docs/architecture/architecture-guide.md`

- [ ] **Step 1: Verify clean routing pointers**

Run:

```bash
rg -n "Active spec|Active plan|Phase 35|Phase 36|2026-05-17-phase35|2026-05-18-phase36" \
  CLAUDE.md docs/architecture docs/specs docs/plans
```

Expected:

- Active pointers name Phase 36.
- Phase 35 hits are archived or historical.

- [ ] **Step 2: Confirm bd epic and child tasks**

Run:

```bash
bd show culcul-rg4 --json
bd show culcul-4ir --json
bd show culcul-dhm --json
bd show culcul-rzy --json
bd show culcul-psp --json
bd show culcul-fpl --json
```

Expected: all six Phase 36 issues exist and are open.

- [ ] **Step 3: Verify active docs count**

Run:

```bash
find docs/specs -maxdepth 1 -type f -name "*.md" | sort
find docs/plans -maxdepth 1 -type f -name "*.md" | sort
```

Expected:

- Only the Phase 36 spec is active under `docs/specs/`.
- Only the Phase 36 plan is active under `docs/plans/`.

## Task 1: Source-Of-Truth Consolidation

Issue: `culcul-4ir`

**Files likely touched:**

- `lib/core/feedback/app_feedback.dart`
- `lib/core/errors/app_error.dart`
- `lib/core/result/result.dart`
- `lib/core/services/**`
- `lib/core/data/network/**`
- `lib/app/router/**`
- `lib/features/**/data/**`
- `lib/features/**/application/**`
- `test/architecture/**`

- [ ] **Step 1: Locate duplicate owners**

Run:

```bash
rg -n "ScaffoldMessenger|SnackBar|showSnackBar|toast|showToast|AppFeedback|AppError|Result<|x/v2/reply|mainReply|replyList|DioClient|RequestExecutor" \
  lib test --glob "*.dart" --glob "!*.g.dart" --glob "!*.freezed.dart" --glob "!*.pb.dart"
```

Expected:

- One owner per concept is identified before edits.
- Any duplicate wrapper has a named deletion or merge target.

- [ ] **Step 2: Run GitNexus impact per edited symbol**

For each edited class, function, or method, run:

```text
gitnexus_impact({target: "AppFeedback", direction: "upstream", repo: "Culcul"})
gitnexus_impact({target: "AppError", direction: "upstream", repo: "Culcul"})
gitnexus_impact({target: "RequestExecutor", direction: "upstream", repo: "Culcul"})
```

Expected:

- LOW or MEDIUM risk may proceed.
- HIGH or CRITICAL risk is reported before edits.
- Additional edited symbols get the same impact check before modification.

- [ ] **Step 3: Move callers to the chosen owner**

For each duplicate surface:

- Pick the owner named in the spec.
- Update callers to import the owner directly.
- Delete the duplicate after the last caller moves.
- Do not leave alias providers or compatibility exports.

- [ ] **Step 4: Verify source count**

Run:

```bash
rg -n "ScaffoldMessenger|SnackBar|showSnackBar|toast|showToast|x/v2/reply|mainReply|replyList" \
  lib test --glob "*.dart" --glob "!*.g.dart" --glob "!*.freezed.dart" --glob "!*.pb.dart"
bash tool/architecture/run_architecture_guards.sh
flutter analyze --no-fatal-infos
```

Expected:

- Feature-facing feedback routes through `AppFeedback`.
- Shared comment endpoints have one owner.
- Architecture guards pass.

## Task 2: Feature Directory Cleanup

Issue: `culcul-dhm`

**Files likely touched:**

- `lib/features/video/**`
- `lib/features/dynamic/**`
- `lib/features/notification/**`
- `lib/features/live/**`
- `lib/features/profile/**`
- `lib/features/search/**`
- `test/architecture/**`

- [ ] **Step 1: Pick one feature**

Start with one high-volume feature. First target: `lib/features/video`.
Remaining candidates by file count:

- `lib/features/dynamic`
- `lib/features/notification`
- `lib/features/live`
- `lib/features/profile`

- [ ] **Step 2: Audit layers**

Run:

```bash
find lib/features/video -maxdepth 3 -type f -name "*.dart" | sort
rg -n "abstract class|implements|extends|Provider|@riverpod|repository|service|mapper|TODO|UnimplementedError" \
  lib/features/video --glob "*.dart" --glob "!*.g.dart" --glob "!*.freezed.dart"
```

Expected:

- Empty and pass-through layers are named.
- Real behavior owners are preserved.

- [ ] **Step 3: Run GitNexus impact**

Run impact for each edited feature symbol before moving or deleting it.

- [ ] **Step 4: Normalize the feature**

Apply this shape only where files exist for real behavior:

```text
lib/features/video/
  data/
  application/
  presentation/
  route_entry.dart
  video.dart
```

Rules:

- Delete `domain/` when it only mirrors DTOs.
- Delete interfaces with one implementation and no test/runtime boundary.
- Delete pass-through providers.
- Keep route entry files stable for router imports.

- [ ] **Step 5: Verify**

Run:

```bash
bash tool/architecture/run_architecture_guards.sh
flutter analyze --no-fatal-infos
```

Expected:

- No cross-feature private imports.
- No new barrel chains.
- Analyzer passes or the changed slice reduces existing info debt.

## Task 3: Dead Code And Wrapper Removal

Issue: `culcul-rzy`

**Files likely touched:**

- `lib/core/**`
- `lib/ui/**`
- `lib/features/**`
- `test/architecture/**`

- [ ] **Step 1: Build deletion candidates**

Run:

```bash
rg -n "TODO\\(|TODO:|FIXME|UnimplementedError|throw Exception\\(|=> ref\\.watch\\(|=> ref\\.read\\(|export '" \
  lib test --glob "*.dart" --glob "!*.g.dart" --glob "!*.freezed.dart" --glob "!*.pb.dart"
```

Expected:

- Candidate list is grouped into delete, merge, keep.

- [ ] **Step 2: Confirm unused or pass-through behavior**

For each candidate:

```bash
rg -n "ListUtils|list_utils" lib test --glob "*.dart"
rg -n "ShareUtils|share_utils" lib test --glob "*.dart"
rg -n "WatchLaterPort|watch_later_port" lib test --glob "*.dart"
```

Expected:

- Deletion only proceeds when no caller remains or callers can use the real owner
  directly.
- Other candidates from Step 1 get the same direct-reference check before
  deletion.

- [ ] **Step 3: Delete or merge**

Rules:

- Delete unused files.
- Inline one-line wrappers into direct callers when it improves readability.
- Keep wrappers only for platform boundaries, test doubles, or real API policy.

- [ ] **Step 4: Verify**

Run:

```bash
bash tool/architecture/run_architecture_guards.sh
flutter analyze --no-fatal-infos
flutter test test/architecture --reporter compact
```

Expected:

- No architecture guard regression.
- Analyzer does not gain new warnings or infos from the slice.

## Task 4: Performance Cleanup

Issue: `culcul-psp`

**Files likely touched:**

- `lib/app/**`
- `lib/core/data/network/**`
- `lib/core/services/audio_handler.dart`
- `lib/features/home/**`
- `lib/features/video/**`
- `lib/features/notification/**`
- `lib/features/**/data/local/**`

- [ ] **Step 1: Identify expensive paths**

Run:

```bash
rg -n "initState|Future\\.wait|compute\\(|Timer|StreamBuilder|ListView|GridView|PageView|watch\\(|select\\(|keepAlive|autoDispose|drift|watch\\(" \
  lib --glob "*.dart" --glob "!*.g.dart" --glob "!*.freezed.dart" --glob "!*.pb.dart"
```

Expected:

- Startup, list, stream, provider, and persistence hotspots are named.

- [ ] **Step 2: Run impact and choose one hotspot**

Run GitNexus impact for the edited symbol. Start with LOW or MEDIUM risk.

- [ ] **Step 3: Optimize by removing work**

Prefer:

- Lazy startup instead of eager root initialization.
- `select` or smaller providers instead of broad widget rebuilds.
- Lazy list builders and stable keys for large lists.
- Feature-owned Drift streams with narrow query output.
- Dispose media/player resources at the owner boundary.

- [ ] **Step 4: Verify**

Run the smallest relevant focused test, then:

```bash
bash tool/architecture/run_architecture_guards.sh
flutter analyze --no-fatal-infos
```

Expected:

- Behavior preserved.
- Rebuild or startup work is reduced by code evidence or focused measurement.

## Task 5: Dependency And Codegen Modernization

Issue: `culcul-fpl`

**Files likely touched:**

- `pubspec.yaml`
- `pubspec.lock`
- `build.yaml`
- Generated `*.g.dart`, `*.freezed.dart`, Slang output only when builders change.

- [ ] **Step 1: Inspect outdated packages**

Run:

```bash
flutter pub outdated
```

Expected:

- Candidate upgrades are chosen only when they simplify source, remove custom
  code, fix known issues, or reduce risk.

- [ ] **Step 2: Fetch current docs before API changes**

Use Context7 for any package API migration:

- Riverpod
- go_router
- Drift
- Freezed
- Retrofit
- Slang
- Dio
- build_runner

- [ ] **Step 3: Apply one dependency slice**

Run:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 4: Review generated diff**

Run:

```bash
git diff -- pubspec.yaml pubspec.lock build.yaml lib
```

Expected:

- Generated changes match the dependency slice.
- No unrelated generated churn is accepted.

- [ ] **Step 5: Verify**

Run:

```bash
bash tool/architecture/run_architecture_guards.sh
flutter analyze --no-fatal-infos
```

Expected:

- Architecture guards pass.
- Analyzer passes.

## Final Phase Gates

Run before closing the Phase 36 epic:

```bash
dart run build_runner build --delete-conflicting-outputs
bash tool/architecture/run_architecture_guards.sh
flutter analyze --no-fatal-infos
flutter test --reporter compact
npx gitnexus analyze
```

Then run GitNexus detect changes:

```text
gitnexus_detect_changes(scope: "all")
```

Expected:

- Changes map only to planned symbols and flows.
- Any high-risk process has a written follow-up bd issue or completed test
  coverage.
