# Phase 8: Architecture Rebaseline & Boundary Cleanup — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Spec:** `docs/superpowers/specs/archive/2026-05-08-phase8-architecture-optimization-design.completed.md`
**Date:** 2026-05-08

## Execution Order

Truth first, boundaries second, reuse third. Rebaseline the docs and tests first so later moves have a stable target. Then remove `core -> features` leaks, then extract shared presentation primitives, then fix workflow/platform boundary leaks, then do final verification.

---

## Part A: Rebaseline the Live Architecture Surface

### Task 1: Replace the stale same-day Phase 8 draft

**Goal:** Archive the stale same-day Phase 8 draft and make the root doc set match the current repo snapshot.

**Files:**
- Archive:
  - `docs/superpowers/specs/archive/2026-05-08-phase8-architecture-optimization-design.superseded.md`
  - `docs/superpowers/plans/archive/2026-05-08-phase8-architecture-optimization.superseded.md`
- Update:
  - `docs/superpowers/specs/2026-05-08-phase8-architecture-optimization-design.md`
  - `docs/superpowers/plans/2026-05-08-phase8-architecture-optimization.md`
  - `docs/architecture/architecture-guide.md`

- [ ] Rewrite the active spec around the real current-state audit, not the already-landed morning assumptions.
- [ ] Rewrite the active plan around remaining architecture debt only.
- [ ] Update the architecture guide so:
  - Phase 7 points at archived docs
  - notification is no longer described as FULL
  - the Phase 8 section reflects what is already landed vs what remains

**Verification**

```bash
rg -n "Phase 8|notification|cross-feature imports|Phase 7" docs/architecture/architecture-guide.md docs/superpowers/specs docs/superpowers/plans
```

### Task 2: Add architecture guard coverage for the refreshed rules

**Goal:** Make the refreshed architecture rules executable instead of prose-only.

**Files:**
- Create or update:
  - `test/architecture/core_dependency_direction_guard_test.dart`
  - `test/architecture/cross_feature_presentation_guard_test.dart`
  - `test/architecture/shared_boundary_guard_test.dart`

- [ ] Add a guard that fails on any `core/** -> features/**` import.
- [ ] Add a guard that fails on direct `features/** -> features/**/presentation/(widgets|pages|view_models)` imports unless explicitly allowlisted.
- [ ] Keep the temporary allowlist exact, documented, and self-pruning so later tasks can shrink it safely.

**Verification**

```bash
flutter test test/architecture/core_dependency_direction_guard_test.dart
flutter test test/architecture/cross_feature_presentation_guard_test.dart
```

---

## Part B: Remove `core -> features` Contract Leaks

### Task 3: Remove unnecessary relation/search repository seams from `core/session`

**Goal:** `core/session/**` must stop depending on feature-owned repository interfaces. Remove those seams entirely when they are not genuinely cross-feature; only introduce a core-owned contract if a minimal shared seam is still needed.

**Files:**
- Update:
  - `lib/core/session/relation_providers.dart`
  - `lib/core/session/search_providers.dart`
  - `lib/features/profile/application/follow_list_adapter.dart`
  - `lib/features/search/application/search_service_adapter.dart`
  - `lib/features/profile/feature_scope.dart`
  - `lib/features/search/feature_scope.dart`
  - any affected imports in consumers or tests

- [ ] Remove `crossRelationRepositoryProvider` and `crossSearchRepositoryProvider` if they are only feature-local adapter details.
- [ ] Point the owning adapters directly at their feature repositories when no real cross-feature seam exists.
- [ ] Keep only the genuinely shared `core/session` providers such as `modifyRelationProvider` and `searchServiceProvider`.

**Verification**

```bash
flutter test test/architecture/core_dependency_direction_guard_test.dart
flutter analyze
```

### Task 4: Tighten public core barrels after contract extraction

**Goal:** Make `core/core.dart` expose the real public architecture surface and stop re-exporting confusing legacy seams.

**Files:**
- Update:
  - `lib/core/core.dart`
  - `lib/core/contracts/*.dart` as needed
  - optionally `lib/core/contracts/contracts.dart` if a grouped barrel is introduced

- [ ] Re-evaluate whether `errors/exceptions.dart` should remain a public core export.
- [ ] Export the new contract seam consistently.
- [ ] Keep the barrel intentional rather than exhaustive.

**Verification**

```bash
flutter analyze
```

### Task 5: Remove app-root imports of feature presentation internals

**Goal:** Keep `app/` composed against public feature seams rather than `presentation/**` implementation details.

**Files:**
- Update:
  - `lib/app/app.dart`
  - `lib/features/settings/settings.dart`
  - `lib/features/settings/feature_scope.dart`
  - `lib/features/settings/presentation/view_models/settings_view_model.dart`
  - any small bridge/provider introduced to expose theme mode cleanly

- [ ] Expose app-consumable theme-mode state through a public settings seam.
- [ ] Remove direct `app -> features/settings/presentation/**` imports.
- [ ] Keep the final dependency readable from the feature root barrel or feature scope.

**Verification**

```bash
flutter analyze
rg -n "features/settings/presentation" lib/app
```

---

## Part C: Extract Shared Presentation Primitives Out of Features

### Task 6: Extract the shared video/list/media widget cluster into `ui/`

**Goal:** Remove the largest cross-feature widget dependency cluster, currently centered on `features/video/**`.

