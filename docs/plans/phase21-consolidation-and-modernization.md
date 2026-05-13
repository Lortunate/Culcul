# Phase 21 Consolidation & Modernization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make Culcul's app architecture easier to read and maintain by removing the remaining real duplication, cross-feature coupling, stale abstractions, dead code, zero-value wrappers, and undocumented provider/feedback variants.

**Architecture:** Keep the existing `app/` + `core/` + `features/` + `ui/` structure. Use ports/contracts for cross-feature access, generated Riverpod providers for normal dependency wiring, and DTO/domain separation so each concept has one source of truth. Inside a feature, keep `data/`, `application/`, `domain/`, and `presentation/` only when the layer owns real behavior; collapse pass-through layers.

**Tech Stack:** Flutter, Dart 3.10, Riverpod 3 with `riverpod_generator`, go_router + go_router_builder, Dio + Retrofit, Drift, Freezed, Slang, build_runner, GitNexus.

---

## Execution Rules

- Start from `E:/Projects/Flutter/Culcul`.
- Use Git Bash only.
- Do not revert unrelated dirty-tree changes.
- Before editing any Dart symbol, run GitNexus impact analysis for that symbol and record direct callers, affected flows, and risk.
- If GitNexus reports HIGH or CRITICAL risk, stop and report before editing.
- Do not dispatch multiple implementers that edit overlapping files.
- Every task must end with `dart analyze` or a narrower failing/passing gate when the full analyzer is temporarily blocked by earlier tasks.
- Before any commit, run `gitnexus_detect_changes()` / GitNexus `detect_changes(scope: "all")`.

## Task 1: Verify Planning Archive and Add Architecture Guards

**Files:**
- Modify: `CLAUDE.md`
- Verify: `docs/specs/archive/phase20-architecture-cleanup.superseded.md`
- Verify: `docs/plans/archive/phase20-architecture-cleanup.superseded.md`
- Modify: `docs/specs/phase21-consolidation-and-modernization.md`
- Modify: `docs/plans/phase21-consolidation-and-modernization.md`
- Create: `test/architecture/architecture_boundary_guard_test.dart`
- Create: `test/architecture/architecture_feedback_guard_test.dart`
- Create: `test/architecture/architecture_domain_dto_guard_test.dart`

- [ ] **Step 1: Confirm active docs**

Run:
```bash
pwd
git status --short
rg -n "Active spec:|Active plan:|phase20|phase21" CLAUDE.md docs
```

Expected:
- `CLAUDE.md` points to Phase 21.
- Phase 20 appears only in archive paths.

- [ ] **Step 2: Produce repo-wide cleanup inventory**

Run:
```bash
rg -n "export '.*';$|class .*Repository|abstract class .*Repository|fromJson|toJson|JsonKey|ScaffoldMessenger\.of|ToastUtils|AppException|StateNotifierProvider|Provider<|Provider\(" lib
find lib -type d -empty
find lib -type f \( -name "*.dart" ! -name "*.g.dart" ! -name "*.freezed.dart" \) -print
```

Record findings in the task notes or `bd`:
- duplicate owners and competing public entry points,
- zero-value wrappers and pass-through files,
- dead code candidates,
- empty/pass-through directories,
- approved exceptions such as `lib/ui/ui.dart` and `lib/core/contracts/core_contracts.dart`.

- [ ] **Step 3: Add guard tests**

Create tests that scan `lib/**/*.dart` and fail on:
- `features/<a>/presentation/**` importing `features/<b>/presentation/**`.
- Any feature importing another feature's `data/**`.
- DTO/response-shaped code in `features/*/domain/entities/**`.
- `ScaffoldMessenger.of(` outside the approved feedback implementation.
- `AppException`.
- Re-export-only files except `lib/core/contracts/core_contracts.dart` and `lib/ui/ui.dart`.

- [ ] **Step 4: Run guards**

Run:
```bash
flutter test test/architecture --reporter compact
```

Expected:
- Initial failures are acceptable only where they match Phase 21 known debt.
- Commit guard tests once they correctly identify known failures.

- [ ] **Step 5: Commit**

Run:
```bash
git add CLAUDE.md docs test/architecture
git commit -m "docs: define phase21 architecture consolidation plan"
```

## Task 2: Remove Cross-Feature Presentation Coupling

**Files to inspect first:**
- `lib/features/home/presentation/pages/home_page.dart`
- `lib/features/home/presentation/widgets/home_video_actions.dart`
- `lib/features/home/presentation/widgets/live_view.dart`
- `lib/features/home/presentation/widgets/home_app_bar.dart`
- `lib/features/profile/presentation/widgets/user_dynamic_tab.dart`
- `lib/core/contracts/`
- affected feature `feature_scope.dart` and `route_entry.dart` files

- [ ] **Step 1: Run impact analysis**

Run GitNexus impact for the widgets/view models being replaced:
- `HomePage`
- `HomeVideoActions`
- `LiveView`
- `UserDynamicTab`

Record direct callers and risk.

