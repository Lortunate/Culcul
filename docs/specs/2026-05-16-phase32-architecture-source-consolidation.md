# Phase 32 Architecture Source Consolidation Spec

## Status

Active.

Supersedes:

- `docs/specs/archive/2026-05-16-phase31-architecture-excellence.superseded.md`
- `docs/plans/archive/2026-05-16-phase31-architecture-excellence.superseded.md`

## Goal

Make Culcul easier to read and maintain by removing duplicate architecture truths, collapsing zero-value wrappers, enforcing feature boundaries, and turning remaining presentation-to-data leakage into explicit application/domain seams.

## Context

The current clean baseline is already modern in the broad tooling sense:

- `lib/shared/` is retired.
- authored source has no hand-written Riverpod provider declarations in the old `final xProvider = Provider(...)` style.
- the project uses Riverpod 3 generated providers, Freezed 3, `go_router`/`go_router_builder`, Retrofit, Drift, Dio, and Slang.
- Phase 22-30 specs/plans are archived, and Phase 31 established the current docs tree after a prior cleanup commit removed historical docs.

The remaining problem is semantic source-of-truth drift. Data DTOs, application state, view contracts, navigation contracts, and persistence helpers are still too easy to confuse. A recent snapshot found:

- `presentation -> data` imports still present.
- no `lib/shared/` files.
- no authored hand-written Riverpod provider declarations.
- large mixed-responsibility candidates including notification repository/persistence/mapper files, video presentation files, audio handler, and home widgets.

## Current Library Direction

Use current project dependencies and modern APIs rather than adding compatibility layers:

- Riverpod 3: keep `@riverpod` generated providers and `Notifier`/`AsyncNotifier` classes. UI handles `AsyncValue` with exhaustive Dart 3 `switch`/pattern matching where useful.
- Freezed 3: use primary-constructor immutable classes for DTOs/domain/view state when equality, `copyWith`, or JSON is real value. Use sealed unions only for real state machines.
- go_router 17 plus `go_router_builder`: keep typed/generated route definitions. Do not replace routing with ad hoc string navigation.
- Retrofit/Dio/Drift/Slang: keep generated integration points. Remove duplicate hand-written wrappers only when generated APIs already provide the real source of truth.

## Target Architecture

`lib/` remains:

- `app/`: bootstrap, router, shell, root overrides, app-level composition only.
- `core/`: cross-feature contracts, infrastructure, services, errors, runtime policy, persistence primitives.
- `features/`: feature-owned application/data/domain/presentation code.
- `ui/`: reusable UI primitives and approved UI public API.
- `i18n/`: localization source/generated files.
- `protos/`: protobuf-generated integration surface.

Feature internals use these rules:

- `data/` owns APIs, DTOs, persistence tables/DAOs, repository implementations, and mappers from transport/storage to app-facing state.
- `application/` owns Riverpod controllers, commands, workflows, and view-facing state that coordinates data/domain for presentation.
- `domain/` exists only when it carries real business semantics. Do not keep empty domain folders or pass-through entities.
- `presentation/` imports application/domain/core/ui surfaces, not feature-private data files.
- feature public files exist only when they are a real route/API seam. No typedef-only files, alias providers, or barrel chains.

## Scope

Phase 32 is allowed to make large refactors and break old internal APIs. It does not need compatibility wrappers for old paths or old class names.

### Slice 1: Active Truth and Guard Baseline

Replace Phase 31 as the active planning source. Add or tighten architecture guards so the next implementation slices have red/green feedback instead of relying on manual grep.

Acceptance:

- `CLAUDE.md` and `docs/architecture/architecture-guide.md` point to Phase 32 only.
- Phase 31 active spec/plan files are archived as superseded.
- architecture tests include source checks for presentation-to-data imports, zero-value wrapper files, and feature-private imports.
- guard output names the offending files or the current allowlist.

### Slice 2: App Boundary and Auth Session Source Split

Remove app-layer imports of feature presentation internals and split auth session state from login UI state.

Acceptance:

