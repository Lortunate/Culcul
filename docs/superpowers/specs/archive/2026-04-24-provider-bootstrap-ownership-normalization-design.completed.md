> Completed on 2026-04-28 after the provider/bootstrap ownership implementation landed and closeout verification passed.
> Closeout evidence: `flutter test test/architecture/provider_bootstrap_ownership_guard_test.dart --reporter compact`, `flutter test test/architecture/phase3_workflow_ownership_guard_test.dart --reporter compact`, and `flutter analyze`.
> The next design surface was `docs/superpowers/specs/archive/2026-04-28-shared-provider-infra-ownership-reassessment-design.completed.md`, and it is now completed and archived.

# Culcul Provider And Bootstrap Ownership Normalization Design

**Date:** 2026-04-24

**Scope:** Define the next bounded architecture slice after phase-3 structural normalization, focusing on cross-cutting provider ownership and bootstrap wiring.

## Problem Summary

Phase 1 to Phase 3 removed the most obvious boundary violations, but one cross-cutting seam is still structurally muddy:

- bootstrap-created infrastructure still exposes its provider contracts from `lib/shared/providers/**`
- `main.dart` mixes app startup wiring with overrides that point at `shared` ownership
- dead compatibility shims from the earlier session pilot still live under `lib/shared/**` even though nothing imports them

The code is working, but the ownership story is incomplete. Cross-cutting runtime dependencies should not look like generic shared helpers once the codebase already has `lib/core/**` pilot homes.

## Current Evidence

### Bootstrap-created runtime dependencies

- [`lib/app/bootstrap/app_bootstrap.dart`](/E:/Projects/Flutter/Culcul/lib/app/bootstrap/app_bootstrap.dart) constructs:
  - `PersistCookieJar`
  - `FileCacheStore`
  - Hive-backed session/settings/search boxes
- [`lib/main.dart`](/E:/Projects/Flutter/Culcul/lib/main.dart) wires overrides for:
  - `cookieJarProvider`
  - `cacheStoreProvider`
  - `sessionStorageBoxProvider`
  - `settingsStorageBoxProvider`
  - `searchStorageBoxProvider`
  - `sessionRefreshActionProvider`

### Current shared-provider working set

- [`lib/shared/providers/cache_store_provider.dart`](/E:/Projects/Flutter/Culcul/lib/shared/providers/cache_store_provider.dart) still has 11 imports across `lib/` and `test/`.
- [`lib/shared/providers/storage_provider.dart`](/E:/Projects/Flutter/Culcul/lib/shared/providers/storage_provider.dart) still has 6 imports across bootstrap, auth, settings, search, and tests.
- [`lib/shared/providers/cookie_jar_provider.dart`](/E:/Projects/Flutter/Culcul/lib/shared/providers/cookie_jar_provider.dart) still has 4 imports across networking, dynamic, and bootstrap wiring.

### Dead compatibility shims

- [`lib/shared/providers/session_refresh_provider.dart`](/E:/Projects/Flutter/Culcul/lib/shared/providers/session_refresh_provider.dart) is a pure export of [`lib/core/session/session_refresh_provider.dart`](/E:/Projects/Flutter/Culcul/lib/core/session/session_refresh_provider.dart) and has zero live imports.
- [`lib/shared/session/session_cookie_refresher.dart`](/E:/Projects/Flutter/Culcul/lib/shared/session/session_cookie_refresher.dart) is a pure export of [`lib/core/session/session_cookie_refresher.dart`](/E:/Projects/Flutter/Culcul/lib/core/session/session_cookie_refresher.dart) and has zero live imports.

## Approaches

### Option A: Normalize provider ownership first

Move bootstrap-supplied provider contracts out of `shared` into explicit `core` homes, then migrate imports and remove dead compatibility shims.

**Pros**
- Continues the already-approved `shared -> core/ui` direction
- Small, explicit surface with measurable import counts
- Clarifies app-startup ownership without forcing broad feature rewrites

**Cons**
- Requires coordinated import migration across app, infra, features, and tests
- Needs careful guard/doc updates to avoid inventing a second provider convention

### Option B: Keep pushing page-command cleanup

Target the remaining `live_room_page_commands.dart` shape before touching provider ownership.

**Pros**
- Stays in the same UI-workflow family as phase 2/3
- Small direct call graph

**Cons**
- Lower leverage than fixing cross-cutting ownership
- Does not reduce the remaining `shared/providers` ambiguity

### Option C: Broad shared purge

Start deleting compatibility exports and barrels anywhere they look removable.

**Pros**
- Produces visible cleanup quickly
- Shrinks `shared/`

**Cons**
- Highest churn
- Easy to mix structural cleanup with unrelated internal packaging changes
- Harder to explain and validate incrementally than a provider/bootstrap seam

## Recommendation

Use **Option A**.

The remaining debt is now concentrated. Provider/bootstrap normalization is the smallest slice that materially improves the architecture story without reopening phase-2/phase-3 workflow work. It also lets the codebase delete dead session shims immediately once the stable ownership is explicit.

## Approved Design

### 1. Bootstrap-supplied provider contracts move to `lib/core/bootstrap/providers/**`

Design:
- create explicit `core` homes for bootstrap-owned provider declarations
- move:
  - cache-store provider declaration
  - cookie-jar provider declaration
  - storage-box provider declarations and storage keys
- keep creation in `app/bootstrap`, but make consumers depend on `core` provider contracts instead of `shared/providers`

Expected outcome:
- `shared/providers/**` is no longer the default home for bootstrap-owned runtime handles
- app startup and infra code point at the same ownership boundary

### 2. Session-specific contracts stay in `lib/core/session/**`

Design:
- keep the existing `core/session` ownership for:
  - `sessionRefreshActionProvider`
  - `SessionCookieRefresher`
- delete the dead `shared` compatibility shims once import scans confirm zero dependents

Expected outcome:
- the earlier session pilot becomes a fully landed migration instead of a permanent alias

### 3. Guards and docs tighten only after imports are actually migrated

Design:
- do not add a wide “ban all shared providers” guard up front
- first migrate production imports
- then add a narrow architecture test that blocks new imports of the retired `shared/providers` session/bootstrap paths
- update planning and architecture docs only after the stable homes are real

Expected outcome:
- the new rule reflects live ownership rather than aspirational folder structure

## Constraints

- Use a dedicated worktree for implementation.
- Do not widen this slice into unrelated feature cleanup.
- Respect project `AGENTS.md`, including GitNexus impact analysis before editing any code symbols.
- Keep provider naming stable unless a name is actively misleading; ownership is the main target, not API redesign.

## Worktree Strategy

Recommended setup:
- create a dedicated worktree for this provider/bootstrap slice
- keep the root workspace untouched
- branch name should describe the ownership move, for example `refactor/provider-bootstrap-ownership`

## Parallelization Strategy

This slice can be executed as three mostly independent tasks after planning:

1. move provider declarations and migrate imports
2. delete dead session compatibility shims
3. add guard/doc tightening after the imports settle

These should still merge through one worktree because they touch the same planning surface.

## Validation Expectations

- focused unit tests for touched provider consumers
- architecture test proving retired provider paths are no longer imported in production
- `flutter analyze`
- explicit import scans before and after the move

## Out of Scope

- full `shared/` deletion
- router redesign
- broad feature-local barrel cleanup
- redesigning the live-room workflow helpers in the same slice
