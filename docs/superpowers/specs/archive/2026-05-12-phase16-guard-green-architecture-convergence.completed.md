# Phase 16: Guard-Green Architecture Convergence

**Status:** Completed  
**Date:** 2026-05-12  
**Supersedes:** Phase 15 (superseded after partial landing)

## Problem Statement

Phase 15 landed useful cleanup, but the architecture baseline needed a truth-and-guard pass to stay safe:

1. `flutter test test/architecture --reporter compact` was failing 7 tests at phase start.
2. `docs/architecture/architecture-guide.md` does not record the Phase 13-15 rollover truth.
3. Archived Phase 13/14 spec and plan files still claimed `Status: Active`.
4. Phase 15 was still active in `CLAUDE.md` even though its success criteria are not fully proven.
5. Direct imports of `core/bootstrap/providers/*` remain scattered through core and features, so runtime dependency ownership is still leaky.
6. Some older Phase 9 guards assert stale implementation details such as `followListServiceProvider` in `root_overrides.dart`.
7. Dependency modernization has moved forward, but a narrow uplift/audit pass remains for packages such as `dio_cache_interceptor`, `drift`, `go_router`, `go_router_builder`, and `build_runner`.

## Verification

- `flutter test test/architecture --reporter compact` passes.
- `docs/architecture/architecture-guide.md`, `CLAUDE.md`, and the active Phase 16 spec/plan agree on the current baseline.

## Design Principles

- **Truth before cleanup**: Red guards and stale docs are architecture debt. Fix or supersede them before claiming another phase complete.
- **One active baseline**: `CLAUDE.md`, `docs/architecture/architecture-guide.md`, active spec, and active plan must agree.
- **Guard behavior, not fossilized names**: Architecture tests should enforce ownership boundaries and public seams, not require old provider names after refactors.
- **Mainstream APIs only when they reduce surface area**: Riverpod 3 generated providers, `Notifier`/`AsyncNotifier`, typed `go_router_builder` routes, Drift, Dio, and generator-based models remain preferred. Do not rewrite working generated routing.
- **Single source of truth**: Provider ownership, shared contracts, feature seams, and docs must have one canonical place.

## Target State

1. `test/architecture` passes.
2. Phase 13, 14, and 15 are archived with honest statuses.
3. Phase 16 is the only active architecture baseline.
4. `docs/architecture/architecture-guide.md` records Phases 13-16 and current failure/target state.
5. Runtime/bootstrap dependency ownership is explicit:
   - `app/runtime/root_overrides.dart` may bind runtime objects.
   - Feature/data code should not directly depend on app-owned bootstrap provider stubs unless a documented core seam exists.
   - Tests assert the ownership rule rather than stale provider names.
6. Dependency cleanup remains narrow and evidence-based:
   - remove only direct dependencies with confirmed zero runtime/generator need,
   - uplift packages in small batches,
   - keep typed routes because the repo already uses `go_router_builder`.

## Explicit Non-Goals

- Do not redesign UI.
- Do not replace `go_router_builder`; route generation is already modern.
- Do not re-run Phase 15 as a new broad dead-code sweep.
- Do not remove plugin companion packages such as `media_kit_libs_video` or `sqlite3_flutter_libs` just because they have no Dart imports.
- Do not mark Phase 15 completed unless architecture guards are green and docs agree.

## Required Evidence

- `flutter test test/architecture --reporter compact`
- `flutter analyze`
- `dart pub outdated --json` or a summarized equivalent before dependency uplift
- `rg -n "Active spec|Active plan|Phase 15|Phase 16|Status:\\*\\* Active" CLAUDE.md docs/architecture docs/superpowers`
- `gitnexus_detect_changes()` before commit, per repo instructions

## Context7 Notes

Context7 Riverpod docs confirm generated provider patterns through `@riverpod` and generated Notifier classes. Future Riverpod work in this phase should prefer generated providers and `Notifier`/`AsyncNotifier` over new hand-written provider glue.

Context7 go_router docs confirm the repo's typed/generated routing direction remains valid. Phase 16 should preserve existing `go_router_builder` usage unless a concrete route seam fails.
