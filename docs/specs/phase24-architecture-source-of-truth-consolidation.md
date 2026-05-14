# Phase 24 Architecture Source-of-Truth Consolidation Spec

## Status

Active on 2026-05-14.

Supersedes:

- `docs/specs/archive/2026-05-14-phase22-performance-runtime-optimization.superseded.md`
- `docs/plans/archive/2026-05-14-phase22-performance-runtime-optimization.superseded.md`
- `docs/specs/archive/2026-05-14-phase23-aggressive-performance-optimization.superseded.md`

## Context

Culcul has already removed `lib/shared/`, retired abstract repository layers, adopted freezed/Riverpod generation broadly, and concentrated shared contracts under `core/contracts/`.

The current checkout still has architecture debt that makes the app harder to change:

- 891 Dart files under `lib/`, with most code in `features/`.
- 148 Riverpod/generated files, but some app/session seams still expose placeholder provider contracts.
- 8 files still contain `UnimplementedError`/`TODO()` placeholders:
  - `lib/core/bootstrap/providers/cache_store_provider.dart`
  - `lib/core/bootstrap/providers/cookie_jar_provider.dart`
  - `lib/core/bootstrap/providers/storage_provider.dart`
  - `lib/core/session/feature_action_providers.dart`
  - `lib/core/session/relation_providers.dart`
  - `lib/core/session/search_providers.dart`
  - `lib/core/session/session_lifecycle_providers.dart`
  - `lib/core/session/user_providers.dart`
- 5 presentation files still have TODO/FIXME comments.
- Phase 22 introduced runtime/network policy work, but left build/config/final verification incomplete.
- A Phase 23 performance draft existed without an implementation plan, creating a second planning source.

Phase 24 consolidates the app architecture around one source of truth per concept before more feature work.

## Goals

1. Make active architecture docs, code directories, and provider seams agree.
2. Remove zero-implementation wrappers, placeholder providers, stale TODO-only seams, and re-export chains that do not enforce a real public API.
3. Keep exactly one authoritative type/service/provider for each shared concept.
4. Finish Phase 22 build/config/verification closeout inside this broader cleanup.
5. Prefer current popular libraries already in the stack before adding new ones:
   - Flutter official architecture/performance guidance: profile first, use lazy lists, avoid unnecessary rebuilds, and keep heavy work off the UI thread.
   - Riverpod 3 generated `@riverpod` providers with `Notifier`/`AsyncNotifier` for new or rewritten state.
   - Dio 5 `BaseOptions`, interceptors, `CancelToken`, `QueuedInterceptor`, and client lifecycle cleanup instead of custom duplicated network policy code.
6. Preserve product behavior while allowing breaking code-level refactors.

## Non-Goals

- No UI redesign.
- No routing rewrite unless a route seam is proven redundant or broken.
- No offline-first product mode.
- No new monitoring/cache/image dependency until existing stack duplication is removed.
- No compatibility shim for old internal APIs after call sites are migrated.

## Target Architecture

### Directory Boundaries

- `app/`: bootstrap, routing, root provider overrides, lifecycle composition.
- `core/`: cross-feature contracts, networking, persistence, runtime policy, reusable services, app-wide errors/session abstractions.
- `features/<feature>/`: feature-owned data, domain only when useful, presentation, and feature public seams.
- `ui/`: reusable visual primitives only; no feature imports.
- `i18n/` and generated files remain implementation infrastructure, not business seams.

`core/` and `ui/` must never import `features/`. Features must not import another feature's `presentation/**` or `data/**` internals.

### Public Seams

Allowed public seams:

- `route_entry.dart` for router integration.
- `feature_scope.dart` for runtime/provider composition.
- `<feature>.dart` only when it exports a real feature API.
- `core/contracts/core_contracts.dart` and `lib/ui/ui.dart` as the only approved barrel-like files.

Everything else should be imported from the owning source file.

### State And Providers

- New or rewritten state uses `@riverpod`.
- Stateful logic uses generated `Notifier`/`AsyncNotifier` when mutation or async lifecycle exists.
- Function providers are allowed only for simple pure dependencies.
- No placeholder provider may throw `UnimplementedError` in normal app code.
- Root overrides must bind real implementations or be deleted with their consumers.

### Data And Networking

- `Dio` setup owns global `BaseOptions`, lifecycle cleanup, interceptors, cancellation, retry/cache policy, and endpoint policy.
- Repositories express request intent through one request execution path.
- Do not keep local catch/map boilerplate when `RequestExecutor` can express the same behavior.
- Retrofit APIs remain feature-owned unless an endpoint is truly shared across features.

### Models And Errors

- DTOs live in `data/dtos/`.
- Shared models live once in `core/contracts/`.
- Domain entities exist only when they contain business meaning beyond transport shape.
- `AppError` is the single app error hierarchy. Do not recreate `AppException` or local parallel errors.

## Success Criteria

- Active pointers in `CLAUDE.md`, this spec, the plan, and `docs/architecture/architecture-guide.md` match.
- No `UnimplementedError`/`TODO()` remains in provider/bootstrap/session seams.
- No accidental `core/` or `ui/` import of `features/`.
- No feature imports another feature's private `data/**` or `presentation/**`.
- Barrel-like files are limited to `core_contracts.dart` and `ui.dart`.
- Phase 22 incomplete build/config/final verification items are closed or explicitly deleted as obsolete.
- Analyzer, codegen/localization, targeted architecture tests, and relevant feature tests pass before merge.

## Verification

- Run GitNexus impact analysis before editing each symbol.
- Run generated code and localization after provider/model changes:
  - `dart run slang`
  - `dart run build_runner build --delete-conflicting-outputs`
- Run architecture checks:
  - boundary import checks
  - provider placeholder scan
  - barrel scan
  - TODO/FIXME scan for touched areas
- Run focused Flutter tests for each migrated slice.
- Run `gitnexus_detect_changes()` before commit.
