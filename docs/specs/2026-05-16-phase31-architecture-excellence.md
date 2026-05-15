# Phase 31 Architecture Excellence Spec

## Status

Active.

## Context

Phase 30 completed the top-level cleanup. The current baseline is still `app/` + `core/` + `features/` + `ui/`, with `lib/shared/` retired and no hand-written Riverpod provider declarations found in authored source. The next work is not another directory rewrite. It is semantic cleanup: remove remaining presentation-to-data coupling, preserve one source of truth for view-facing models, reduce mixed-responsibility files, and keep generated/provider code on modern APIs.

Phase 31 re-establishes active planning docs as the current source of truth on a clean branch based on the completed Phase 30 baseline. Older Phase 22-30 docs remain archived historical context, not active plans.

Relevant modern-library direction:

- Riverpod 3 work uses `@riverpod` generated functions/classes and `Notifier`/`AsyncNotifier` patterns. Do not add hand-written `Provider`, `FutureProvider`, `StateNotifierProvider`, or alias-only provider files.
- Freezed 3 remains the default for immutable DTO/domain state where generated equality/copy/JSON removes boilerplate. Use sealed Freezed unions only for real state machines, not simple data bags.
- Keep typed `go_router_builder` routing and existing generated routes unless a route seam is broken.

## Goals

1. Make `presentation/` depend on view/domain contracts instead of raw `data/dtos` or repositories.
2. Keep one real model definition per concept. If a DTO is also the view model, explicitly promote it to a domain/view contract or keep it in data and map at the boundary.
3. Remove or split remaining zero-value wrappers, pass-through aliases, and no-op workflow states where behavior is not meaningful.
4. Decompose the largest mixed-responsibility files only where the split creates an obvious ownership boundary.
5. Add architecture guards so the cleaned rules stay enforced.
6. Keep build/codegen entry points simple and singular.

## Non-Goals

- No broad visual redesign.
- No replacement of Riverpod, Freezed, Retrofit, Drift, or go_router.
- No compatibility layer for old architecture names.
- No feature rewrite unless required to remove coupling.
- No new abstract repositories unless tests or polymorphism need them.

## Target Slices

### Slice 1: Planning and Guard Baseline

Recreate the active docs and architecture guide. Capture the current coupling counts and add/refresh architecture tests for:

- `core/` and `ui/` must not import `features/`.
- `presentation/` must not import same-feature `data/` unless the file is explicitly allowlisted while being migrated.
- no hand-written provider declarations are introduced.
- active docs point to Phase 31 only.

### Slice 2: Settings and History Boundary Cleanup

Settings and history still let presentation import data repositories/DTOs directly. Move the view-facing types/providers to application/domain surfaces or collapse them intentionally if there is no business distinction.

Acceptance:

- `settings/presentation` imports no `settings/data`.
- `history/presentation` imports no `history/data`.
- repository construction remains generated/provider-based.

### Slice 3: Live and Dynamic DTO Exposure Cleanup

Live and dynamic presentation widgets import many DTO files directly. Introduce explicit view/domain contracts or mappers where they simplify ownership.

Acceptance:

- live danmaku widgets consume presentation/domain message contracts, not raw socket DTOs.
- dynamic detail widgets consume stable view contracts, not `dynamic_response.dart` directly.
- no duplicate model definitions for the same fields.

### Slice 4: Notification Navigation and Persistence Separation

Notification data remains a large cluster with navigation parsing, persistence, and mapping concerns close together.

Acceptance:

- navigation-facing notification link/state types are not data DTOs.
- persistence code owns storage details only.
- mapper files stay cohesive and tested.

### Slice 5: Large File Decomposition

Split only high-value files that mix unrelated responsibilities. Current candidates include:

- `notification_repository_impl.dart`
- `player_settings_sheet.options.dart`
- `comment_reply_page.dart`
- `audio_handler.dart`
- `live_socket_service.dart`
- `wbi_helper_provider.dart`

Acceptance:

- each split has a clear naming/ownership reason.
- no new barrel-chain or alias-only files.
- focused tests or analyzer cover touched paths.

### Slice 6: Codegen and Dependency Source of Truth

Audit `build.yaml`, scripts, and generated files so each generator has one invocation path.

Acceptance:

- localization/codegen commands are documented in one place.
- no duplicate generation entry point with conflicting responsibility.
- generated files are regenerated or deliberately excluded according to project policy.

## Success Criteria

- `flutter analyze --no-fatal-infos` passes or only reports pre-existing generated-artifact blockers that are listed with exact missing files.
- `flutter test test/architecture --reporter compact` passes.
- `rg -n "import .*package:culcul/features/.*/data" lib/features/*/presentation` decreases each slice and is zero outside approved temporary allowlist by the end of Phase 31.
- `rg -n "final .*Provider = (Provider|FutureProvider|StreamProvider|StateProvider|StateNotifierProvider|AsyncNotifierProvider)" lib` stays empty for authored source.
- New active docs are the only active spec/plan pointers.

## Risks

- Some DTOs may already be the practical UI contract. In that case, rename/move only when it improves ownership; do not create duplicate data classes for purity.
- Generated files may be missing from the local checkout. If codegen fails because files already exist or tools are missing, record exact files and rerun the smallest safe generator command.
- Large-file splits can create churn. Prefer boundary cleanup before cosmetic decomposition.
