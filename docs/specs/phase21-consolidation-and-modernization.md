# Phase 21: Consolidation & Modernization

**Date**: 2026-05-13
**Status**: Active
**Supersedes**:
- `docs/specs/archive/phase20-architecture-cleanup.superseded.md`
- `docs/plans/archive/phase20-architecture-cleanup.superseded.md`

## Goal

Make the app architecture smaller, clearer, and easier to change by removing remaining semantic duplication, cross-feature presentation coupling, zero-value wrappers, stale abstractions, and dead code. Backward compatibility with old internal structure is not required. The end state must have one real source of truth for each durable concept, API shape, service, and public UI surface.

## Current Baseline

The app already uses the target top-level structure:

- `lib/app/` for startup, routing, runtime composition, and shell.
- `lib/core/` for app-wide contracts, services, network, storage, errors, result, and session ports.
- `lib/features/` for feature-owned data, application, domain, and presentation code.
- `lib/ui/` for reusable UI primitives and assemblies.

Phases 1-20 already removed `lib/shared/`, most barrel chains, several duplicate models, old repository interfaces, Hive/encrypt leftovers, and broad generated-code churn. Phase 21 must not restart those completed migrations. It targets the remaining real debt visible in the current working tree, plus a repo-wide inventory for duplicate ownership, dead code, empty/pass-through directories, and zero-implementation wrappers.

The top-level `app/` + `core/` + `features/` + `ui/` structure stays. Inside that structure, feature-local `data/`, `application/`, `domain/`, and `presentation/` directories are optional: keep them only when they own real behavior, contracts, mapping, or UI. Collapse pass-through layers instead of preserving old ceremony.

## Non-Negotiable Architecture Rules

- `core/` and `ui/` must not import from `features/`.
- A feature must not import another feature's `presentation/**` or `data/**` internals.
- Cross-feature runtime access must go through `core/contracts/*` ports, `feature_scope.dart`, or `route_entry.dart`.
- Feature public files are only for composition/runtime boundaries. No new barrel chains.
- `core_contracts.dart` is the only allowed re-export-only core contract barrel.
- `lib/ui/ui.dart` is the explicitly approved UI public API barrel. It stays limited to `ui/` exports and must not export feature code.
- DTOs and API response shapes belong in `data/dtos/`, not `domain/entities/`.
- Domain entities model behavior and durable app concepts only.
- Shared models have one canonical definition in `core/contracts/`.
- Business logic does not live in DTOs.
- A directory layer must earn its existence. Remove empty directories, pass-through files, and wrappers that only rename another API.
- Every durable concept has one owner. Duplicate type definitions, parallel services, and competing public entry points must be merged or explicitly documented as separate concepts.
- Dead code is deleted instead of parked behind unused facades.
- New Riverpod work uses `@riverpod` generated providers and `Notifier` / `AsyncNotifier` patterns.
- Hand-written providers are allowed only for documented bootstrap override ports where generated providers materially worsen testability or startup wiring.
- go_router is already typed/generated through `go_router_builder`; do not rewrite routing unless a route boundary is broken.
- Prefer proven packages already in the stack: Riverpod 3, go_router_builder, Drift, Dio + Retrofit, Freezed, Slang, shared_preferences, flutter_secure_storage, dio_smart_retry.
- Do not add wrapper libraries or app-specific facades around stable package APIs unless they remove real duplication.
- Before adding/replacing a library, verify the current package docs and prove the new dependency removes code or risk. Modernization means using current APIs consistently, not library churn.

## Evidence From Current Audit

The following findings define this phase:

- Cross-feature presentation imports remain:
  - `lib/features/home/presentation/pages/home_page.dart` imports search presentation state.
  - `lib/features/home/presentation/widgets/home_video_actions.dart` imports video presentation overlay code.
  - `lib/features/home/presentation/widgets/live_view.dart` imports live presentation state.
  - `lib/features/profile/presentation/widgets/user_dynamic_tab.dart` imports dynamic presentation widget and state.
- Manual provider declarations remain in:
  - `lib/core/session/user_providers.dart`
  - `lib/core/session/search_providers.dart`
  - `lib/core/session/relation_providers.dart`
  - `lib/core/session/feature_action_providers.dart`
  - `lib/core/session/session_lifecycle_providers.dart`
  - `lib/core/data/network/network_quality_policy.dart`
  - `lib/core/services/audio_handler.dart`
- Feedback is still split across `ScaffoldMessenger`, `ToastUtils`, and feature-local calls.
- `AppException` is already gone in the current working tree; Phase 21 must verify this and not reintroduce a second error hierarchy.
- Current DTO/domain debt must be verified from the working tree before execution. A fresh scan shows the clearest remaining violation is `lib/features/dynamic/domain/entities/dynamic_extension.dart` importing `features/dynamic/data/dtos/dynamic_response.dart`; older response-shaped domain files may already have been moved into `data/dtos/`.
- Manual provider declarations with runtime `UnimplementedError` stubs remain in core session/network surfaces, especially `user_providers.dart`, `relation_providers.dart`, `session_lifecycle_providers.dart`, and `network_quality_policy.dart`.
- Feature boundaries remain leaky where presentation imports app routes or another feature entry directly, including `home_app_bar.dart` importing auth login action and feature scopes exporting presentation code.
- Some names still collide conceptually, including `DefaultSearch`, `PrivateMessageSummaryKind`, `UserProfileInfo`, `DanmakuView`, `PrivateSessionList`, and `VideoSubtitle`.
- Top-level exceptions need explicit guard policy: `lib/main.dart`, `lib/protos/`, `lib/ui/ui.dart`, and feature root files such as `auth/login_dialog_action.dart`.
- `lib/ui/ui.dart` is now documented as the single approved UI public API because multiple app, feature, and UI-overlay entry points consume shared UI components from it.
- `test/` and `integration_test/` are absent in the current checkout, so architecture guards must be created or restored before they can be used as verification.
- The current audit is intentionally not enough for execution. Task 1 must produce a repo-wide inventory of duplicate owners, zero-value wrappers, dead files, pass-through directories, and remaining barrel/public API surfaces before implementation proceeds.
- Core dependency versions are already modern. Only small evidence-backed version chores are in scope:
  - `drift` / `drift_dev`: `^2.31.0` to `^2.33.0`
  - `drift_flutter`: `^0.2.8` to `^0.3.0`
  - `retrofit_generator`: `^10.2.1` to `^10.2.6`
  - `json_serializable`: `^6.13.0` to `^6.13.2`