- `app/` depends on app/core/feature public seams, not feature `presentation/**`.
- root overrides use approved core/session or feature public APIs.
- auth application providers do not import auth presentation view models.
- session state has one owner and one public read/write path.

### Slice 3: Presentation-to-Data Boundary Burn-down

Remove direct data imports from presentation in feature slices, starting with high-value and already-visible leaks: live, profile, video, favorites, notification, to_view, settings, and history.

Acceptance:

- presentation widgets/pages/view models stop importing `features/<same-feature>/data/**` unless a temporary allowlist entry explains why.
- view-facing contracts live in `application/`, `domain/`, or `core/contracts/` according to reuse scope.
- data DTOs remain in `data/dtos/`; domain/view types are not transport DTO aliases.
- each completed feature slice decreases the guard count.

### Slice 4: One Contract Per Concept

Consolidate duplicate or near-duplicate models into the narrowest truthful owner.

Acceptance:

- cross-feature concepts live in `core/contracts/`.
- feature-local concepts live in the feature and are not redefined in core.
- no model is duplicated as DTO, entity, and view object unless each layer has different fields or behavior.
- mappers are explicit at real boundaries and deleted where they only copy identical fields.

### Slice 5: Controller and Workflow Normalization

Standardize presentation orchestration around generated Riverpod controllers/workflows.

Acceptance:

- old `presentation/view_models` files are moved to `application/` or deleted when they only proxy a repository.
- stateful workflows use `@riverpod` `Notifier`/`AsyncNotifier` where state is owned by the app.
- one-shot commands stay as small application functions/providers.
- UI does not call repositories directly.

### Slice 6: Large File Decomposition

Split only files with mixed responsibilities. Do not split by arbitrary line-count alone.

Initial candidates:

- `lib/features/notification/data/notification_repository_impl.dart`
- `lib/features/notification/data/notification_message_persistence.dart`
- `lib/features/notification/data/notification_mapper.dart`
- `lib/features/video/presentation/player/controls/player_settings_sheet.options.dart`
- `lib/features/video/presentation/comments/comment_reply_page.dart`
- `lib/core/services/audio_handler.dart`
- `lib/features/home/presentation/widgets/live_view.dart`
- `lib/features/home/presentation/widgets/recommend_view.dart`

Acceptance:

- each extracted file has one responsibility and a direct name.
- no new barrel chains appear.
- tests/guards still prove import legality.

### Slice 7: Dead Code and Zero Wrapper Removal

Delete pass-through code that exists only to preserve old architecture names.

Acceptance:

- no typedef-only files.
- no re-export-only files except generated/library entrypoints explicitly listed in the architecture guide.
- no alias-only providers.
- no empty domain/application/data folders kept for symmetry.
- route/public entry files stay only where external callers need a stable seam.

### Slice 8: Codegen and Command Source of Truth

Keep one command path for generated code and one documented recovery path.

Acceptance:

- `build_runner`, Slang, Retrofit, Riverpod, Freezed, and Drift generation commands are documented in one place.
- generated files are either checked in per project policy or explicitly recoverable.
- analyzer failures caused by missing generated files list exact missing paths before code is redesigned around them.

## Non-Goals

- No UI redesign.
- No replacement of Riverpod, Freezed, Retrofit, Drift, Dio, Slang, or go_router.
- No compatibility wrappers for old internal imports.
- No abstract repository interfaces unless mocking or polymorphism needs them.
- No domain layer for simple CRUD/pass-through features.
- No large generated-file rewrite unless regeneration is required by changed source.

## Success Criteria

- `flutter test test/architecture --reporter compact` passes.
- `flutter analyze --no-fatal-infos` passes, or any blocker is documented with exact generated files/commands.
- presentation-to-data import count is lower after every completed slice and reaches zero or a documented temporary allowlist.
- `rg -n "final .*Provider = (Provider|FutureProvider|StreamProvider|StateProvider|StateNotifierProvider|AsyncNotifierProvider)" lib --glob "*.dart" -g "!*.g.dart" -g "!*.freezed.dart"` remains zero.
- `find lib/shared -type f` remains empty.
- active docs point only to Phase 32.
