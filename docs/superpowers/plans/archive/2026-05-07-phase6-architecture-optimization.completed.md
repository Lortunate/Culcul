# Phase 6: Architecture Optimization & Code Quality — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Spec:** `docs/superpowers/specs/2026-05-07-phase6-architecture-optimization-design.md`
**Date:** 2026-05-07

## Execution Order

Documentation first (no code risk), then feature normalization (low risk), then lint tightening (medium risk).

---

## Part A: Documentation Reconciliation

### Task 1: Reconcile CLAUDE.md and AGENTS.md

**Files:**
- Modify: `CLAUDE.md`
- Modify: `AGENTS.md`

- [ ] **Step 1: Merge AGENTS.md beads detail into CLAUDE.md**

Read both files. AGENTS.md has a `profile:full` beads section with detailed issue types, priorities, workflow for AI agents, quality fields, lifecycle commands, and auto-sync details. CLAUDE.md has a `profile:minimal` version.

Merge the detailed beads reference from AGENTS.md into CLAUDE.md's "Beads Issue Tracker" section. Keep the detailed version as the single source of truth.

- [ ] **Step 2: Replace AGENTS.md with pointer**

Replace AGENTS.md content with a thin pointer:

```markdown
# Agent Instructions

See [CLAUDE.md](CLAUDE.md) for all project instructions, architecture rules, and workflow protocols.
```

- [ ] **Step 3: Verify**

Confirm CLAUDE.md has all content from both files. Confirm AGENTS.md is just a pointer.

- [ ] **Step 4: Commit**

```bash
git add CLAUDE.md AGENTS.md
git commit -m "docs: reconcile CLAUDE.md and AGENTS.md into single source of truth"
```

---

### Task 2: Update Architecture Guide

**Files:**
- Modify: `docs/architecture/architecture-guide.md`

- [ ] **Step 1: Update phase history**

Change the "Phase 5 (Current)" section to mark it complete. Add Phase 6 as current:

```markdown
## Phase 5 (Complete): Test Coverage & CI Hardening

Completed 2026-05-07. 270+ tests added, coverage at ~20%, CI coverage gate active.

Archived spec: `docs/superpowers/specs/archive/2026-05-06-phase5-test-coverage-ci-hardening-design.completed.md`
Archived plan: `docs/superpowers/plans/archive/2026-05-06-phase5-test-coverage-ci-hardening-plan.completed.md`

## Phase 6 (Current): Architecture Optimization & Code Quality

Spec: `docs/superpowers/specs/2026-05-07-phase6-architecture-optimization-design.md`
Plan: `docs/superpowers/plans/2026-05-07-phase6-architecture-optimization.md`

1. Feature structure normalization (5 non-compliant features)
2. Documentation reconciliation (CLAUDE.md/AGENTS.md)
3. Lint tightening (avoid_print, unawaited_futures)
4. Barrel export standardization
```

Also add a "Performance Optimization" completed entry:

```markdown
## Performance Optimization (Complete)

Completed 2026-05-07. Anti-pattern fixes, list rendering optimization, media pipeline optimization.

Archived spec: `docs/superpowers/specs/archive/2026-05-07-performance-optimization-design.completed.md`
Archived plan: `docs/superpowers/plans/archive/2026-05-07-performance-optimization.completed.md`
```

- [ ] **Step 2: Add feature structure compliance matrix**

Add a new section after "Feature Structure":

```markdown
### Feature Structure Compliance

| Feature | route_entry | feature_scope | application/ | data/ | domain/ | presentation/ | barrel | Status |
|---------|:-----------:|:------------:|:------------:|:-----:|:-------:|:-------------:|:------:|:------:|
| auth    | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| dynamic | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| favorites | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| history | ✓ | ✓ | — | ✓ | — | ✓ | ✓ | PARTIAL |
| home    | ✓ | — | — | ✓ | — | ✓ | — | PARTIAL |
| live    | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| notification | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| profile | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| ranking | ✓ | ✓ | — | ✓ | — | ✓ | ✓ | PARTIAL |
| search  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| settings | ✓ | ✓ | — | ✓ | — | ✓ | ✓ | PARTIAL |
| to_view | ✓ | ✓ | — | ✓ | — | ✓ | ✓ | PARTIAL |
| video   | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |

**Legend:** ✓ = present, — = missing
```

