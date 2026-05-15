# Phase 30 Architecture Optimization Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Clean the remaining semantic coupling, domain/data leaks, codegen duplication, no-op abstractions, and large mixed-responsibility files after Phase 29 completed structural cleanup.

**Architecture:** Keep the current `app/` + `core/` + `features/` + `ui/` structure. Move only real shared contracts to `core/contracts`, reusable UI to `ui/`, and runtime/app seams to explicit feature public APIs.

**Tech Stack:** Flutter, Dart 3.10, Riverpod 3 generator, Freezed, json_serializable, go_router_builder, Retrofit, Drift, Slang, GitNexus, architecture guard tests.

---

Spec: `docs/specs/archive/2026-05-15-phase30-architecture-optimization.completed.md`

## Execution Rules

- Use Git Bash.
- Do not touch unrelated local changes.
- Run `npx gitnexus analyze` before code edits.
- Before editing a function, class, or method, run GitNexus upstream impact for the target symbol and report direct callers, affected flows, and risk. If GitNexus cannot resolve the Dart symbol, record that and use file-level import/caller evidence.
- Use generated Riverpod providers for new or rewritten provider state.
- Keep typed `go_router_builder` route seams.
- Do not hand-edit generated files.
- Do not delete code from grep alone; classify first.
- Commit only after a slice has passed its verification gate.

## Task 0: Baseline and Active Docs

**Files:**

- Modify: `CLAUDE.md`
- Modify: `docs/architecture/architecture-guide.md`
- Create: `docs/specs/2026-05-15-phase30-architecture-optimization.md`
- Create: `docs/plans/2026-05-15-phase30-architecture-optimization.md`

- [x] **Step 1: Verify current planning state**

Run:

```bash
git status --short
find docs/specs docs/plans -maxdepth 2 -type f | sort
rg -n "Active phase|Active spec|Active plan|Phase 29|Phase 30" CLAUDE.md docs/architecture/architecture-guide.md docs/specs docs/plans
```

Expected:

- Phase 29 archived as completed.
- No active spec or plan before this task.
- Existing dirty files are understood before patching.

- [x] **Step 2: Refresh GitNexus**

Run:

```bash
npx gitnexus analyze
```

Expected:

- Repository indexed successfully.
- If Dart parser skips files, record the warning and continue with file-level evidence.

- [x] **Step 3: Capture source baseline**

Run:

```bash
find lib -type f -name "*.dart" | wc -l
find lib -type f -name "*.dart" ! -name "*.g.dart" ! -name "*.freezed.dart" ! -name "*.pb.dart" ! -name "*.pbenum.dart" ! -name "*.pbjson.dart" | wc -l
find lib -type f \( -name "*.g.dart" -o -name "*.freezed.dart" -o -name "*.pb.dart" -o -name "*.pbenum.dart" -o -name "*.pbjson.dart" \) | wc -l
```

Expected baseline:

- Total Dart files: 877.
- Authored source Dart files: 636.
- Generated Dart files: 241.

- [x] **Step 4: Update active phase pointers**

Update:

- `CLAUDE.md` architecture header and active spec/plan lines.
- `docs/architecture/architecture-guide.md` active phase and authoritative docs.

Expected:

- Both files point to the active Phase 30 spec and plan.
- Phase 29 remains listed as completed/archived.

- [x] **Step 5: Verify doc pointers**

Run:

```bash
rg -n "Active phase|Active spec|Active plan|2026-05-15-phase30|2026-05-15-phase29" CLAUDE.md docs/architecture/architecture-guide.md docs/specs docs/plans
```

Expected:

- Phase 30 active references are present.
- Phase 29 references are archive/completed references only.

## Task 1: Cross-feature Application Seam Inventory

**Files:**

- Test: `test/architecture/architecture_boundary_guard_test.dart`
- Test helper: `test/architecture/architecture_guard_utils.dart`
- Possible modify: feature files reported by the inventory.
- Possible create: `docs/architecture/phase30-application-seam-inventory.md`

- [x] **Step 1: Generate exact inventory**

Run:

```bash
python - <<'PY'
import re
from pathlib import Path

hits = []
for path in sorted(Path("lib/features").rglob("*.dart")):
    text = path.read_text(encoding="utf-8")
    source = path.parts[2]
    for line_no, line in enumerate(text.splitlines(), start=1):
        match = re.search(r"import 'package:culcul/features/([^/]+)/(domain|application)/([^']+)'", line)
        if match and match.group(1) != source:
            hits.append(f"{path}:{line_no}: {source} -> {match.group(1)}/{match.group(2)}")

for hit in hits:
    print(hit)
print(f"count={len(hits)}")
PY
```

