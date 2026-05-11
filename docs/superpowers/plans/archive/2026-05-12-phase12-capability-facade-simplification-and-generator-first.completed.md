# Phase 12 Capability Facade Simplification & Generator-First Convergence Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Reduce wrapper layers and repetitive glue by converging feature seams around real capabilities and by preferring the repo's existing mainstream generator stack over hand-written ceremony.

**Architecture:** Keep the stable top-level shape (`app/`, `core/`, `features/`, `ui/`). Phase 12 is a simplification phase, not another bucket rebaseline. The order is: archive and align docs, add guardrails for empty facades and public-contract leaks, simplify the highest-value slices (`home`, `notification`), simplify lower-risk public-contract slices (`dynamic`, `video`, `live`, `search`), then normalize generator-first patterns and refresh the verified guide.

**Tech Stack:** Flutter, Riverpod, Hooks Riverpod, Riverpod Generator, Freezed, Json Serializable, Retrofit, Drift, Dio, GoRouter

---

### Task 1: Archive Phase 11 honestly and establish one active Phase 12 baseline

**Files:**
- Move: `docs/superpowers/specs/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams-design.md`
- Move: `docs/superpowers/plans/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams.md`
- Create: `docs/superpowers/specs/2026-05-12-phase12-capability-facade-simplification-and-generator-first-design.md`
- Create: `docs/superpowers/plans/2026-05-12-phase12-capability-facade-simplification-and-generator-first.md`
- Modify: `CLAUDE.md`
- Modify: `docs/architecture/architecture-guide.md`

- [ ] **Step 1: Verify the current Phase 11 baseline before editing**

Run:

```bash
rg -n "Active spec:|Active plan:|Phase 11|phase11" CLAUDE.md docs/architecture docs/superpowers
git status --short
```

- [ ] **Step 2: Move the old Phase 11 root docs into `archive/` and prepend an honest superseded note**

The archive note must say that Phase 11 correctly identified seam drift, but the newly approved direction widened the objective to wrapper reduction and generator-first simplification.

- [ ] **Step 3: Update the active pointers to Phase 12 only**

- Active spec: `docs/superpowers/specs/2026-05-12-phase12-capability-facade-simplification-and-generator-first-design.md`
- Active plan: `docs/superpowers/plans/2026-05-12-phase12-capability-facade-simplification-and-generator-first.md`

- [ ] **Step 4: Re-scan for contradictory active/archive language**

Run:

```bash
rg -n "Phase 11|phase11|Phase 12|phase12|Active spec|Active plan|SUPERSEDED" CLAUDE.md docs/architecture docs/superpowers
```

- [ ] **Step 5: Commit**

---

### Task 2: Add guardrails for empty facades, public-contract leaks, and implementation imports

**Files:**
- Create: `test/architecture/phase12_empty_facade_guard_test.dart`
- Create: `test/architecture/phase12_public_contract_guard_test.dart`
- Create: `test/architecture/phase12_seam_impl_import_guard_test.dart`
- Create or modify: `tool/architecture/phase12_boundary_snapshot.sh`

- [ ] **Step 1: Write a failing empty-facade guard**

Fail when a facade class only stores repository dependencies and exposes no real capability behavior. Initial expected review targets:

```text
lib/features/auth/application/auth_facade.dart
lib/features/dynamic/application/dynamic_facade.dart
lib/features/favorites/application/fav_facade.dart
lib/features/history/application/history_facade.dart
lib/features/live/application/live_facade.dart
lib/features/ranking/application/ranking_facade.dart
lib/features/search/application/search_facade.dart
lib/features/settings/application/settings_facade.dart
lib/features/to_view/application/to_view_facade.dart
lib/features/video/application/video_facade.dart
```

- [ ] **Step 2: Write a failing public-contract guard**

Fail when any active public-contract or root feature barrel exports `presentation/**` or `data/**`, including selective `show` or `hide` forms.

Initial expected targets:

```text
lib/features/dynamic/dynamic_public_contracts.dart
lib/features/video/video_public_contracts.dart
lib/features/live/live_public_contracts.dart
lib/features/search/search_public_contracts.dart
```

- [ ] **Step 3: Write a failing seam-import guard**

Fail when active seam files import repository implementations directly:

```text
lib/features/*/application/**/*.dart
lib/features/*/feature_scope.dart
```

- [ ] **Step 4: Add a Phase 12 boundary snapshot command**

The snapshot should report:

- empty facade candidates
- public-contract exports of `presentation/**` or `data/**`
- direct imports of `*_repository_impl.dart` from seam files

- [ ] **Step 5: Run the architecture suite**

Run:

```bash
flutter test test/architecture/phase12_* --reporter compact
flutter analyze
```

- [ ] **Step 6: Commit**