- [ ] **Step 3: Add barrel export convention**

Add to the "Feature Structure" section:

```markdown
### Barrel Exports

Each feature exposes a `<feature>.dart` barrel file at its root. This is the public API surface for the feature. Other features must NOT import internal files directly — use the barrel export.

Example: `import 'package:culcul/features/auth/auth.dart';`
```

- [ ] **Step 4: Commit**

```bash
git add docs/architecture/architecture-guide.md
git commit -m "docs: update architecture guide for Phase 6, add compliance matrix"
```

---

## Part B: Feature Structure Normalization

### Task 3: Normalize home feature

**Files:**
- Create: `lib/features/home/home.dart`
- Create: `lib/features/home/feature_scope.dart`
- Create: `lib/features/home/domain/repositories/home_repository.dart`
- Possibly create: `lib/features/home/application/` (depends on analysis)

- [ ] **Step 1: Analyze home feature**

Read all files in `lib/features/home/`. Identify:
- What repository interfaces exist in `data/` that should be in `domain/`
- What orchestration logic exists in `presentation/` that should be in `application/`
- What public API the barrel export should expose

- [ ] **Step 2: Create domain/ layer**

Create `lib/features/home/domain/repositories/home_repository.dart` with the repository interface (abstract class). Move the interface from `data/` if it exists there.

- [ ] **Step 3: Create feature_scope.dart**

Create `lib/features/home/feature_scope.dart` following the pattern from other features (e.g., `auth/feature_scope.dart`).

- [ ] **Step 4: Create home.dart barrel export**

Create `lib/features/home/home.dart` that exports the public API:
- `route_entry.dart`
- `feature_scope.dart`
- Any public widgets/pages needed by the router

- [ ] **Step 5: Assess application/ layer**

If orchestration logic exists in presentation widgets (e.g., multi-step workflows, login gating), create `application/` with a workflow class. If the feature is simple (just display + fetch), skip this — don't add empty layers.

- [ ] **Step 6: Verify**

Run: `flutter analyze lib/features/home/`
Expected: No errors

- [ ] **Step 7: Commit**

```bash
git add lib/features/home/
git commit -m "feat(home): normalize feature structure — add domain, feature_scope, barrel export"
```

---

### Task 4: Normalize history, ranking, to_view, settings features

These four features all have the same gap: missing `application/` and `domain/` layers. They are simpler features (CRUD + display), so the normalization is lighter.

**Files (per feature):**
- Create: `lib/features/<name>/domain/repositories/<name>_repository.dart`
- Assess: `lib/features/<name>/application/` (only if orchestration exists)

- [ ] **Step 1: Analyze all four features**

For each of history, ranking, to_view, settings:
- Read `data/repositories/` to find the repository implementation
- Identify the abstract interface (should be in `domain/`)
- Check presentation layer for orchestration logic

- [ ] **Step 2: Create domain/ for history**

Create `lib/features/history/domain/repositories/history_repository.dart` with the abstract interface. Update `data/repositories/history_repository_impl.dart` to import from domain.

- [ ] **Step 3: Create domain/ for ranking**

Same pattern as history.

- [ ] **Step 4: Create domain/ for to_view**

Same pattern as history.

- [ ] **Step 5: Create domain/ for settings**

Same pattern as history. Note: settings may not have a repository — check if it uses local storage directly. If so, create a `domain/repositories/settings_repository.dart` interface for the storage contract.

- [ ] **Step 6: Assess application/ for each**

Only create `application/` if orchestration logic exists in presentation. Simple CRUD features don't need it.

- [ ] **Step 7: Verify**

Run: `flutter analyze lib/features/history/ lib/features/ranking/ lib/features/to_view/ lib/features/settings/`
Expected: No errors

- [ ] **Step 8: Run tests**

Run: `flutter test`
Expected: All tests pass (domain layer is just interface extraction, no behavior change)

- [ ] **Step 9: Commit**