- [ ] **Step 2: Replace concrete feature imports**

Use one of these patterns:
- Navigation-only dependency: call the target feature's `route_entry.dart`.
- State/action dependency: define or reuse a small `core/contracts/*_port.dart`.
- Composition dependency: expose only the approved feature boundary from `feature_scope.dart`.

Do not import another feature's `presentation/**` or `data/**`.
Do not export presentation view models/widgets from `feature_scope.dart`; keep feature scopes limited to runtime/provider/data composition.
Do not import `app/router/app_routes.dart` from feature widgets unless the file is an approved route entry point.

- [ ] **Step 3: Run verification**

Run:
```bash
flutter test test/architecture/architecture_boundary_guard_test.dart --reporter compact
dart analyze
```

Expected:
- Boundary guard passes.
- Analyzer has no new errors.

- [ ] **Step 4: Commit**

Run:
```bash
git add lib test/architecture
git commit -m "refactor: remove cross-feature presentation coupling"
```

## Task 3: Unify Feedback and Error Reporting

**Files to inspect first:**
- `lib/core/errors/app_error.dart`
- `lib/core/errors/error_handler.dart`
- `lib/core/utils/toast_utils.dart`
- files matching `rg -n "ScaffoldMessenger\\.of|ToastUtils|AppException" lib`

- [ ] **Step 1: Run impact analysis**

Run GitNexus impact for:
- `AppError`
- `ErrorHandler`
- `ToastUtils`

Record whether risk is HIGH/CRITICAL before editing.

- [ ] **Step 2: Define single feedback surface**

Keep one approved API, preferably a `BuildContext` extension such as `context.showAppFeedback(...)`, backed by `AppError` mapping where needed.

- [ ] **Step 3: Replace raw calls**

Replace feature-local raw snackbar/toast calls with the approved feedback API.

Delete `ToastUtils` if no caller remains. If a tiny implementation helper remains, keep it private to the feedback module and remove feature imports.

- [ ] **Step 4: Run verification**

Run:
```bash
flutter test test/architecture/architecture_feedback_guard_test.dart --reporter compact
dart analyze
```

Expected:
- No `AppException`.
- No raw `ScaffoldMessenger.of(` outside the approved feedback implementation.
- No feature import of `ToastUtils`.

- [ ] **Step 5: Commit**

Run:
```bash
git add lib test/architecture
git commit -m "refactor: unify app feedback handling"
```

## Task 4: Move DTO and Response Shapes Out of Domain

**Files to inspect first:**
- `lib/features/dynamic/domain/entities/dynamic_response*.dart`
- `lib/features/dynamic/domain/entities/emote_response.dart`
- `lib/features/dynamic/domain/entities/dynamic_extension.dart`
- `lib/features/live/domain/entities/live_history_danmaku_model.dart`
- `lib/features/notification/domain/entities/system_notice.dart`
- `lib/features/profile/domain/entities/profile_user.dart`
- corresponding `lib/features/*/data/dtos/` and mapper files

- [ ] **Step 1: Run impact analysis**

Run GitNexus impact for each moved class before editing. Use file path hints when names are ambiguous.

- [ ] **Step 2: Classify each type**

For each file:
- If it is JSON/API shaped, move it to `data/dtos/`.
- If it is durable app/domain behavior, keep it in `domain/entities/` and remove JSON annotations by adding a DTO mapper.
- If the feature is a pass-through API surface with no business behavior, remove the domain layer for that type.
- If moving a type leaves an empty/pass-through layer or wrapper, delete that layer instead of preserving old structure.
- If a domain file imports `data/dtos/`, move that mapping dependency into data/application code so domain does not depend on transport shapes.

- [ ] **Step 3: Update imports and mappers**