---

### Task 3: Simplify `home` and `notification` into real capability seams

**Files:**
- Modify: `lib/features/home/feature_scope.dart`
- Modify: `lib/features/home/application/home_facade.dart`
- Modify: `lib/features/home/data/home_feed_data_source.dart`
- Modify: `lib/features/home/presentation/view_models/home_*`
- Modify: `lib/features/notification/feature_scope.dart`
- Modify: `lib/features/notification/application/notification_facade.dart`
- Modify: `lib/features/notification/application/notification_repository_provider.dart`
- Modify: `lib/features/notification/application/use_cases/**`
- Modify: `lib/features/notification/data/notification_repository_impl.*`
- Modify: `lib/features/notification/presentation/view_models/**`
- Test: `test/features/home/**`
- Test: `test/features/notification/**`

- [ ] **Step 1: Add failing tests for simpler capability seams**

Example target behaviors:

- `home` presentation does not need to depend on `HomeFeedDataSource` directly through the facade contract
- `notification` presentation depends on named capabilities instead of a broad repository-shaped pass-through facade

- [ ] **Step 2: Replace direct data-source or repository-shaped seams with capability services/providers**

Rules:

- keep only the seam that adds real behavior
- delete or merge wrapper layers that only rename the same dependency
- keep the resulting public API narrower than the old repository-shaped surface

- [ ] **Step 3: Re-run focused verification**

Run:

```bash
flutter test test/features/home test/features/notification --reporter compact
flutter analyze
rg -n "HomeFeedDataSource|NotificationRepository" lib/features/home lib/features/notification
```

- [ ] **Step 4: Commit**

---

### Task 4: Collapse lower-value wrapper seams and public-contract leaks in `dynamic`, `video`, `live`, and `search`

**Files:**
- Modify: `lib/features/dynamic/dynamic_public_contracts.dart`
- Modify: `lib/features/dynamic/application/dynamic_facade.dart`
- Modify: `lib/features/dynamic/application/dynamic_repository_provider.dart`
- Modify: `lib/features/dynamic/feature_scope.dart`
- Modify: `lib/features/video/video_public_contracts.dart`
- Modify: `lib/features/video/application/video_facade.dart`
- Modify: `lib/features/video/application/video_repository_provider.dart`
- Modify: `lib/features/video/application/video_entry_workflows.dart`
- Modify: `lib/features/video/feature_scope.dart`
- Modify: `lib/features/live/live_public_contracts.dart`
- Modify: `lib/features/search/search_public_contracts.dart`
- Test: `test/features/dynamic/**`
- Test: `test/features/video/**`

- [ ] **Step 1: Add failing tests for public-contract leaks and empty-facade survivors**

- [ ] **Step 2: Remove presentation exports from public-contract files**

If a symbol still needs cross-feature reuse, either:

- promote it into a truly public capability or shared UI contract, or
- keep it private to the feature

- [ ] **Step 3: Remove or repurpose empty facades and duplicate repository-entry glue**

The preferred outcome is fewer seam files, not renamed seam files.

- [ ] **Step 4: Merge file shards when they only preserve accidental structure**

Start with the highest-noise splits such as `video_entry_workflows.dart` or wrapper-only helper files that do not hold a distinct behavioral unit.

- [ ] **Step 5: Re-run focused verification**

Run:

```bash
flutter test test/features/dynamic test/features/video --reporter compact
flutter analyze
rg -n "^export .*presentation/|^export .*data/" lib/features
```

- [ ] **Step 6: Commit**

---

### Task 5: Normalize generator-first patterns and refresh the verified guide

**Files:**
- Modify: selected active feature files touched by Tasks 3-4
- Modify: `docs/architecture/architecture-guide.md`

- [ ] **Step 1: Replace hand-written glue where the current stack already has a better standard**

Candidate simplifications:

- Riverpod Generator for provider-entry boilerplate
- Freezed and Json Serializable for repetitive request/response or state shells
- Retrofit annotations for API contract boilerplate
- Drift-backed persistence contracts instead of bespoke local-storage wiring

The rule is: only normalize within slices already opened by this phase. Do not trigger repo-wide churn.

- [ ] **Step 2: Document the preferred simplification shape**

The architecture guide should describe:

- when a facade is warranted
- when a provider or use case is enough
- which generator-first patterns are now preferred in active slices

- [ ] **Step 3: Run final verification**

Run:

```bash
flutter analyze
flutter test test/architecture/phase12_* test/features/home test/features/notification test/features/dynamic test/features/video --reporter compact
rg -n "ignore: unused_field" lib/features/*/application/*_facade.dart
rg -n "_repository_impl\\.dart" lib/features/*/application lib/features/*/feature_scope.dart
```

- [ ] **Step 4: Commit**
