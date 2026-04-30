> Completed on 2026-04-30 after the shared-provider infra ownership slice landed on `master`.
> Closeout evidence: `flutter test test/shared/network/wbi_helper_provider_test.dart --reporter compact`, `flutter test test/architecture/shared_provider_infra_ownership_guard_test.dart --reporter compact`, `flutter test test/architecture/provider_bootstrap_ownership_guard_test.dart --reporter compact`, `flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact`, and `flutter analyze`.
> No new active design surface is open.

# Culcul Shared Provider Infra Ownership Reassessment Design

**Date:** 2026-04-28

**Scope:** Define the next bounded architecture slice after provider/bootstrap ownership normalization by reassessing the last remaining `lib/shared/providers/**` entry, `wbi_provider.dart`, and deciding whether it belongs under network-owned infra instead of `shared`.

## Problem Summary

The previous provider/bootstrap slice retired every bootstrap-owned `shared/providers/**` file except `lib/shared/providers/wbi_provider.dart`.

That leaves the codebase in an awkward state:

- `lib/shared/providers/**` still exists, but only for one file
- the remaining file is consumed by `lib/shared/network/interceptors/wbi_interceptor.dart`
- the helper itself depends on `lib/shared/network/resource_api.dart` and `lib/shared/network/resource_api_provider.dart`
- the current folder name implies a broad shared utility, but the actual ownership looks network-local and infrastructure-oriented

The next slice should be small, verification-heavy, and should not reopen the broader phase-2/phase-3 workflow boundary cleanup.

## Current Evidence

### Remaining `shared/providers/**` surface

- `lib/shared/providers/wbi_provider.dart` is now the only file left under `lib/shared/providers/`
- the archived closeout docs already call this out as the next bounded follow-up

### Actual dependency shape

- `WbiInterceptor` is the only production consumer that directly imports `package:culcul/shared/providers/wbi_provider.dart`
- `WbiHelper` reads `basicResourceApiProvider`, which already lives under `lib/shared/network/resource_api_provider.dart`
- `WbiHelper` exists only to fetch nav keys and sign WBI requests for the Dio pipeline

### Existing architecture guard posture

- `test/architecture/provider_bootstrap_ownership_guard_test.dart` already blocks the retired bootstrap-owned `shared/providers/**` paths
- `test/architecture/phase3_legacy_import_paths_test.dart` already blocks other retired shared paths
- no guard currently prevents new imports of `package:culcul/shared/providers/wbi_provider.dart`

## Approaches

### Option A: Move WBI ownership into `shared/network`

Move the canonical helper/provider home to a network-owned path, for example:

- `lib/shared/network/providers/wbi_helper_provider.dart`

Characteristics:

- matches the current consumer and dependency graph
- empties `lib/shared/providers/**` entirely
- keeps the change narrow and local to network infra

Risk:

- requires a new focused architecture guard and at least one behavior-preserving test so the move does not become a pure file shuffle with no safety net

### Option B: Keep `wbi_provider.dart` in `shared/providers`

Treat WBI signing as a long-lived shared concern and stop the cleanup here.

Characteristics:

- smallest immediate code diff
- avoids moving files now

Risk:

- leaves the architecture story inconsistent
- preserves a misleading folder that now communicates the wrong ownership boundary

### Option C: Expand into a broad network/infra re-home

Use `wbi_provider` as the start of a larger reorganization across `shared/network/**`.

Characteristics:

- could produce a cleaner long-term infra layout

Risk:

- too large for the next slice
- likely to collide with unrelated networking work and generate avoidable churn

## Recommendation

Use **Option A**.

This is the smallest slice that:

- finishes the `shared/providers/**` cleanup story
- aligns ownership with the real consumer and dependency graph
- adds a durable guard so the old path does not return

## Approved Design

### 1. Canonical WBI helper ownership moves under `lib/shared/network/**`

Create a network-owned canonical home for the WBI helper/provider:

- preferred path: `lib/shared/network/providers/wbi_helper_provider.dart`

The file should continue to expose:

- `class WbiHelper`
- `final wbiHelperProvider`

The implementation should remain behaviorally unchanged:

- same nav fetch source (`basicResourceApiProvider`)
- same one-hour key refresh window
- same WBI signing algorithm
- same reserved-character stripping and `wts` / `w_rid` generation

### 2. Migrate consumers first, then retire the shared path

Migration order matters:

1. add the new canonical file
2. update `lib/shared/network/interceptors/wbi_interceptor.dart` to import the canonical path
3. only after production imports are moved, remove `lib/shared/providers/wbi_provider.dart`

Do not leave a long-lived compatibility export unless validation shows a short transitional shim is necessary inside the same branch.

### 3. Add narrow tests before tightening architecture guards

The slice should add targeted coverage for the moved behavior:

- a helper-level test that exercises key update plus request signing, or
- an interceptor-level test that proves WBI signing still happens when `requires_wbi` is set

After the canonical import path is live, add a dedicated architecture guard that fails on production imports or exports of:

- `package:culcul/shared/providers/wbi_provider.dart`

### 4. Update docs only after the code move is real

After imports are migrated and the old file is removed:

- update `docs/architecture/shared-boundary-rules.md`
- update `docs/architecture/phase3-structural-normalization-rules.md`

The docs should explicitly say that `lib/shared/providers/**` is retired and that WBI signing ownership is network-local.

## Constraints

- do not redesign WBI signing behavior, TTL, or fallback strategy in this slice
- do not move unrelated interceptors or `resource_api*` files unless the WBI move requires it
- do not reopen provider/bootstrap ownership files already normalized under `lib/core/bootstrap/providers/**`
- keep generated-file churn to zero unless a test or provider change truly requires regeneration

## Worktree Strategy

- use a dedicated worktree under `.worktrees/`
- branch name should describe the ownership move, for example `refactor/wbi-provider-ownership`

## Validation Expectations

Minimum validation for the execution phase:

- `flutter test test/architecture/provider_bootstrap_ownership_guard_test.dart --reporter compact`
- `flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact`
- the new WBI-focused test file
- `flutter analyze`

## Out of Scope

- broader `shared/network/**` package redesign
- refactoring non-WBI interceptors
- changing `ResourceApi` contracts
- introducing a new global infra layer outside the existing package structure