Expected:

- Current planning count is 30. If count differs, use the current output as source of truth.

- [x] **Step 2: Classify each hit**

Create or update `docs/architecture/phase30-application-seam-inventory.md` with one row per hit:

```md
| Importer | Target | Category | Decision |
|---|---|---|---|
| `lib/features/home/presentation/pages/home_page.dart` | `search/application/...` | search public seam | expose/query through approved seam |
```

Allowed categories:

- `approved-session-seam`
- `approved-search-seam`
- `approved-profile-seam`
- `move-to-core-contract`
- `move-to-ui`
- `new-feature-public-api`
- `remove-accidental-coupling`

- [x] **Step 3: Update or add guard expectations**

Extend `architecture_boundary_guard_test.dart` so cross-feature `data/**` and `presentation/**` stay forbidden, and cross-feature `application/**` or `domain/**` imports must either match the approved allowlist or fail with a readable message.

- [x] **Step 4: Run guard**

Run:

```bash
flutter test test/architecture/architecture_boundary_guard_test.dart --reporter compact
```

Expected:

- The test either passes with the documented allowlist or fails only on unclassified imports that this phase must fix.

## Task 2: Session, Search, and Profile Seam Cleanup

**Files:**

- Possible modify: `lib/features/auth/application/auth_session_providers.dart`
- Possible modify: `lib/features/profile/application/*`
- Possible modify: `lib/features/search/application/*`
- Possible modify: importer files found in Task 1.
- Test: `test/architecture/architecture_boundary_guard_test.dart`

- [x] **Step 1: Run impact before editing each target symbol**

For each symbol selected from Task 1, run GitNexus impact:

```bash
# Replace SymbolName with the exact class/function/provider before editing.
npx gitnexus impact SymbolName --direction upstream
```

Expected:

- Direct callers and risk are recorded in the task notes.
- If GitNexus cannot resolve the symbol, record the miss and use `rg -n "SymbolName" lib test`.

- [x] **Step 2: Replace accidental cross-feature imports**

Use one of these patterns:

```dart
// Shared value used by multiple features:
import 'package:culcul/core/contracts/core_contracts.dart';
```

```dart
// Reusable UI composition:
import 'package:culcul/ui/ui.dart';
```

```dart
// Approved feature seam:
import 'package:culcul/features/search/search.dart';
```

Do not import another feature's `data/**` or `presentation/**`.

- [x] **Step 3: Verify feature behavior**

Run targeted tests for touched features. If no focused test exists, run:

```bash
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

Expected:

- No new architecture failures.
- No analyzer errors or warnings.

## Task 3: Codegen Source-of-Truth Cleanup

**Files:**

- Modify: `build.yaml`
- Modify: `scripts/bootstrap_codegen.sh`
- Possible modify: `pubspec.yaml`
- Possible generated files: only if command output changes.

- [x] **Step 1: Decide canonical localization generation path**

Use this rule:

- If `dart run build_runner build --delete-conflicting-outputs` reliably generates Slang outputs without `dart run slang`, remove the explicit `dart run slang` call from `scripts/bootstrap_codegen.sh`.
- If build_runner Slang generation conflicts with existing outputs, remove `slang_build_runner` from the build graph and keep the explicit script call.

- [x] **Step 2: Verify canonical path**

Run the chosen command:

```bash
dart run build_runner build --delete-conflicting-outputs
```

or:

```bash
dart run slang
dart run build_runner build --delete-conflicting-outputs
```

Expected:

- No `InvalidOutputException`.
- Generated localization files are stable.

- [x] **Step 3: Tighten Retrofit generation scope**

Update `build.yaml` `retrofit_generator` includes from `lib/**` to current API entry points, such as:

```yaml
retrofit_generator:
  generate_for:
    include:
      - lib/core/data/network/*_api.dart
      - lib/features/**/data/*_api.dart
```

Before committing, run:

```bash
dart run build_runner build --delete-conflicting-outputs
git diff -- lib build.yaml
```

Expected:

- Retrofit outputs remain correct.
- No unrelated generated churn.

## Task 4: Domain DTO and Presentation Data/Proto Cleanup

**Files:**

- Modify: `lib/features/dynamic/domain/entities/dynamic_extension.dart`
- Possible modify: `lib/features/dynamic/data/dtos/dynamic_response.dart`
- Possible modify: `lib/features/live/presentation/view_models/live_room_state.dart`
- Possible modify: `lib/features/favorites/presentation/view_models/favorites_view_model.dart`
- Possible modify: `lib/features/live/presentation/view_models/live_room_view_model.dart`
- Possible modify: `lib/features/notification/presentation/view_models/chat_view_model.dart`
- Possible modify: `lib/features/profile/presentation/view_models/user_space_videos_view_model.dart`
- Test: `test/architecture/architecture_domain_dto_guard_test.dart`
- Test: `test/architecture/architecture_boundary_guard_test.dart`

- [x] **Step 1: Run impact for the dynamic extension leak**

Run:

```bash
npx gitnexus impact DynamicExtension --direction upstream
```

If unresolved:

```bash
rg -n "dynamic_extension|DynamicExtension|dynamic_response" lib/features/dynamic test
```

- [x] **Step 2: Move DTO-specific mapping out of domain**

Preferred shape:

```dart
// data mapper owns response-shape knowledge
extension DynamicResponseDtoMapper on DynamicResponseDto {
  DynamicEntity toDomain() {
    // map response fields to domain fields here
  }
}
```

Domain entities must not import `features/*/data/dtos/**`.

- [x] **Step 3: Inventory presentation-to-data/proto imports**

Run:

```bash
python - <<'PY'
import re
from pathlib import Path

hits = []
for path in sorted(Path("lib/features").rglob("presentation/**/*.dart")):
    text = path.read_text(encoding="utf-8")
    for line_no, line in enumerate(text.splitlines(), start=1):
        if re.search(r"package:culcul/(features/.+/data/|protos/)", line):
            hits.append(f"{path}:{line_no}: {line.strip()}")