```bash
git add lib/features/history/ lib/features/ranking/ lib/features/to_view/ lib/features/settings/
git commit -m "feat: add domain layer to history, ranking, to_view, settings features"
```

---

## Part C: Lint & Code Quality

### Task 5: Tighten analysis_options.yaml

**Files:**
- Modify: `analysis_options.yaml`

- [ ] **Step 1: Enable avoid_print**

Change `avoid_print: false` to `avoid_print: true`.

First, scan for `print()` usage in non-test code:
```bash
grep -rn "print(" lib/ --include="*.dart" | grep -v "\.g\.dart" | grep -v "\.freezed\.dart" | grep -v "test/"
```

If print() is used, replace with proper logging (e.g., `debugPrint()` or a logger). `debugPrint()` is throttled and won't be caught by `avoid_print` — actually it will. Use `log()` from `dart:developer` or a logging package.

Actually, `avoid_print` only catches `print()`. `debugPrint()` is fine. Check what's actually used.

- [ ] **Step 2: Add unawaited_futures**

Add to the analyzer section:
```yaml
analyzer:
  errors:
    unawaited_futures: warning
```

This catches missing `await` on Futures, which can cause silent bugs.

- [ ] **Step 3: Run analysis**

Run: `flutter analyze`
Expected: Any new warnings are addressed (either fix the code or suppress with justification)

- [ ] **Step 4: Commit**

```bash
git add analysis_options.yaml
git commit -m "chore: tighten lint rules — enable avoid_print, add unawaited_futures warning"
```

---

### Task 6: Add barrel exports to core modules

**Files:**
- Create: `lib/core/utils/core_utils.dart`
- Possibly create barrel exports for other core modules

- [ ] **Step 1: Create core/utils barrel export**

Create `lib/core/utils/core_utils.dart` that re-exports all utility files:
```dart
export 'crypto_utils.dart';
export 'format_utils.dart';
export 'id_utils.dart';
export 'json_compute.dart';
export 'list_utils.dart';
export 'share_utils.dart';
export 'toast_utils.dart';
export 'validation_utils.dart';
// danmaku_mask_parser.dart is feature-specific, skip
```

- [ ] **Step 2: Assess other core modules**

Check which core modules lack barrel exports. Create them if the module has 3+ files.

- [ ] **Step 3: Verify**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 4: Commit**

```bash
git add lib/core/utils/core_utils.dart
git commit -m "chore: add barrel export for core/utils"
```

---

## Part D: Verification

### Task 7: Full verification

- [ ] **Step 1: Run full analysis**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 2: Run full test suite**

Run: `flutter test`
Expected: All tests pass

- [ ] **Step 3: Run architecture guards**

Run: `flutter test test/architecture/`
Expected: All architecture boundary tests pass

- [ ] **Step 4: Run CI pipeline**

Run: `make ci`
Expected: format-check + analyze + test all pass

- [ ] **Step 5: Update architecture guide compliance matrix**

After feature normalization, update the compliance matrix in `architecture-guide.md` to reflect the new state (all features should be closer to FULL).

- [ ] **Step 6: Final commit**

```bash
git add docs/architecture/architecture-guide.md
git commit -m "docs: update compliance matrix after Phase 6 normalization"
```

---

## Dependencies

```
Task 1 (CLAUDE.md/AGENTS.md) ──┐
Task 2 (architecture guide) ────┤
                                ├── Task 7 (verification)
Task 3 (home normalization) ────┤
Task 4 (other features) ────────┤
Task 5 (lint tightening) ───────┤
Task 6 (barrel exports) ────────┘
```

Tasks 1-6 are independent and can be parallelized. Task 7 depends on all others.

## Exit Criteria

- [ ] CLAUDE.md is single source of truth, AGENTS.md is pointer
- [ ] Architecture guide reflects Phase 6, has compliance matrix
- [ ] home feature has feature_scope.dart, barrel export, domain/
- [ ] history, ranking, to_view, settings have domain/ layer
- [ ] analysis_options.yaml has avoid_print: true, unawaited_futures: warning
- [ ] core/utils/ has barrel export
- [ ] `make ci` passes
- [ ] All tests pass
