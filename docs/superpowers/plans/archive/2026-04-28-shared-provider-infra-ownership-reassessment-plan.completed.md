> Completed on 2026-04-30 after the shared-provider infra ownership slice landed on `master`.
> Verification used during closeout: `flutter test test/shared/network/wbi_helper_provider_test.dart --reporter compact`, `flutter test test/architecture/shared_provider_infra_ownership_guard_test.dart --reporter compact`, `flutter test test/architecture/provider_bootstrap_ownership_guard_test.dart --reporter compact`, `flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact`, and `flutter analyze`.
> No new active planning surface is open.

# Shared Provider Infra Ownership Reassessment Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Finish the next bounded architecture cleanup by moving the last remaining `lib/shared/providers/**` file (`wbi_provider.dart`) into a network-owned home, then lock the old path down with tests and docs.

**Architecture:** Keep this slice narrow. Treat WBI signing as network-local infrastructure because its only production consumer is `WbiInterceptor` and its dependencies already live under `lib/shared/network/**`. Migrate the canonical file first, preserve behavior, then delete the old path and add a focused architecture guard.

**Tech Stack:** Flutter, Dart, Riverpod, Dio, Flutter test

---

## File Structure Map

### Plan and design docs

- Reference: `docs/superpowers/specs/2026-04-28-shared-provider-infra-ownership-reassessment-design.md`
- Modify: `docs/architecture/shared-boundary-rules.md`
- Modify: `docs/architecture/phase3-structural-normalization-rules.md`

### Code files expected to change

- Create: `lib/shared/network/providers/wbi_helper_provider.dart`
- Modify: `lib/shared/network/interceptors/wbi_interceptor.dart`
- Delete: `lib/shared/providers/wbi_provider.dart`

### Tests

- Create: `test/shared/network/wbi_helper_provider_test.dart`
- Create: `test/architecture/shared_provider_infra_ownership_guard_test.dart`
- Re-run: `test/architecture/provider_bootstrap_ownership_guard_test.dart`
- Re-run: `test/architecture/phase3_legacy_import_paths_test.dart`

## Implementation Tasks

### Task 0: Prepare the worktree and baseline

**Files:**
- Reference: `.gitignore`
- Reference: `docs/superpowers/specs/2026-04-28-shared-provider-infra-ownership-reassessment-design.md`

- [ ] **Step 1: Verify the worktree location is still ignored**

Run:

```bash
git check-ignore -v .worktrees
```

Expected: output shows `.worktrees/` is ignored by `.gitignore`.

- [ ] **Step 2: Create a dedicated branch and worktree**

Run:

```bash
git worktree add .worktrees/wbi-provider-ownership -b refactor/wbi-provider-ownership
```

Expected: a new worktree is created from `master`.

- [ ] **Step 3: Claim the follow-up bd issue inside the worktree**

Run:

```bash
cd .worktrees/wbi-provider-ownership
bd update culcul-4ws --claim --json
```

Expected: JSON response shows `culcul-4ws` assigned/claimed for the current session.

- [ ] **Step 4: Record the baseline imports and validation status**

Run:

```bash
rg -n "shared/providers/wbi_provider.dart|wbiHelperProvider|WbiInterceptor" lib test
flutter test test/architecture/provider_bootstrap_ownership_guard_test.dart --reporter compact
flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact
flutter analyze
```

Expected: the `rg` scan shows the current import surface; both existing architecture tests pass; `flutter analyze` is either green or any pre-existing unrelated failures are recorded before edits.

### Task 1: Add the failing tests that define the slice

**Files:**
- Create: `test/shared/network/wbi_helper_provider_test.dart`
- Create: `test/architecture/shared_provider_infra_ownership_guard_test.dart`

- [ ] **Step 1: Write the failing helper behavior test**

Create `test/shared/network/wbi_helper_provider_test.dart` with a fake `ResourceApi` and a focused signing assertion:

