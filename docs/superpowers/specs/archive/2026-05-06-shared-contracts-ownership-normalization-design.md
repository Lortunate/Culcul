# Culcul Shared Contracts Ownership Normalization Design

## Problem Summary

Phase 3 now documents `lib/core/**` as the canonical home for infrastructure and
stable shared contracts, while `lib/shared/**` is only a compatibility layer.
After the perf ownership slice landed, `lib/shared/contracts/**` remains one of
the largest unresolved ownership buckets. These contract types are consumed
widely across repositories, widgets, DTO mappers, and tests, but they still
present as canonical `shared` imports instead of a `core`-owned stable surface.

The next refactor slice should normalize contract ownership without broadening
into network, widgets, or pagination moves.

## Current Evidence

### Remaining `shared/contracts/**` surface

Canonical contract files still live under `lib/shared/contracts/**`:

- `comment_contract.dart`
- `live_room_summary_contract.dart`
- `relation_user_contract.dart`
- `search_result_contract.dart`
- `user_card_contract.dart`
- `video_model_contract.dart`

Generated companions also live there:

- `*.freezed.dart`
- `*.g.dart`
- `comment_contract.types.dart`

### Import surface

`package:culcul/shared/contracts/...` is still used by:

- feature presentation and view-model layers
- feature repositories and mappers
- shared widgets
- shared network DTO tests
- feature tests

The most reused paths currently include:

- `search_result_contract.dart`
- `video_model_contract.dart`
- `comment_contract.dart`
- `live_room_summary_contract.dart`
- `user_card_contract.dart`

### Ownership fit

These files are good candidates for `lib/core/contracts/**` because they are:

- stable data contracts rather than feature workflow code
- reused across multiple features
- already isolated from feature-owned orchestration
- explicitly aligned with the phase-3 rule that stable shared contracts belong
  under `core`

### Existing rule posture

Current rules already say:

- `lib/core/**` owns stable shared contracts
- `lib/shared/**` should remain a compatibility layer during small pilots

What is missing is an actual contracts move plus a guard that blocks new
production imports of the retired shared contract paths.

## Approaches

### Option A: Move canonical contracts to `lib/core/contracts/**`, migrate imports, then retire the shared paths

Create `lib/core/contracts/**`, move the canonical hand-written contract files,
regenerate companion files in their new home, migrate all imports, and extend
the legacy import guard so old shared contract imports cannot return.

Pros:

- aligns the repo with the documented ownership model
- removes one of the largest remaining `shared/**` ownership buckets
- creates a durable guard against regression

Cons:

- touches many imports across features and tests
- requires regeneration care because some files are codegen-backed

### Option B: Keep contracts in `shared` and only add docs

This avoids churn now, but it contradicts the current phase-3 rule and leaves a
large ownership inconsistency in place.

### Option C: Expand into a combined `shared/contracts + shared/network + shared/widgets` redesign

This is too broad for the next slice. The blast radius would become too large
and the plan would stop being reviewable as a bounded architecture move.

## Recommendation

Use **Option A**.

Contracts are large enough to matter, but still more bounded than widgets or
network. The destination is already defined in docs, and the move can be
sequenced as:

1. add failing guard coverage
2. move canonical contract files
3. regenerate companions in the new home
4. migrate imports
5. remove retired shared paths

## Approved Design

### 1. `lib/core/contracts/**` becomes the canonical contracts home

Move the hand-written contract definitions from `lib/shared/contracts/**` to
`lib/core/contracts/**`.

### 2. Regenerate companion files in the new home

Because multiple contracts use Freezed / JSON serialization, the slice must
regenerate companion files after the move instead of hand-editing generated
artifacts.

### 3. Migrate production and test imports in the same slice

Update all `package:culcul/shared/contracts/...` imports to
`package:culcul/core/contracts/...`.

### 4. Add a narrow guard for retired shared contract paths

Extend `test/architecture/phase3_legacy_import_paths_test.dart` so production
imports of the retired shared contract paths fail once the working set is zero.

### 5. Retire `lib/shared/contracts/**` only after the import surface reaches zero

The slice should use `rg -n "package:culcul/shared/contracts/" lib test` as the
deletion gate. Do not delete the old path before all production and test imports
have moved.

### 6. Update architecture docs after the move is real

Document that canonical shared contracts now live under `lib/core/contracts/**`
and that `lib/shared/contracts/**` is retired.

## Constraints

- Do not redesign contract fields or serialization behavior.
- Do not bundle unrelated DTO/network redesign into this slice.
- Do not hand-edit generated files except where generation tooling requires
  checked-in updates.
- Keep the slice focused on ownership normalization and import migration.

## Worktree Strategy

Use a dedicated worktree and branch:

- worktree: `.worktrees/core-contracts-ownership`
- branch: `refactor/core-contracts-ownership`

## Validation Expectations

Minimum validation for this slice:

- `flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact`
- focused tests that cover moved contract consumers, especially search, comment,
  live, and shared widget surfaces touched by the import migration
- `flutter test test/architecture --reporter compact`
- `flutter analyze`

## Out of Scope

- shared widgets ownership redesign
- shared network ownership redesign
- pagination ownership redesign
- feature workflow extraction unrelated to contracts
