> Completed on 2026-04-24 after the repo audit confirmed the original three-phase architecture cleanup line had landed.
> Closeout evidence: `flutter test test/architecture/shared_boundary_guard_test.dart --reporter compact`, `flutter test test/architecture/phase3_workflow_ownership_guard_test.dart --reporter compact`, `flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact`, and `flutter analyze`.
> The next active design surface is `docs/superpowers/specs/2026-04-24-provider-bootstrap-ownership-normalization-design.md`.

# Culcul Architecture Boundary Cleanup Design

**Date:** 2026-04-17

**Scope:** Define a low-risk, phased architecture cleanup for the Flutter codebase without colliding with the current uncommitted `home` refactor.

## Problem Summary

The main issue is not naming or folder aesthetics. The real problem is that architectural boundaries are already broken:

- `lib/app` and `lib/shared` directly depend on business features.
- `presentation` pages and some shared widgets directly orchestrate feature commands.
- routing is centralized and compiles against nearly every feature.
- feature layering is inconsistent across modules.

This creates high coupling, weak reuse boundaries, and makes future refactors expensive.

## Current Evidence

### Boundary violations

- [`lib/app/router/app_routes.dart`](/E:/Projects/Flutter/Culcul/lib/app/router/app_routes.dart) imports 14 feature entry points/pages directly.
- [`lib/shared/network/interceptors/token_interceptor.dart`](/E:/Projects/Flutter/Culcul/lib/shared/network/interceptors/token_interceptor.dart) depends on `auth`.
- [`lib/shared/widgets/follow_button.dart`](/E:/Projects/Flutter/Culcul/lib/shared/widgets/follow_button.dart) reads `authProvider` and pushes `/login`.
- [`lib/shared/widgets/video_actions_bottom_sheet.dart`](/E:/Projects/Flutter/Culcul/lib/shared/widgets/video_actions_bottom_sheet.dart) directly drives `toViewListProvider.notifier`.

### Heavy presentation orchestration

- [`lib/features/dynamic/presentation/pages/dynamic_detail_page.dart`](/E:/Projects/Flutter/Culcul/lib/features/dynamic/presentation/pages/dynamic_detail_page.dart) directly coordinates detail state, comment actions, refresh, and reply submission.
- `notification`, `video`, `dynamic`, and `profile` have the densest cross-feature import pressure.

### Structural inconsistency

- Top-level structure is effectively `app / features / i18n / protos / shared`.
- `shared` has become a catch-all for infra, contracts, theming, responsive helpers, hooks, and reusable widgets.
- only some features use `application`; some have `domain`; some are effectively page-first modules.

## Approaches

### Option A: Boundary cleanup first

Do a narrow first phase that removes `shared -> features` and reduces UI-side business orchestration before any large folder moves.

**Pros**
- Lowest risk while the current branch is dirty
- Directly addresses the worst coupling
- Creates a safe foundation for later folder and route cleanup

**Cons**
- Directory structure remains imperfect in phase 1
- Some duplicated adapters may exist temporarily

### Option B: Route-first cleanup

Start by decentralizing route definitions and reducing `app_routes` imports.

**Pros**
- Improves navigation ownership early
- Makes feature composition cleaner

**Cons**
- Does not solve `shared` boundary leaks
- Higher integration risk while `home` routing is already changing

### Option C: Big shared split first

Immediately split `shared` into `core` and `ui`, then repair imports afterward.

**Pros**
- Produces a cleaner directory tree quickly
- Strong visible architectural change

**Cons**
- Highest churn
- Very likely to collide with existing user changes
- Difficult to validate incrementally

## Recommendation

Use **Option A** first.

The first phase should optimize for boundary repair, not tree reshaping. Once the illegal dependencies are gone, the later `shared -> core/ui` split becomes much safer and much more mechanical.

## Approved Design

### Phase 1: Boundary repair only

Goal: remove the most damaging reverse dependencies and stop shared UI from owning feature behavior.

#### 1. Shared/network must not depend on auth feature

