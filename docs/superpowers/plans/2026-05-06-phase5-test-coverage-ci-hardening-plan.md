# Phase 5: Test Coverage & CI Hardening — Implementation Plan

**Spec:** `docs/superpowers/specs/2026-05-06-phase5-test-coverage-ci-hardening-design.md`
**Date:** 2026-05-06

## Execution Order

Work proceeds in dependency order: core tests first (no blockers), then features, then CI gate.

### Step 1: core/utils/ tests

**Files to create:**
- `test/core/utils/formatters_test.dart`
- `test/core/utils/crypto_test.dart`
- `test/core/utils/validators_test.dart`

**Approach:** Pure function tests. Read each file in `lib/core/utils/`, identify testable functions, write unit tests with known inputs/outputs.

**Verify:** `flutter test test/core/utils/`

---

### Step 2: core/errors + core/session + core/contracts tests

**Files to create:**
- `test/core/errors/error_handler_test.dart`
- `test/core/session/token_refresh_test.dart`
- `test/core/contracts/dto_serialization_test.dart`

**Approach:** Test error handler behavior (error types, message formatting). Test token refresh flow with mocked HTTP. Test contract DTOs round-trip serialization.

**Verify:** `flutter test test/core/`

---

### Step 3: history feature tests

**Files to create:**
- `test/features/history/history_repository_test.dart`
- `test/features/history/history_dto_mapper_test.dart`
- `test/features/history/history_view_model_test.dart`

**Approach:** Mock API client, test repository returns correct domain models. Test mapper converts DTOs correctly. Test ViewModel state transitions.

**Verify:** `flutter test test/features/history/`

---

### Step 4: ranking feature tests

**Files to create:**
- `test/features/ranking/ranking_api_test.dart`
- `test/features/ranking/ranking_repository_test.dart`
- `test/features/ranking/ranking_dto_mapper_test.dart`
- `test/features/ranking/ranking_view_model_test.dart`

**Approach:** Same pattern as history.

**Verify:** `flutter test test/features/ranking/`

---

### Step 5: to_view feature tests

**Files to create:**
- `test/features/to_view/to_view_commands_test.dart`
- `test/features/to_view/to_view_repository_test.dart`
- `test/features/to_view/to_view_dto_mapper_test.dart`
- `test/features/to_view/to_view_view_model_test.dart`

**Approach:** Same pattern as history.

**Verify:** `flutter test test/features/to_view/`

---

### Step 6: auth data layer tests

**Files to create:**
- `test/features/auth/auth_repository_test.dart`

**Approach:** Mock API, test login/logout/token-storage flows.

**Verify:** `flutter test test/features/auth/`

---

### Step 7: CI coverage threshold gate

**File to edit:** `.github/workflows/ci.yml`

**Change:** Add coverage threshold check step after `flutter test --coverage`. Fail build if coverage < 18%.

**Verify:** `make ci` locally, push to branch and verify Actions pass.

---

### Step 8: Architecture guard for bootstrap

**File to create:** `test/architecture/bootstrap_provider_structure_test.dart`

**Approach:** Verify `core/bootstrap/providers/` files only contain `@Riverpod` annotated stubs. Verify no concrete implementations leak in.

**Verify:** `flutter test test/architecture/`

---

## Dependencies

```
Step 1 (core/utils) ──┐
Step 2 (core/other) ──┤
                       ├── Step 7 (CI gate) — needs coverage baseline
Step 3 (history) ─────┤
Step 4 (ranking) ─────┤
Step 5 (to_view) ─────┤
Step 6 (auth) ────────┘
Step 8 (bootstrap guard) — independent
```

Steps 1-6 are independent of each other and can be parallelized. Step 7 should come after coverage rises. Step 8 is independent.

## Estimated Coverage Impact

| Step | New test files | Estimated coverage gain |
|------|---------------|------------------------|
| 1. core/utils/ | 3 | +0.5% |
| 2. core/errors+session+contracts | 3 | +0.3% |
| 3. history | 3 | +0.3% |
| 4. ranking | 4 | +0.4% |
| 5. to_view | 4 | +0.3% |
| 6. auth | 1 | +0.2% |
| **Total** | **18** | **~2%** (18% → ~20%) |

## Exit Criteria

- [ ] All 234 existing tests still pass
- [ ] ~18 new test files created
- [ ] Coverage rises to ~20%+
- [ ] CI fails if coverage drops below 18%
- [ ] Architecture guard for bootstrap/ passes
- [ ] `make ci` passes locally
