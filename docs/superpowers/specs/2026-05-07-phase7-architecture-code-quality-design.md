# Phase 7: Architecture Optimization & Code Quality

**Status:** ACTIVE
**Date:** 2026-05-07
**Goal:** Restructure directories for navigability, eliminate architectural violations, unify error handling, harden core infrastructure, and improve code readability.

## Context

Phases 1-6 established a clean feature-module architecture with all 13 features at FULL compliance. However, the **internal organization** of `core/`, `ui/widgets/`, and `test/` has grown organically and needs restructuring. Additionally, 42 cross-feature imports violate the architecture rules, video domain entities are hollow DTO re-exports, and error handling is inconsistent.

This phase addresses both **structural organization** and **code-level quality** in a single pass.

## Problem Analysis

### P0: Directory Navigability

#### P0a: `core/` is a flat bag of 13 modules

```
lib/core/
  bootstrap/    constants/    contracts/    errors/
  hooks/        network/      pagination/   perf/
  result/       services/     session/      utils/
  core.dart
```

No logical grouping. A developer looking for "network stuff" must scan 13 entries. Related modules (e.g., `session/` and `contracts/`) are peers of unrelated ones (e.g., `perf/` and `hooks/`).

**Proposed grouping:**

```
lib/core/
  core.dart
  bootstrap/           # Platform init, provider overrides
  contracts/           # Shared type contracts
  data/                # Network, pagination, caching
    network/           # Dio, interceptors, request execution
    pagination/        # Paged list abstractions
  errors/              # Error types, handling
  session/             # Auth state, user session providers
  services/            # Media, audio services
  utils/               # Formatters, crypto, misc
  hooks/               # Shared hooks
  perf/                # Performance logging
  constants/           # API URLs, dimensions
```

Benefits: clear data-layer boundary, session/auth grouped, easier onboarding.

#### P0b: `ui/widgets/` is a flat bag of 33 widgets

33 top-level `.dart` files plus 6 subdirectories. No categorization. Finding "which widget shows a video card?" requires scanning all 33.

**Proposed grouping:**

```
lib/ui/widgets/
  ui_widgets.dart          # Barrel
  buttons/                 # follow_button, app_clickable, app_tag
  cards/                   # video_card/, video_list_card/, app_card_container
  feedback/                # app_error_widget, app_empty_state_widget, app_shimmer, privacy_error_widget
  inputs/                  # app_search_bar, app_selectable_text
  layout/                  # app_section_header, sliver_tab_bar_delegate, app_tab_bar, refresh_header_footer
  media/                   # app_network_image, app_network_image_prefetcher, video_thumbnail, app_image_preview, adaptive_blur
  overlays/                # app_bottom_sheet, app_overlay_tag, video_actions_bottom_sheet
  text/                    # bilibili_emoji_text, app_min_lines_text, icon_text, app_selectable_text
  users/                   # app_avatar, user_list_tile, user_tags, guest_view/
  comments/                # (existing subdirectory)
  skeletons/               # (existing subdirectory)
  smart_paging_view/       # (existing subdirectory)
```

Benefits: discoverability, clear ownership, easier to find related widgets.

#### P0c: `test/shared/` doesn't match new `lib/` structure

Tests still reference `shared/` paths (network, pagination, perf, services, widgets) even though `lib/shared/` was retired in Phase 3. Tests should mirror `lib/core/` and `lib/ui/`.

#### P0d: `main.dart` has 11 provider overrides inline

`main.dart` has grown to contain 11 `ProviderScope(overrides: [...])` entries. This should be extracted into a dedicated bootstrap configuration.

### P1: Cross-Feature Imports (42 violations)

The architecture rule: "Features must NOT import from other features."

42 direct cross-feature imports exist. Root cause: no shared contract for user session state. 21 of 42 are imports of `auth_view_model.dart`.

| Importing Feature | Imported Feature | What's Imported | Count |
|---|---|---|---|
| video, home, favorites, history, profile, notification, live, to_view, dynamic | **auth** | `auth_view_model.dart` | 21 |
| video | **profile** | `feature_scope.dart` | 1 |
| dynamic | **video** | widgets | 3 |
| dynamic | **search** | `topic_search_view_model.dart` | 2 |
| dynamic | **profile** | `recently_followed_view_model.dart` | 1 |
| home | **search** | `search_view_model.dart` | 1 |
| home | **to_view** | `to_view_view_model.dart` | 1 |
| home | **live** | `live_view_model.dart` | 1 |
| live | **auth** | domain + scope | 2 |
| live | **profile** | `live_room_view_model.dart` | 1 |
| notification | **profile** | view models | 2 |
| profile | **dynamic** | widgets | 2 |
| profile | **notification** | route | 1 |
| search | **dynamic** | page | 1 |
| favorites | **auth** | view model | 2 |

### P2: Domain Layer Purity (Video Feature)

All 7 entity files in `video/domain/entities/` are one-line re-exports of data DTOs:

```dart
// domain/entities/video_detail.dart
export '../../data/dtos/video_detail_dto.dart';
```

