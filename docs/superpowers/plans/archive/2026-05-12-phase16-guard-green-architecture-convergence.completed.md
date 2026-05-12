# Phase 16 Guard-Green Architecture Convergence Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Status:** Completed

**Goal:** Make the current Culcul architecture baseline truthful, guard-green, and ready for the next real code-structure pass.

**Verified:** `flutter test test/architecture --reporter compact` passes, and the active docs now match the Phase 16 baseline.

**Architecture:** Phase 16 is a convergence pass, not another broad rewrite. It first fixes planning truth, then repairs architecture guards and ownership seams, then performs narrow dependency/API cleanup backed by verification.

**Tech Stack:** Flutter 3.41/Dart 3.10, Riverpod 3 + riverpod_generator, go_router + go_router_builder, Freezed, Json Serializable, Retrofit, Drift, Dio.

---

## Task 1: Archive Truth And Active Baseline

**Files:**
- Modify: `CLAUDE.md`
- Modify: `docs/architecture/architecture-guide.md`
- Modify: `docs/superpowers/specs/archive/2026-05-12-phase13-structural-simplification-and-single-source-of-truth.completed.md`
- Modify: `docs/superpowers/plans/archive/2026-05-12-phase13-structural-simplification-and-single-source-of-truth.completed.md`
- Modify: `docs/superpowers/specs/archive/2026-05-12-phase14-dependency-modernization-and-model-consistency.completed.md`
- Modify: `docs/superpowers/plans/archive/2026-05-12-phase14-dependency-modernization-and-model-consistency.completed.md`
- Move/Modify: `docs/superpowers/specs/archive/2026-05-12-phase15-architecture-streamlining-and-dead-weight-removal.superseded.md`
- Move/Modify: `docs/superpowers/plans/archive/2026-05-12-phase15-architecture-streamlining-and-dead-weight-removal.superseded.md`
- Create: `docs/superpowers/specs/2026-05-12-phase16-guard-green-architecture-convergence.md`
- Create: `docs/superpowers/plans/2026-05-12-phase16-guard-green-architecture-convergence.md`

- [ ] Verify active/archive drift:

```bash
rg -n "Active spec|Active plan|Status:\\*\\* Active|Phase 15|Phase 16" CLAUDE.md docs/architecture docs/superpowers
```

Expected: only Phase 16 is active after this task; archived Phase 13/14/15 files do not claim active status.

- [ ] Run architecture docs pointer audit:

```bash
find docs/superpowers/specs -maxdepth 2 -type f | sort
find docs/superpowers/plans -maxdepth 2 -type f | sort
```

Expected: active Phase 16 files exist at root; Phase 15 files exist only under archive with `.superseded.md`.

## Task 2: Repair Architecture Guard Root Causes

**Files:**
- Modify: `test/architecture/auth_video_architecture_guard_test.dart`
- Modify: `test/architecture/phase9_runtime_ownership_guard_test.dart`
- Modify: `test/architecture/phase9_video_domain_dto_reexport_guard_test.dart`
- Modify production files only if the guard reveals a real boundary leak.

- [ ] Reproduce current guard failures:

```bash
flutter test test/architecture --reporter compact
```

Expected at phase start: 7 failures. Capture exact failing guards before edits.

- [ ] Classify each failure as stale guard or real code leak:

```bash
rg -n "followListServiceProvider|playable_urls|use_video_loader|auth_repository_impl|notification_repository_impl|core/bootstrap/providers|shared/providers" lib test/architecture
```

Expected: every test edit is justified by a current ownership rule, not by making tests weaker.

- [ ] Update stale assertions:

Rules:
- Keep assertions that protect `core/` and `ui/` from `features/`.
- Replace provider-name assertions with behavior/ownership assertions.
- Do not allow feature presentation code to import another feature's `data/**` internals.
- Keep DTO/protobuf out of domain and presentation.

- [ ] Re-run:

```bash
flutter test test/architecture --reporter compact
```

Expected: architecture tests pass or remaining failures are documented as production leaks for Task 3.

## Task 3: Converge Bootstrap Provider Ownership

**Files:**
- Inspect/modify: `lib/app/runtime/root_overrides.dart`
- Inspect/modify: `lib/core/bootstrap/providers/*.dart`
- Inspect/modify: `lib/core/data/network/dio_client.dart`
- Inspect/modify: `lib/core/data/network/interceptors/csrf_interceptor.dart`
- Inspect/modify: `lib/features/*/**`
- Create or modify: `test/architecture/phase16_bootstrap_provider_ownership_guard_test.dart`

- [ ] Run GitNexus impact before editing each touched symbol, per repo rule:

```text
gitnexus_impact(target: "<symbol>", direction: "upstream", repo: "Culcul")
```