Keep generated files consistent:
```bash
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 4: Run verification**

Run:
```bash
flutter test test/architecture/architecture_domain_dto_guard_test.dart --reporter compact
dart analyze
```

Expected:
- No DTO/response-shaped code remains in `domain/entities`.
- Generated files are updated only where expected.
- No empty or pass-through layer remains without a concrete owner.

- [ ] **Step 5: Commit**

Run:
```bash
git add lib test/architecture
git commit -m "refactor: separate dto and domain models"
```

## Task 5: Normalize Provider Ownership

**Files to inspect first:**
- `lib/core/session/user_providers.dart`
- `lib/core/session/search_providers.dart`
- `lib/core/session/relation_providers.dart`
- `lib/core/session/feature_action_providers.dart`
- `lib/core/session/session_lifecycle_providers.dart`
- `lib/core/data/network/network_quality_policy.dart`
- `lib/core/services/audio_handler.dart`

- [ ] **Step 1: Run impact analysis**

Run GitNexus impact on each provider symbol that will change.

- [ ] **Step 2: Migrate ordinary providers**

Use `@riverpod` generated providers for ordinary dependency/state providers.

Keep hand-written providers only where bootstrap override behavior requires them. Add a short local comment explaining why.

- [ ] **Step 3: Regenerate**

Run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 4: Run verification**

Run:
```bash
dart analyze
rg -n "StateNotifierProvider|Provider<|Provider\\(" lib/core/session lib/core/data/network lib/core/services
```

Expected:
- No `StateNotifierProvider`.
- Remaining hand-written providers are documented exceptions.

- [ ] **Step 5: Commit**

Run:
```bash
git add lib
git commit -m "refactor: normalize core provider ownership"
```

## Task 6: Resolve UI Public API and Naming Collisions

**Files to inspect first:**
- `lib/ui/ui.dart`
- files defining or importing `DefaultSearch`
- files defining or importing `PrivateMessageSummaryKind`
- files defining or importing `UserProfileInfo`
- files defining or importing `DanmakuView`
- files defining or importing `PrivateSessionList`
- files defining or importing `VideoSubtitle`
- guard exception candidates: `lib/main.dart`, `lib/protos/`, `lib/ui/ui.dart`, `lib/features/auth/login_dialog_action.dart`

- [x] **Step 1: Decide `ui.dart`**

Decision: keep `lib/ui/ui.dart` as the approved public UI API. It exports only shared `ui/` components and is already consumed by app, feature, and UI-overlay entry points. Guard exceptions and spec/CLAUDE docs are updated for this explicit decision.

- [x] **Step 2: Rename confusing UI-only collisions**

Use GitNexus rename or IDE-aware rename for symbols, never raw find-and-replace.

- [x] **Step 3: Merge true duplicate models**

If two models represent the same durable concept, move the canonical type to `core/contracts/` or the owning feature domain, then update mappers/imports.

- [ ] **Step 4: Run verification**

Run:
```bash
flutter test test/architecture --reporter compact
dart analyze
```

Expected:
- Re-export guard passes.
- Code search for renamed concepts returns one obvious owner.
- Guard exceptions are explicit and narrow; generated protobuf output is not treated as hand-authored duplicate app model code.

- [ ] **Step 5: Commit**

Run:
```bash
git add lib test/architecture
git commit -m "refactor: clarify ui api and model names"
```

## Task 7: Evidence-Backed Dependency and Codegen Updates

**Files:**
- Modify: `pubspec.yaml`
- Modify: `pubspec.lock`
- Generated Dart files only if build_runner changes output

- [ ] **Step 1: Review current package state and docs**

Run:
```bash
flutter pub outdated
```

Use Context7 or official docs for Riverpod, go_router, Drift, Retrofit, Freezed/json_serializable, and build_runner when API behavior is uncertain.

Expected:
- Existing stack remains preferred: Riverpod generator, go_router_builder, Drift, Dio + Retrofit, Freezed/JSON, Slang.
- No new library is introduced unless it removes code, removes risk, or replaces custom code with a stable package API.

- [ ] **Step 2: Update only scoped packages**

Target package changes:
- `drift` / `drift_dev`: `^2.31.0` to `^2.33.0`
- `drift_flutter`: `^0.2.8` to `^0.3.0`
- `retrofit_generator`: `^10.2.1` to `^10.2.6`
- `json_serializable`: `^6.13.0` to `^6.13.2`

- [ ] **Step 3: Verify package resolution**

Run:
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 4: Review generated diff**

Run:
```bash
git diff -- pubspec.yaml pubspec.lock lib
```

Expected:
- No broad generated churn unrelated to the scoped package updates.
- Drift database setup still follows current `drift_flutter` API.

- [ ] **Step 5: Run verification**

Run:
```bash
dart analyze
flutter test --reporter compact
flutter build apk --debug
```

- [ ] **Step 6: Commit**

Run:
```bash
git add pubspec.yaml pubspec.lock lib
git commit -m "chore: refresh architecture codegen dependencies"
```

## Final Verification Gate

Run:
```bash
git status --short
dart analyze
dart run build_runner build --delete-conflicting-outputs
flutter test --reporter compact
flutter build apk --debug
rg -n "AppException|ScaffoldMessenger\.of|ToastUtils|StateNotifierProvider" lib
find lib -type d -empty
```

Run GitNexus:
- `detect_changes(scope: "all")`

Expected:
- Only planned symbols and flows are affected.
- No Phase 20 active docs remain.
- Phase 21 guards pass.
- Analyzer, tests, codegen, and debug build pass.
- Remaining search results are approved exceptions or have `bd` follow-up issues.
- No empty/pass-through architecture layer remains without a documented owner.

## Self-Review

- Spec coverage: WI-1 maps to Task 1; WI-2 to Task 2; WI-3 to Task 3; WI-4 to Task 4; WI-5 to Task 5; WI-6 to Task 6; WI-7 to Task 7.
- Placeholder scan: no placeholder paths or vague "fix later" tasks remain.
- Type consistency: plan consistently uses `AppError`, `AppFeedback`, `core/contracts`, `feature_scope.dart`, `route_entry.dart`, DTOs, and generated Riverpod providers.
- Architecture consistency: plan preserves the top-level folders while allowing feature-local pass-through layers to be deleted.