DTOs carry `@JsonKey`, `@JsonConverter`, `fromJson`/`toJson` — serialization models, not domain entities. Domain has zero independence from data layer.

### P3: Error Handling Inconsistency

Three patterns coexist:

- **Pattern A (good):** `result.when(success: ..., failure: ...)` — explicit branching
- **Pattern B (problematic):** `result.dataOrNull ?? []` — silent swallowing, user sees no error
- **Pattern C (dangerous):** `result.dataOrNull!` — 14 force-unwraps that crash on API failure

### P4: Core Infrastructure Bugs

1. **Pagination:** `loadNextPage` doesn't update `state` on empty result — UI becomes stale
2. **Audio handler:** Stream subscriptions in constructor never stored — memory leak
3. **Certificate validation:** `onBadCertificate = (_) => true` accepts all certs
4. **Token interceptor:** Cookie refresh errors silently swallowed
5. **CSRF cache:** No TTL, depends on external invalidation

### P5: Pattern Inconsistencies

1. `settings/feature_scope.dart` uses manual `Provider` (12/13 use `@riverpod` codegen)
2. `home/route_entry.dart` uses raw `export` instead of `buildXxxRoutePage()` functions
3. `home/data/home_feed_data_source.dart` named `DataSource` instead of `RepositoryImpl`

### P6: UI Quality

1. Zero `Semantics` in 30+ shared widgets
2. Hardcoded English in `AppSearchBar`
3. `AppNetworkImage` extends `ConsumerWidget` but never uses `ref`
4. `AppClickable` has 4 deprecated parameters
5. `FollowButton` wraps single `Text` in unnecessary `Row`

## Design

### 1. Core Reorganization (P0a)

Restructure `lib/core/` from 13 flat modules into 6 logical groups:

```
core/
  core.dart                    # Updated barrel
  bootstrap/                   # Unchanged
  contracts/                   # Unchanged + new contracts
  data/                        # NEW grouping
    network/                   # Moved from core/network/
    pagination/                # Moved from core/pagination/
  errors/                      # Unchanged
  session/                     # Unchanged + new providers
  services/                    # Unchanged
  utils/                       # Unchanged
  hooks/                       # Unchanged
  perf/                        # Unchanged
  constants/                   # Unchanged
```

Migration: move files, update all imports, update barrel exports, update tests.

### 2. UI Widget Reorganization (P0b)

Categorize 33 widgets into logical subdirectories (buttons, cards, feedback, inputs, layout, media, overlays, text, users). Keep existing subdirectories (comments, skeletons, smart_paging_view, guest_view) as-is.

### 3. Test Restructuring (P0c)

Move `test/shared/` tests to match new `lib/` paths:
- `test/shared/network/` → `test/core/data/network/`
- `test/shared/pagination/` → `test/core/data/pagination/`
- `test/shared/perf/` → `test/core/perf/`
- `test/shared/services/` → `test/core/services/`
- `test/shared/widgets/` → `test/ui/widgets/`

### 4. Bootstrap Simplification (P0d)

Extract provider overrides from `main.dart` into `app/bootstrap/provider_overrides.dart`.

### 5. Cross-Feature Decoupling (P1)

Create shared contracts in `core/contracts/`:
- `UserSession` interface (uid, isLoggedIn, avatar, name)
- `currentUserProvider` in `core/session/`
- Navigation action contracts for cross-feature actions

Migrate all 42 cross-feature imports to use contracts.

### 6. Video Domain Purity (P2)

Create proper plain Dart entities separate from DTOs. Add DTO→Entity mapping in data layer. Move presentation logic out of DTOs.

### 7. Error Handling Unification (P3)

Standardize on `result.when()`. Eliminate all 14 `dataOrNull!` force-unwraps. Replace silent swallowing with error state propagation.

### 8. Core Bug Fixes (P4)

Fix pagination state, audio handler leaks, certificate bypass gating, token interceptor logging, CSRF cache TTL.

### 9. Pattern Standardization (P5)

Convert settings to `@riverpod` codegen. Standardize home route_entry and data source naming.

### 10. Accessibility & UI Cleanup (P6)

Add `Semantics` to key widgets. Fix hardcoded English. Remove deprecated parameters. Simplify widget trees.

## Out of Scope

- Video feature decomposition (~155 files, controls/danmaku sub-engines)
- Search view model codegen migration
- Golden tests / integration tests
- `core/utils/` subdirectory splitting (keep flat)

## Verification

```bash
flutter analyze                    # No new warnings
flutter test                       # All tests pass
flutter test test/architecture/    # Architecture guards pass
make ci                            # Full CI pipeline
```

## Effort

Large. ~80-100 files modified across all features + core + ui + test. Highest risk is directory restructuring (import rewiring). Cross-feature decoupling is medium risk. Everything else is low risk.

## Risk Mitigation

- Each task is independently committable
- Run `flutter test` after each task
- Architecture guard tests verify structural rules
- Directory moves use `git mv` for history preservation