Report direct callers and risk before code edits.

- [ ] Inventory direct bootstrap-provider imports:

```bash
rg -n "package:culcul/core/bootstrap/providers|package:culcul/shared/providers" lib test -g "*.dart"
```

Expected current known production imports include `root_overrides.dart`, network infrastructure, auth/settings/profile data services, and several presentation view models.

- [ ] Define the allowed import policy in the new guard:

Allowed:
- `lib/app/runtime/root_overrides.dart`
- `lib/core/bootstrap/providers/*.dart`
- narrow core infrastructure files if they are the canonical runtime seam

Disallowed:
- feature presentation/view model files importing bootstrap providers directly
- feature data files importing app-owned runtime providers when a repository constructor/provider seam can receive the dependency
- any `package:culcul/shared/providers/*` import in production

- [ ] Move feature-level dependency access behind feature-owned repository/provider seams.

Expected: feature presentation code talks to feature view models/use cases/repositories, not bootstrap provider stubs.

- [ ] Verify:

```bash
flutter test test/architecture/phase16_bootstrap_provider_ownership_guard_test.dart --reporter compact
flutter test test/architecture --reporter compact
```

Expected: new guard passes and the full architecture suite stays green.

## Task 4: Add Phase 16 Doc And Guard Coverage

**Files:**
- Create: `test/architecture/phase16_archive_status_guard_test.dart`
- Create: `test/architecture/phase16_baseline_pointer_guard_test.dart`
- Create: `tool/architecture/phase16_boundary_snapshot.sh`
- Modify: `docs/architecture/architecture-guide.md`

- [ ] Add archive status guard.

Behavior:
- scan `docs/superpowers/specs/archive/*.md` and `docs/superpowers/plans/archive/*.md`
- fail if any archived file contains an active status declaration
- allow `Completed and archived`, `Superseded`, or historical prose that does not declare active status

- [ ] Add baseline pointer guard.

Behavior:
- `CLAUDE.md` must reference the active Phase 16 spec and plan
- root `docs/superpowers/specs/` and `docs/superpowers/plans/` should contain one active architecture baseline for the current phase
- `docs/architecture/architecture-guide.md` must mention Phase 16

- [ ] Add Phase 16 snapshot script:

```bash
bash tool/architecture/phase16_boundary_snapshot.sh
```

Expected output sections:
- active planning baseline
- red/green architecture test summary command
- bootstrap provider import inventory
- archive active-status scan
- dependency modernization candidates

## Task 5: Narrow Dependency And API Modernization

**Files:**
- Modify: `pubspec.yaml`
- Modify: `pubspec.lock`
- Modify generated files only through build_runner.

- [ ] Capture package drift:

```bash
dart pub outdated --json
```

Expected known candidates: `dio_cache_interceptor`, `drift`, `drift_flutter`, `go_router`, `go_router_builder`, `build_runner`.

- [ ] Audit removable direct dependencies:

```bash
for pkg in cupertino_icons animations json_annotation path; do
  printf "%s " "$pkg"
  rg -n "package:${pkg}/" lib test tool -g "*.dart" || true
done
```

Rules:
- Do not remove plugin companion packages only because they lack Dart imports.
- Keep generator/runtime annotation packages if generated code or source annotations require them.
- Remove a direct dependency only when no source, generated code, asset config, or plugin runtime needs it.

- [ ] Apply package updates in one narrow batch:

```bash
flutter pub upgrade dio_cache_interceptor drift drift_flutter go_router go_router_builder build_runner
dart run build_runner build --delete-conflicting-outputs
```

- [ ] Verify:

```bash
flutter analyze
flutter test test/architecture --reporter compact
```

Expected: no new analyzer errors. If existing non-architecture analyzer failures remain, record exact files and decide whether they belong in Task 6.

## Task 6: Final Verification And Scope Detection

**Files:**
- Modify only files needed by failed verification.

- [ ] Run full verification:

```bash
flutter analyze
flutter test --reporter compact
```

- [ ] Run GitNexus change detection before commit:

```text
gitnexus_detect_changes(scope: "all", repo: "Culcul")
```

Expected: affected scope matches Phase 16 docs, architecture guards, bootstrap ownership, and narrow dependency modernization.

- [ ] Update `docs/architecture/architecture-guide.md` with final verified state.

Expected: the guide says what is currently true, not what the phase hopes to make true.

- [ ] Commit:

```bash
git add CLAUDE.md docs/architecture docs/superpowers test/architecture tool/architecture pubspec.yaml pubspec.lock lib
git commit -m "refactor(phase16): converge architecture guards and bootstrap ownership"
```

Do not push unless explicitly requested.