**Files:**
- Create or move into:
  - `lib/ui/widgets/cards/**`
  - `lib/ui/widgets/media/**`
  - `lib/ui/widgets/skeletons/**`
- Update:
  - `lib/features/video/presentation/widgets/**`
  - consumers in `favorites`, `history`, `home`, `profile`, `ranking`, `search`, `to_view`, and `dynamic`
  - `lib/ui/ui.dart`

- [ ] Move pure reusable widgets such as list cards, thumbnails, skeletons, and generic media actions out of `features/video/**`.
- [ ] Keep feature-specific orchestration outside the extracted widgets via callbacks/builders.
- [ ] Replace consumer imports to use `ui/**`.

**Verification**

```bash
flutter test test/architecture/cross_feature_presentation_guard_test.dart
flutter analyze
```

### Task 7: Extract comment / emoji / user-tag primitives out of feature presentation trees

**Goal:** Remove the remaining cross-feature widget imports driven by comments, emoji rendering, and user tags.

**Files:**
- Create or move into:
  - `lib/ui/widgets/comments/**`
  - `lib/ui/widgets/text/**`
  - `lib/ui/widgets/users/**`
- Update:
  - `lib/features/video/presentation/widgets/comments/**`
  - `lib/features/dynamic/presentation/widgets/**`
  - `lib/features/profile/presentation/widgets/**`
  - `lib/features/notification/presentation/widgets/chat/**`
  - `lib/ui/ui.dart`

- [ ] Move reusable comment display primitives to `ui/widgets/comments/**`.
- [ ] Move reusable emoji/user-tag display widgets to `ui/widgets/text/**` or `ui/widgets/users/**`.
- [ ] Leave feature-specific page composition inside features.

**Verification**

```bash
flutter test test/architecture/cross_feature_presentation_guard_test.dart
flutter analyze
```

### Task 8: Replace cross-feature page/view-model imports with explicit seams

**Goal:** Eliminate the smaller but riskier non-widget cross-feature imports.

**Files:**
- Update likely callers:
  - `lib/features/home/presentation/pages/home_page.dart`
  - `lib/features/home/presentation/widgets/live_view.dart`
  - `lib/features/profile/presentation/widgets/user_dynamic_tab.dart`
  - `lib/features/search/presentation/widgets/items/search_topic_item.dart`
- Update callee seams as needed:
  - route entry files under `lib/features/**/route_entry.dart`
  - feature scopes or small core contracts

- [ ] Replace direct page imports with router-facing callbacks or `route_entry.dart` seams.
- [ ] Replace direct foreign view-model imports with feature-scope injected callbacks, providers, or core-owned contracts.
- [ ] Document any intentional exception that truly cannot be removed in this phase.

**Verification**

```bash
flutter test test/architecture/cross_feature_presentation_guard_test.dart
flutter analyze
```

---

## Part D: Fix Workflow and Platform Boundary Leaks

### Task 9: Move notification chat commands into `application/`

**Goal:** Restore the rule that command orchestration belongs in `application/`.

**Files:**
- Create:
  - `lib/features/notification/application/chat_command_workflow.dart`
  - `lib/features/notification/application/notification_application.dart` if a local barrel helps
- Update:
  - `lib/features/notification/presentation/chat_page_commands.dart`
  - `lib/features/notification/feature_scope.dart`
  - any consumers of `chatPageCommandWorkflowProvider`

- [ ] Create a real `application/` seam for notification.
- [ ] Move command workflow types/providers there.
- [ ] Leave the presentation layer responsible only for UI state gathering and invocation.
- [ ] If notification still feels too broad after the move, split follow-up responsibilities by `activity`, `private_chat`, and local store sync seams instead of growing one mega slice.
- [ ] Delete or reduce the old presentation-side command file once the move is complete.

**Verification**

```bash
flutter test test/architecture/phase3_workflow_ownership_guard_test.dart
flutter analyze
```

### Task 10: Remove `dart:io` and `File` from the dynamic domain contract

**Goal:** Stop platform-specific file types at the domain boundary.

**Files:**
- Create or update:
  - `lib/features/dynamic/application/**`
  - `lib/features/dynamic/domain/repositories/dynamic_repository.dart`
  - `lib/features/dynamic/data/dynamic_repository_impl.dart`
  - `lib/features/dynamic/data/dynamic_api.dart`
  - `lib/features/dynamic/presentation/view_models/publish_dynamic_view_model.dart`
  - `lib/features/dynamic/presentation/pages/publish_dynamic_page.dart`
  - `lib/features/dynamic/presentation/widgets/publish_dynamic_image_grid.dart`

- [ ] Introduce an app-level upload payload/value object that the domain can talk about without importing `dart:io`.
- [ ] Keep `File` handling in presentation or data implementation only.
- [ ] Update upload APIs and publish flow accordingly.

**Verification**

```bash
flutter analyze
rg -n \"import 'dart:io';\" lib/features/dynamic/domain
```

---

## Part E: Final Verification and Closeout

### Task 11: Run the architecture gate suite and repo-wide verification

**Goal:** Prove the cleanup did not only move code around, but actually enforced the intended boundaries.

**Verification**

```bash
flutter test test/architecture
flutter analyze
flutter test
```

- [ ] Record the post-refactor cross-feature import count.
- [ ] Record whether any exceptions remain in the cross-feature presentation guard allowlist.
- [ ] If the phase is fully complete, move the active Phase 8 docs to `.completed.md` archive paths and update `architecture-guide.md`.