## Work Items

### WI-1: Lock Planning State and Guards

Archive Phase 20, keep Phase 21 as the only active architecture plan, and add architecture guard tests/scripts before deeper changes.

Acceptance:
- Phase 20 docs are under `docs/specs/archive/` and `docs/plans/archive/`.
- `CLAUDE.md` points only to Phase 21.
- Guard coverage exists for cross-feature imports, DTO/domain placement, raw feedback calls, duplicate error hierarchy, and unauthorized barrel files.
- A repo-wide inventory lists duplicate owners, zero-value wrappers, dead code candidates, pass-through directories, and approved public API surfaces.

### WI-2: Remove Cross-Feature Presentation Coupling

Replace feature-to-feature presentation imports with stable ports or approved route/composition boundaries.

Acceptance:
- `features/*/presentation/**` does not import another feature's `presentation/**`.
- `features/*` does not import another feature's `data/**`.
- Home/profile integrations use `core/contracts` ports or route entries instead of concrete widgets/view models from other features.

### WI-3: Unify Feedback and Error Reporting

Make `AppError` the single error hierarchy and `AppFeedback` the single user-facing feedback pattern.

Acceptance:
- No `AppException` references.
- No feature-local `ScaffoldMessenger.of(...)` calls.
- `ToastUtils` is deleted or reduced to a compatibility-free implementation detail with no direct feature imports.
- Error mapping remains centralized in `core/errors/`.

### WI-4: Move API Response Shapes Out of Domain

Move response/DTO-shaped domain files into feature `data/dtos/` and keep domain entities behavioral.

Acceptance:
- No `fromJson`, `toJson`, `JsonKey`, `Response`, `Request`, or `Dto` shaped code remains in `features/*/domain/entities/`.
- Mappers convert DTOs into domain entities where behavior or durable app semantics exist.
- Simple features may omit `domain/` when they only pass through API data.
- Empty/pass-through `data/`, `application/`, `domain/`, and `presentation/` directories are removed or justified by concrete behavior.

### WI-5: Normalize Provider Ownership

Migrate remaining hand-written providers to generated providers where useful and document allowed bootstrap exceptions.

Acceptance:
- Generated `@riverpod` providers are used for ordinary services, repositories, controllers, and policies.
- Remaining hand-written providers have a local comment explaining why override/bootstrap behavior requires them.
- No new `StateNotifierProvider`; Notifier and AsyncNotifier are the default for mutable state.

### WI-6: Resolve UI Public API and Naming Collisions

`lib/ui/ui.dart` is sanctioned as the single public UI API because it aggregates only shared `ui/` components and is already used by app, feature, and UI-overlay entry points. Rename colliding concepts so code search returns one obvious type per concept.

Acceptance:
- `ui.dart` is documented and guarded as the only UI public barrel.
- Names that collide only because of UI widgets are renamed to widget-specific names.
- True model duplicates are merged into one canonical contract/entity.

### WI-7: Dependency and Codegen Modernization

Apply only evidence-backed package updates and verify generated output.

Acceptance:
- `flutter pub outdated` and current package docs are reviewed before dependency changes.
- Drift, drift_flutter, drift_dev, retrofit_generator, and json_serializable are updated only if `dart pub get`, build_runner, analyzer, and generated diff review pass.
- Existing modern stack usage is completed consistently: Riverpod generator for ordinary providers, go_router_builder for typed routes, Retrofit for API clients, Drift DAOs for persistence queries, and Freezed/JSON for DTO/contract serialization.
- No broad routing/state/database rewrites are introduced for novelty.
- Drift remains type-safe and repository-facing; DAOs own persistence queries.

## Out of Scope

- Visual redesign.
- Rewriting all routing.
- Replacing Riverpod, Dio, Retrofit, Freezed, Slang, or go_router_builder.
- Adding new architecture layers just to satisfy Clean Architecture ceremony.
- Compatibility shims for pre-Phase 21 internal imports.
- Large storage migration unless Drift version verification proves one is required.

## Success Criteria

- One active architecture spec and plan.
- Phase 20 is archived and cannot be mistaken as active work.
- `dart analyze` passes.
- `dart run build_runner build --delete-conflicting-outputs` succeeds.
- `flutter test` runs architecture guards.
- `flutter build apk --debug` succeeds.
- Guard scripts/tests prove:
  - no forbidden cross-feature presentation/data imports,
  - no DTOs in domain,
  - no duplicate error hierarchy,
  - no raw feedback calls outside the approved feedback implementation,
  - no unauthorized re-export-only files.
- Repo-wide inventory is resolved or tracked in `bd`: no unreviewed duplicate owners, zero-value wrappers, pass-through directories, or dead code candidates remain.
- Dependency modernization is evidence-backed and does not replace stable package APIs with new app-specific wrappers.