```dart
import 'package:culcul/shared/network/providers/wbi_helper_provider.dart';
import 'package:culcul/shared/network/resource_api.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeResourceApi implements ResourceApi {
  @override
  Future<dynamic> fetchNav() async => {
        'code': 0,
        'data': {
          'wbi_img': {
            'img_url': 'https://i0.hdslb.com/bfs/wbi/0123456789abcdef.png',
            'sub_url': 'https://i0.hdslb.com/bfs/wbi/fedcba9876543210.png',
          },
        },
      };

  @override
  Future<List<int>> fetchBytes(String url) => throw UnimplementedError();

  @override
  Future<dynamic> fetchJson(String url) => throw UnimplementedError();
}

void main() {
  test('WbiHelper updates keys and appends wts/w_rid when signing', () async {
    final helper = WbiHelper(_FakeResourceApi());

    await helper.updateKeys();
    final signed = helper.sign({'foo': "a!b'c(d)*", 'bar': 1});

    expect(signed['foo'], 'abcd');
    expect(signed['bar'], '1');
    expect(signed['wts'], isA<int>());
    expect((signed['w_rid'] as String).length, 32);
  });
}
```

- [ ] **Step 2: Run the new helper test and verify it fails**

Run:

```bash
flutter test test/shared/network/wbi_helper_provider_test.dart --reporter compact
```

Expected: FAIL because `package:culcul/shared/network/providers/wbi_helper_provider.dart` does not exist yet.

- [ ] **Step 3: Write the failing architecture guard for the old shared path**

Create `test/architecture/shared_provider_infra_ownership_guard_test.dart`:

```dart
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const _retiredSharedProviderPaths = [
  'package:culcul/shared/providers/wbi_provider.dart',
];

void main() {
  test('Production code does not import retired shared provider paths', () async {
    final libDir = Directory('lib');
    final violations = <String>[];

    if (libDir.existsSync()) {
      for (final file in libDir.listSync(recursive: true)) {
        if (file is! File || !file.path.endsWith('.dart')) {
          continue;
        }

        final content = await file.readAsString();
        for (final retiredImport in _retiredSharedProviderPaths) {
          if (content.contains(retiredImport)) {
            violations.add('${file.path} -> $retiredImport');
          }
        }
      }
    }

    expect(violations, isEmpty, reason: violations.join(', '));
  });
}
```

- [ ] **Step 4: Run the guard and verify it fails on the current import**

Run:

```bash
flutter test test/architecture/shared_provider_infra_ownership_guard_test.dart --reporter compact
```

Expected: FAIL because `lib/shared/network/interceptors/wbi_interceptor.dart` still imports `package:culcul/shared/providers/wbi_provider.dart`.

- [ ] **Step 5: Commit the failing tests**

Run:

```bash
git add test/shared/network/wbi_helper_provider_test.dart test/architecture/shared_provider_infra_ownership_guard_test.dart
git commit -m "test: define wbi provider ownership slice"
```

### Task 2: Introduce the canonical network-owned WBI helper file

**Files:**
- Create: `lib/shared/network/providers/wbi_helper_provider.dart`

- [ ] **Step 1: Copy the helper into its canonical network-owned home**

Create `lib/shared/network/providers/wbi_helper_provider.dart` with the current `WbiHelper` and `wbiHelperProvider` implementation, changing only the import path:

```dart
import 'dart:async';
import 'dart:convert';

import 'package:culcul/shared/network/resource_api.dart';
import 'package:culcul/shared/network/resource_api_provider.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Keep the existing mixin table and signing logic unchanged.
class WbiHelper {
  WbiHelper(this._resourceApi);

  final ResourceApi _resourceApi;
  // ... keep the rest of the implementation byte-for-byte equivalent
}

final wbiHelperProvider = Provider<WbiHelper>((ref) {
  return WbiHelper(ref.watch(basicResourceApiProvider));
});
```

- [ ] **Step 2: Run the helper test and verify it passes before consumer migration**

Run:

```bash
flutter test test/shared/network/wbi_helper_provider_test.dart --reporter compact
```

Expected: PASS.

- [ ] **Step 3: Commit the canonical file introduction**

Run:

```bash
git add lib/shared/network/providers/wbi_helper_provider.dart test/shared/network/wbi_helper_provider_test.dart
git commit -m "refactor: add canonical wbi helper provider home"
```

### Task 3: Migrate the production consumer to the canonical path

**Files:**
- Modify: `lib/shared/network/interceptors/wbi_interceptor.dart`

- [ ] **Step 1: Update the interceptor import to the network-owned file**

Change:

```dart
import 'package:culcul/shared/providers/wbi_provider.dart';
```

To:

```dart
import 'package:culcul/shared/network/providers/wbi_helper_provider.dart';
```

- [ ] **Step 2: Run the new architecture guard and verify it passes**