for hit in hits:
    print(hit)
print(f"count={len(hits)}")
PY
```

- [x] **Step 4: Classify high-pressure feature hits**

Focus first on:

- `lib/features/live/presentation/view_models/live_room_state.dart`
- `lib/features/favorites/presentation/view_models/favorites_view_model.dart`
- `lib/features/live/presentation/view_models/live_room_view_model.dart`
- `lib/features/notification/presentation/view_models/chat_view_model.dart`
- `lib/features/profile/presentation/view_models/user_space_videos_view_model.dart`

Allowed outcomes:

- keep as same-feature private mapping with written reason;
- move response mapping into application/domain;
- introduce a view-facing contract in domain/application;
- move reusable UI shape to `ui/`.

- [x] **Step 5: Add or update guard**

Make `architecture_domain_dto_guard_test.dart` fail on domain imports of feature `data/dtos/**`. Do not ban all same-feature presentation-to-data imports until the inventory is classified.

- [x] **Step 6: Verify**

Run:

```bash
flutter test test/architecture/architecture_domain_dto_guard_test.dart --reporter compact
flutter analyze --no-fatal-infos
```

Expected:

- No domain-to-DTO imports remain.
- Analyzer has no errors or warnings.

## Task 5: App Runtime and Feature-scope Seam Alignment

**Files:**

- Modify: `lib/app/runtime/root_overrides.dart`
- Possible modify: `lib/features/auth/application/auth_session_cookie_refresher.dart`
- Modify: `CLAUDE.md`
- Modify: `docs/architecture/architecture-guide.md`
- Test: `test/architecture/architecture_boundary_guard_test.dart`

- [x] **Step 1: Run impact for runtime wiring**

Run:

```bash
npx gitnexus impact AuthSessionCookieRefresher --direction upstream
```

If unresolved:

```bash
rg -n "AuthSessionCookieRefresher|auth_session_cookie_refresher|root_overrides" lib test
```

- [x] **Step 2: Decide runtime seam ownership**

Use this rule:

- if the app needs a generic session refresh contract, move the contract to `core/session` or `core/contracts`;
- if auth owns all behavior and app only installs it, expose a narrow auth public seam instead of importing an implementation file;
- if direct import is intentionally retained, document why in `architecture-guide.md`.

- [x] **Step 3: Align `feature_scope.dart` truth**

Current baseline has zero `feature_scope.dart` files. Pick one:

- retire it from approved seams and guards; or
- reintroduce it only for features that truly need runtime composition exports.

Update `CLAUDE.md`, `docs/architecture/architecture-guide.md`, and `architecture_boundary_guard_test.dart` so they agree.

- [x] **Step 4: Verify**

Run:

```bash
flutter test test/architecture/architecture_boundary_guard_test.dart --reporter compact
flutter analyze --no-fatal-infos
```

Expected:

- App/runtime seam is explicit.
- `feature_scope.dart` guard is no longer orphaned.

## Task 6: Large-file Decomposition

**Files:**

- Candidate: `lib/features/notification/data/notification_repository_impl.dart`
- Candidate: `lib/features/video/presentation/player/controls/player_settings_sheet.options.dart`
- Candidate: `lib/features/video/presentation/comments/comment_reply_page.dart`
- Candidate: `lib/core/services/audio_handler.dart`
- Candidate: `lib/features/video/presentation/detail/video_detail_view_model.dart`
- Candidate: `lib/features/live/presentation/view_models/live_socket_service.dart`
- Candidate: `lib/features/auth/data/auth_repository_impl.helpers.dart`
- Candidate: `lib/core/data/network/endpoint_policy.dart`
- Candidate: `lib/core/data/network/providers/wbi_helper_provider.dart`

- [x] **Step 1: Pick one file per slice**

Use this selection rule:

- split when the file has two or more distinct responsibilities;
- do not split when the file is long but cohesive;
- keep files that change together in the same feature/core area.

- [x] **Step 2: Run impact for symbols being moved**

Run GitNexus impact for moved classes/functions. If impact is high or critical, stop and report before editing.

- [x] **Step 3: Extract by responsibility**

Examples:

- mapper/helper functions move to `*.mapper.dart` or `*.helpers.dart` only when reused or independently testable;
- network policy tables move to a data file if the logic and data are mixed;
- widget subtrees move to private widgets when it reduces constructor/state complexity.

- [x] **Step 4: Verify**

Run:

```bash
dart format <touched dart files>
flutter analyze --no-fatal-infos
flutter test test/architecture --reporter compact
```

Add feature-specific tests when the moved logic has behavior.

## Task 7: No-op Workflow Cleanup

**Files:**

- Modify: `lib/features/dynamic/application/dynamic_workflows.dart`
- Modify: `lib/features/dynamic/presentation/view_models/article_detail_view_model.actions.dart`
- Test: dynamic feature tests if present.

- [x] **Step 1: Run impact**

Run:

```bash
npx gitnexus impact ArticleDetailCommentActionResult --direction upstream
```

If unresolved:

```bash
rg -n "ArticleDetailCommentActionResult|\\.noop\\(" lib test
```

- [x] **Step 2: Decide semantics**

Keep `noop` only if it is an explicit state a caller needs. Delete it if it merely hides early returns.

- [x] **Step 3: Replace meaningless no-op paths**

Preferred shape:

```dart
if (!canPerformAction) {
  return;
}
```

or a precise result:

```dart
return const ArticleDetailCommentActionResult.skipped(reason: ArticleCommentSkipReason.notLoggedIn);
```

Only add a richer result type if the UI consumes the reason.

- [x] **Step 4: Verify**

Run:

```bash
flutter analyze --no-fatal-infos
flutter test test/architecture --reporter compact
```

Run dynamic feature tests if present.

## Task 8: Final Guard, Docs, and Completion

**Files:**

- Modify: `docs/architecture/architecture-guide.md`
- Modify: `docs/specs/2026-05-15-phase30-architecture-optimization.md`
- Modify: `docs/plans/2026-05-15-phase30-architecture-optimization.md`
- Possible modify: `CLAUDE.md`

- [x] **Step 1: Run final verification**

Run:

```bash
bash tool/architecture/run_architecture_guards.sh
flutter analyze --no-fatal-infos
flutter test test/architecture --reporter compact
```

Run touched feature tests too.

- [x] **Step 2: Refresh final counts**

Run:

```bash
find lib -type f -name "*.dart" | wc -l
find lib -type f -name "*.dart" ! -name "*.g.dart" ! -name "*.freezed.dart" ! -name "*.pb.dart" ! -name "*.pbenum.dart" ! -name "*.pbjson.dart" | wc -l
find lib -type f \( -name "*.g.dart" -o -name "*.freezed.dart" -o -name "*.pb.dart" -o -name "*.pbenum.dart" -o -name "*.pbjson.dart" \) | wc -l
```

- [x] **Step 3: Mark completion or supersession honestly**

If all Phase 30 success criteria pass:

- move this spec to `docs/specs/archive/2026-05-15-phase30-architecture-optimization.completed.md`;
- move this plan to `docs/plans/archive/2026-05-15-phase30-architecture-optimization.completed.md`;
- update `CLAUDE.md` and `docs/architecture/architecture-guide.md` to show no active phase and Phase 30 completed.

If only part lands:

- move docs with `.superseded.md`;
- create the next narrower phase spec/plan;
- document remaining risks in the new active phase.

- [x] **Step 4: Run GitNexus change detection before commit**

Run:

```bash
npx gitnexus detect-changes
git status --short
```

Expected:

- Changed symbols and flows match the slice scope.
- No unrelated files staged.