Target:
- [`lib/shared/network/interceptors/token_interceptor.dart`](/E:/Projects/Flutter/Culcul/lib/shared/network/interceptors/token_interceptor.dart)

Design:
- move token/session access behind a stable session-facing abstraction that lives outside `features/auth`
- `auth` can implement or provide that abstraction, but `shared/network` must only depend on the abstraction/provider boundary

Expected outcome:
- network infra no longer imports `features/auth`

#### 2. Shared widgets must become UI-only

Targets:
- [`lib/shared/widgets/follow_button.dart`](/E:/Projects/Flutter/Culcul/lib/shared/widgets/follow_button.dart)
- [`lib/shared/widgets/video_actions_bottom_sheet.dart`](/E:/Projects/Flutter/Culcul/lib/shared/widgets/video_actions_bottom_sheet.dart)

Design:
- shared widgets may render state and emit callbacks
- feature-specific command execution, login gating, navigation, toast/snackbar decisions, and provider writes move back to feature/application/controller layers

Expected outcome:
- shared widgets expose callbacks or small state objects instead of reading feature providers directly

#### 3. Freeze large route changes in phase 1

Target:
- [`lib/app/router/app_routes.dart`](/E:/Projects/Flutter/Culcul/lib/app/router/app_routes.dart)

Design:
- do not redesign the routing system in phase 1
- allow the current centralized route graph to remain, but avoid increasing direct page-level coupling
- route cleanup becomes phase 2 or 3 after boundary repair

Expected outcome:
- no extra routing churn while `home` changes are in flight

### Phase 2: Move command orchestration out of pages

Targets:
- `dynamic_detail_page`
- heavy action pages in `video`, `notification`, `live`, and `favorites`

Design:
- pages should mostly watch state and invoke higher-level commands
- command sequencing, mutation branching, and feature workflows move into explicit controller/notifier/application units
- naming should become consistent: use one primary pattern per feature for mutable presentation logic

Expected outcome:
- less page bloat
- better testability
- clearer UI vs command boundaries

### Phase 3: Structural normalization

Design:
- split `shared` into clearer long-term ownership areas
- likely target shape:
  - `lib/core` for infra and cross-cutting technical primitives
  - `lib/ui` for design system, reusable UI primitives, responsive/theme helpers
  - `lib/features/*` for business modules
- only do this after phase 1 and 2 reduce illegal dependency paths

Expected outcome:
- directory names reflect actual responsibility
- future refactors become cheaper

#### Phase 3 readiness note

Phase-2 follow-up on the implementation branch establishes two useful seams
without forcing a full redesign:

- routing now has an explicit feature-owned `route_entry.dart` pattern across
  the main user-facing modules
- page-heavy workflows have started moving into feature-owned helpers under
  `application/` and page-scoped `*_page_commands.dart`

That means phase 3 can focus on naming and ownership normalization rather than
re-litigating whether the extraction itself was correct.

## Constraints

- Do not overwrite or rework the current uncommitted `home` refactor unless a later task explicitly targets it.
- Do not perform a large folder migration in the current dirty workspace.
- Use a separate worktree for implementation.
- Any code refactor task must respect project `AGENTS.md`, including GitNexus impact-analysis rules where the tool is available.

## Worktree Strategy

Implementation should not start on the current `master` working tree.

Recommended setup:
- create a dedicated worktree for this architecture cleanup line
- keep the current dirty workspace untouched
- branch name should reflect the first phase, for example `refactor/boundary-cleanup-phase1`

## Parallelization Strategy

Phase 1 can be split into independent execution tasks after planning:

1. session/network boundary cleanup
2. shared widget cleanup for follow/login boundary
3. shared widget cleanup for video actions boundary

These can run in parallel if they own disjoint files and converge only at review.

## Validation Expectations

- targeted widget and unit tests for touched files
- `flutter analyze`
- focused regression tests for auth/session-sensitive flows
- review of import directions to confirm `shared -> features` removals

## Out of Scope

- full route system redesign
- whole-repo folder migration
- standardizing every feature module in one pass
- rewriting the ongoing `home` refactor