Run:

```bash
flutter test test/architecture/shared_provider_infra_ownership_guard_test.dart --reporter compact
```

Expected: PASS.

- [ ] **Step 3: Run a focused network validation sweep**

Run:

```bash
flutter test test/shared/network/wbi_helper_provider_test.dart --reporter compact
flutter test test/architecture/shared_provider_infra_ownership_guard_test.dart --reporter compact
flutter test test/architecture/provider_bootstrap_ownership_guard_test.dart --reporter compact
```

Expected: PASS for all three tests.

- [ ] **Step 4: Commit the production import migration**

Run:

```bash
git add lib/shared/network/interceptors/wbi_interceptor.dart test/architecture/shared_provider_infra_ownership_guard_test.dart
git commit -m "refactor: migrate wbi interceptor to network-owned provider"
```

### Task 4: Retire the old shared provider path and update architecture docs

**Files:**
- Delete: `lib/shared/providers/wbi_provider.dart`
- Modify: `docs/architecture/shared-boundary-rules.md`
- Modify: `docs/architecture/phase3-structural-normalization-rules.md`

- [ ] **Step 1: Delete the retired shared provider file**

Run:

```bash
git rm lib/shared/providers/wbi_provider.dart
```

Expected: the last file under `lib/shared/providers/` is removed.

- [ ] **Step 2: Update the shared-boundary doc to reflect the retired folder**

Add language equivalent to:

```md
- `lib/shared/providers/**` is retired.
- WBI signing ownership now lives under `lib/shared/network/providers/**`.
- New provider declarations must live next to their owning infra domain rather than under a generic shared provider bucket.
```

- [ ] **Step 3: Update the phase-3 rules doc so the ownership story is continuous**

Add language equivalent to:

```md
- the former `shared/providers/wbi_provider.dart` path has been retired
- `WbiHelper` now belongs to network-owned infrastructure
- follow-up cleanup should start from the owning domain, not from resurrecting `shared/providers/**`
```

- [ ] **Step 4: Commit the old-path retirement**

Run:

```bash
git add docs/architecture/shared-boundary-rules.md docs/architecture/phase3-structural-normalization-rules.md
git commit -m "docs: retire the last shared provider path"
```

### Task 5: Validate the slice end to end and close tracking

**Files:**
- Re-run only

- [ ] **Step 1: Run the full validation set**

Run:

```bash
flutter test test/shared/network/wbi_helper_provider_test.dart --reporter compact
flutter test test/architecture/shared_provider_infra_ownership_guard_test.dart --reporter compact
flutter test test/architecture/provider_bootstrap_ownership_guard_test.dart --reporter compact
flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact
flutter analyze
```

Expected: all tests pass; `flutter analyze` is green or matches the documented baseline exactly.

- [ ] **Step 2: Confirm no production code references the retired path**

Run:

```bash
rg -n "shared/providers/wbi_provider.dart" lib test docs
```

Expected: no results from `lib/`; any doc references are intentional planning/archive references only.

- [ ] **Step 3: Verify affected scope before integration**

Run:

```bash
bd update culcul-4ws --status in_progress --json
git status --short
```

Expected: only the expected WBI ownership files and doc updates are present.

- [ ] **Step 4: Close the issue after verification**

Run:

```bash
bd close culcul-4ws --reason "Completed" --json
```

Expected: issue is closed with machine-readable confirmation.

## Commit Strategy

- `test: define wbi provider ownership slice`
- `refactor: add canonical wbi helper provider home`
- `refactor: migrate wbi interceptor to network-owned provider`
- `docs: retire the last shared provider path`

## Risks To Watch

- hidden test fixtures may still import `package:culcul/shared/providers/wbi_provider.dart`
- the WBI helper test must avoid depending on generated Retrofit implementations
- `flutter analyze` may expose unrelated baseline issues; record them before attributing failures to this slice

## Out Of Scope

- moving other interceptors
- redesigning `ResourceApi`
- introducing a broader network-module taxonomy

## Done Criteria

- `lib/shared/providers/**` no longer exists in production code
- WBI helper ownership is clearly network-local
- a dedicated architecture test blocks the retired shared provider path
- focused WBI behavior coverage exists

## Handoff Notes

If this slice lands cleanly, the next architecture follow-up should only be opened if another domain still lacks an obvious owner. Do not reopen a generic `shared/providers/**` bucket.
