# Phase 5: Test Coverage & CI Hardening

**Status:** DRAFT
**Date:** 2026-05-06
**Goal:** Raise test coverage from 18% toward 30%+, add CI coverage gate, and close zero-coverage gaps.

## Context

Phase 4 CI/CD is complete: GitHub Actions pipeline, Makefile, and coverage artifact upload are all working. 234 tests pass. However:

- **Overall coverage is 18%** (5,972 / 31,900 lines)
- **3 features have zero tests**: history (12 files), ranking (16 files), to_view (15 files)
- **2 features have only 1 test file**: auth (30 source files), settings (14 source files)
- **Core modules are undertested**: core/utils/ (12 pure-function files), core/errors, core/session, core/contracts
- **CI has no coverage threshold** — a commit dropping coverage to 0% would still pass
- **No architecture guard for bootstrap/ paths** — `core/bootstrap/providers/` is not in the test suite

## Design

### 1. Zero-Coverage Feature Tests (P2)

Target the three untested features. Focus on **data layer** (repositories, mappers, DTOs) and **view models** — these are testable without widget rendering.

**history** (12 source files):
- Repository tests: `history_repository_impl.dart`
- Mapper tests: `history_dto_mapper.dart`
- ViewModel tests: `history_view_model.dart`

**ranking** (16 source files):
- API client tests: `ranking_api.dart`
- Repository tests: `ranking_repository_impl.dart`
- Mapper tests: `ranking_dto_mapper.dart`
- ViewModel tests: `ranking_view_model.dart`

**to_view** (15 source files):
- Command tests: `to_view_commands.dart`
- Repository tests: `to_view_repository_impl.dart`
- Mapper tests: `to_view_dto_mapper.dart`
- ViewModel tests: `to_view_view_model.dart`

### 2. Core Module Tests (P2)

**core/utils/** (12 pure-function files):
- All formatters, crypto helpers, validators — pure functions, easy to test

**core/errors/** + **core/session/** + **core/contracts/**:
- Error handler behavior
- Token refresh logic
- Contract DTO serialization

### 3. Auth Data Layer Tests (P3)

- `auth_repository_impl.dart`
- `auth_api.dart` (if exists)
- Entity serialization

### 4. CI Coverage Threshold Gate (P3)

Add a coverage check step to `.github/workflows/ci.yml`:

```yaml
- name: Coverage threshold
  run: |
    COVERAGE=$(lcov --summary coverage/lcov.info 2>&1 | grep "lines" | awk '{print $2}' | tr -d '%')
    if [ $(echo "$COVERAGE < 18" | bc) -eq 1 ]; then
      echo "Coverage $COVERAGE% is below 18% threshold"
      exit 1
    fi
```

Start with 18% (current baseline), ratchet up as tests are added.

### 5. Architecture Guard for Bootstrap (P3)

Add test to verify `core/bootstrap/providers/` only exports Riverpod stubs, not concrete implementations.

## Out of Scope

- Widget/UI tests (high effort, low coverage ROI for this phase)
- Integration tests
- Golden tests
- Pre-commit hooks (separate spec)
- Coverage > 30% (future phases)

## Verification

```bash
make test-coverage    # Verify new tests pass and coverage rises
make ci               # Verify CI gate works
flutter test test/architecture/  # Verify architecture guards
```

## Effort

Medium. ~15-20 new test files, 1 CI config change, 1 architecture test.
