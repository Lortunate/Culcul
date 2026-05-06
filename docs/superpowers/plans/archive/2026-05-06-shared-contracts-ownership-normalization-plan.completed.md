# Shared Contracts Ownership Normalization Implementation Plan

**Goal:** Move canonical stable contracts from `lib/shared/contracts/**` to
`lib/core/contracts/**`, regenerate companion files in the new home, migrate all
repo imports, retire the old shared contract paths, and tighten architecture
rules so they cannot return.

**Architecture:** Keep this slice narrow. Contracts are stable shared data
surfaces and belong under `lib/core/**` according to the current phase-3 rules.
Do not expand into `shared/widgets`, `shared/network`, or broader model redesign.

## File Structure Map

### Plan and design docs

- Reference:
  `docs/superpowers/specs/2026-05-06-shared-contracts-ownership-normalization-design.md`
- Modify: `docs/architecture/shared-boundary-rules.md`
- Modify: `docs/architecture/phase3-structural-normalization-rules.md`

### Code files expected to change

- Create:
  `lib/core/contracts/comment_contract.dart`
- Create:
  `lib/core/contracts/live_room_summary_contract.dart`
- Create:
  `lib/core/contracts/relation_user_contract.dart`
- Create:
  `lib/core/contracts/search_result_contract.dart`
- Create:
  `lib/core/contracts/user_card_contract.dart`
- Create:
  `lib/core/contracts/video_model_contract.dart`
- Create or regenerate companion files under `lib/core/contracts/**`
- Delete legacy `lib/shared/contracts/**` files after migration
- Modify importer files across:
  - `lib/features/search/**`
  - `lib/features/home/**`
  - `lib/features/live/**`
  - `lib/features/video/**`
  - `lib/shared/widgets/**`
  - `lib/shared/network/dtos/**`
  - matching tests

### Tests

- Modify: `test/architecture/phase3_legacy_import_paths_test.dart`
- Modify touched feature/shared tests that still import
  `package:culcul/shared/contracts/...`

## Implementation Tasks

### Task 0: Prepare the worktree and baseline

**Files:**

- Reference: `.gitignore`
- Reference:
  `docs/superpowers/specs/2026-05-06-shared-contracts-ownership-normalization-design.md`

- [ ] **Step 1: Create a dedicated branch and worktree**

Run:

```bash
git worktree add .worktrees/core-contracts-ownership -b refactor/core-contracts-ownership
```

- [ ] **Step 2: Create and claim the bd task inside the worktree**

Run:

```bash
cd .worktrees/core-contracts-ownership
ISSUE_ID="$(bd create "Normalize shared contracts ownership" --description="Move canonical stable contracts from lib/shared/contracts to lib/core/contracts, regenerate companion files in the new home, migrate imports, retire the old shared paths, and tighten architecture docs/tests." -t task -p 1 --json | python -c 'import json,sys; print(json.load(sys.stdin)["id"])')"
bd update "$ISSUE_ID" --claim --json
```

- [ ] **Step 3: Record the baseline contract import surface**

Run:

```bash
rg -n "package:culcul/shared/contracts/" lib test
flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact
flutter analyze
```

- [ ] **Step 4: Run GitNexus impact analysis for the moved contract surfaces**

At minimum, run upstream impact for:

- `comment_contract.dart`
- `live_room_summary_contract.dart`
- `relation_user_contract.dart`
- `search_result_contract.dart`
- `user_card_contract.dart`
- `video_model_contract.dart`

If symbol-level analysis is unavailable, record file-level import working sets
with `rg` and proceed with targeted validation.

### Task 1: Add failing guard coverage for retired shared contract imports

**Files:**

- Modify: `test/architecture/phase3_legacy_import_paths_test.dart`

- [ ] **Step 1: Add the retired contract package paths to `_legacyImportPaths`**

Add:

- `package:culcul/shared/contracts/comment_contract.dart`
- `package:culcul/shared/contracts/live_room_summary_contract.dart`
- `package:culcul/shared/contracts/relation_user_contract.dart`
- `package:culcul/shared/contracts/search_result_contract.dart`
- `package:culcul/shared/contracts/user_card_contract.dart`
- `package:culcul/shared/contracts/video_model_contract.dart`

- [ ] **Step 2: Confirm the guard fails on the current production import surface**

Run:

```bash
flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact
```

### Task 2: Move canonical contract definitions to `lib/core/contracts/**`

**Files:**

- Create/move hand-written contract files under `lib/core/contracts/**`

- [ ] **Step 1: Move the canonical hand-written contract definitions**

Move:

- `comment_contract.dart`
- `live_room_summary_contract.dart`
- `relation_user_contract.dart`
- `search_result_contract.dart`
- `user_card_contract.dart`
- `video_model_contract.dart`

to `lib/core/contracts/**`.

- [ ] **Step 2: Update `part` / import relationships as needed for the new home**

Ensure each moved file still references its generated companions correctly from
the new directory.

### Task 3: Regenerate contract companion files in the new home

**Files:**

- Generated files under `lib/core/contracts/**`

- [ ] **Step 1: Run the repo’s code generation path**

Run the repo-local bootstrap/codegen helper if needed, then:

```bash
bash scripts/bootstrap_codegen.sh
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 2: Confirm generated companions now exist under `lib/core/contracts/**`**

Verify the moved contracts have their corresponding generated files in the new
location and that stale generated files under `lib/shared/contracts/**` are only
left temporarily until imports are migrated.

### Task 4: Migrate production and test imports to `package:culcul/core/contracts/...`

**Files:**

- Modify all importers returned by:

```bash
rg -l "package:culcul/shared/contracts/" lib test
```

- [ ] **Step 1: Update import paths in small, reviewable batches**

Prioritize:

1. `search`
2. `home` / `live`
3. `video`
4. shared widgets / shared network DTO tests
5. remaining tests

- [ ] **Step 2: Keep shrinking the working set to zero**

Re-run:

```bash
rg -n "package:culcul/shared/contracts/" lib test
```

after each batch and stop only when no importers remain.

### Task 5: Retire `lib/shared/contracts/**` and update docs

**Files:**

- Delete legacy `lib/shared/contracts/**`
- Modify:
  `docs/architecture/shared-boundary-rules.md`
- Modify:
  `docs/architecture/phase3-structural-normalization-rules.md`

- [ ] **Step 1: Delete the retired shared contract files once the working set is zero**

- [ ] **Step 2: Update docs to state that canonical contracts now live under `lib/core/contracts/**`**

- [ ] **Step 3: Re-run the guard and confirm it now passes**

Run:

```bash
flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact
```

### Task 6: Validate and land the slice

- [ ] **Step 1: Run focused tests for touched contract consumers**

Use the actual touched working set to choose focused tests. At minimum include
search/live/comment/widget surfaces affected by the migration.

- [ ] **Step 2: Run full architecture checks**

```bash
flutter test test/architecture --reporter compact
```

- [ ] **Step 3: Run analyzer**

```bash
flutter analyze
```

- [ ] **Step 4: Review the final diff**

```bash
git diff --stat
```

Confirm the slice stays inside contract ownership normalization, companion-file
regeneration, import migration, and architecture docs/tests.

## Commit Strategy

- Commit 1: failing contract-path guard coverage
- Commit 2: move canonical contracts and regenerate companions
- Commit 3: migrate production/test imports and remove `lib/shared/contracts/**`
- Commit 4: docs and final cleanup
