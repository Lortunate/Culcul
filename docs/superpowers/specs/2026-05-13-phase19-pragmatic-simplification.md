# Phase 19: Pragmatic Simplification & Dead Weight Removal

**Status:** Active  
**Date:** 2026-05-13  
**Supersedes:** Phase 18 (landed — barrel elimination, freezed/@riverpod migration, model dedup complete)

## Problem Statement

Phase 18 eliminated structural debt (barrel files, hand-written providers, model duplication). The codebase is now architecturally sound, but still carries pragmatic dead weight that increases cognitive load without providing value:

1. **Unused dependency: `responsive_framework`** — installed and wrapped around the widget tree, but never queried at runtime. All responsive logic uses a custom `AppResponsive` extension with `MediaQuery.sizeOf`. The package adds startup overhead and a misleading abstraction layer.

2. **Thin repository interfaces with no testing/polymorphic value** — 5 interfaces (HomeRepository, SettingsRepository, ToViewRepository, DanmakuRepository, RelationRepository) have 3-4 methods each, a single implementation, and no mock usage in tests. They exist purely for "clean architecture" ceremony.

3. **Redundant domain entity: `RankingVideo`** — a strict subset of `VideoModel` (7 of 9 fields, flattened). The ranking feature already receives `VideoModel` from the API layer and maps it into this entity by discarding fields. The UI could consume `VideoModel` directly.

4. **Dead proto files** — `dm.pbserver.dart` and `dm.pbjson.dart` are generated server-side stubs never imported by client code.

5. **Near-dead constants file** — `app_dimens.dart` has only 3 consumers across the entire codebase. The rest of the project uses inline values or theme-based spacing.

6. **Naming inconsistency** — `HomeFeedDataSource` implements `HomeRepository` but doesn't follow the `*RepositoryImpl` naming convention used by all other features.

7. **Hardcoded placeholder strings** — `uploader_section.dart` displays fake follower/video counts visible to users.

## Target State

1. **Zero unused dependencies** — every package in pubspec.yaml is actively consumed at runtime or build time.

2. **No ceremony-only abstractions** — repository interfaces exist only where they enable testing (mocking) or polymorphism (multiple implementations). Simple features that just fetch-and-display have no interface layer.

3. **Minimal domain entities** — if a domain entity is a strict subset or 1:1 copy of a DTO/contract, eliminate it. Features consume the contract directly.

4. **Zero dead code** — no unreachable files, no placeholder implementations visible to users.

5. **Consistent naming** — all repository implementations follow `*_repository_impl.dart` naming.

6. **Simplified feature structure** — simple features (ranking, history) that have no business logic in their domain layer collapse `domain/entities/` into a flat structure or consume core contracts directly.

## Design Principles

- **Remove over refactor**: If something adds no value, delete it. Don't reorganize dead weight.
- **Consume contracts directly**: If the API returns data matching a core contract shape, use the contract in the UI. Don't create a domain entity that's just a field rename.
- **Interfaces earn their keep**: An interface must enable at least one of: mocking in tests, multiple implementations, or cross-feature polymorphism (port pattern). Otherwise, delete it.
- **Flat over nested**: A feature with no business logic doesn't need a `domain/` layer. Data → Presentation is fine.
- **Consistent over clever**: Same pattern, same naming, everywhere.

## Scope

**In scope:**
- Remove `responsive_framework` dependency (keep custom responsive extension)
- Remove thin repository interfaces (home, settings, to_view, danmaku, relation)
- Eliminate `RankingVideo` entity (use `VideoModel` directly)
- Delete dead proto files (`dm.pbserver.dart`, `dm.pbjson.dart`)
- Inline `app_dimens.dart` usages and delete
- Rename `HomeFeedDataSource` → `HomeRepositoryImpl`
- Remove `HomeRepository` interface (collapse into impl)
- Fix hardcoded placeholder in `uploader_section.dart`
- Collapse ranking feature's `domain/entities/` (entity eliminated)
- Remove `fixnum` dependency if no longer needed after proto cleanup

**Out of scope:**
- ProfileVideo entity (genuinely different shape — superset with 8 extra fields)
- DynamicVideoContent entity (genuinely different — pre-formatted display strings)
- HistoryEntry entity (genuinely different — watch-session record)
- Large repository interfaces (auth, favorites, notification, video, dynamic, live, search, profile)
- Core session providers (justified override-at-bootstrap pattern)
- UI/widget refactoring
- New feature development

## Verification

- `dart run build_runner build --delete-conflicting-outputs` — no errors
- `dart analyze` — no new warnings
- `flutter test test/architecture --reporter compact` — all pass (update guards if needed)
- `flutter test` — full test suite passes
- `grep -r "responsive_framework" lib/` returns nothing
- `grep -r "HomeRepository" lib/` returns only the impl class name
- No `.pbserver.dart` or `.pbjson.dart` files in `lib/protos/`

## Risk Assessment

- **Architecture test breakage**: Removing domain/repositories/ for some features may trip guard tests that enforce layer boundaries. Tests need scoping adjustments.
- **Import graph changes**: Consumers of removed interfaces need updating. Low risk since each interface has exactly one implementation.
- **Ranking UI impact**: Switching from `RankingVideo` to `VideoModel` means the UI accesses `model.owner.name` instead of `model.ownerName`. Straightforward but touches multiple widgets.
