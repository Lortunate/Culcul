# Architecture Guide

Post-refactoring architecture for Culcul (BiliBili 3rd-party client). `lib/shared/` is fully retired.

## Directory Structure

```
lib/
├── app/              # App shell, bootstrap, router
│   ├── bootstrap/    # App initialization, provider overrides
│   ├── router/       # go_router route definitions
│   └── shell/        # Main app shell (bottom nav, etc.)
├── core/             # Infrastructure, cross-cutting concerns
│   ├── bootstrap/    # Riverpod provider stubs for app dependencies
│   │   └── providers/ # CookieJar, CacheStore, Storage provider contracts
│   ├── constants/    # API constants, app dimensions
│   ├── contracts/    # Shared data contracts (VideoModel, UserCard, UserSession, etc.)
│   ├── data/         # Data layer infrastructure
│   │   ├── network/  # Dio client, interceptors, request executor
│   │   └── pagination/ # Paged list state, scroll triggers
│   ├── errors/       # Error types, ErrorHandler
│   ├── hooks/        # Reusable Flutter hooks
│   ├── perf/         # Frame sampling, startup tracing
│   ├── result/       # Result<T> type
│   ├── services/     # Audio handler, media service
│   ├── session/      # User session, auth state providers
│   └── utils/        # Formatters, crypto, validation
├── features/         # Feature modules (domain-driven)
│   ├── auth/
│   ├── dynamic/
│   ├── favorites/
│   ├── history/
│   ├── home/
│   ├── live/
│   ├── notification/
│   ├── profile/
│   ├── ranking/
│   ├── search/
│   ├── settings/
│   ├── to_view/
│   └── video/
├── i18n/             # Localization
├── protos/           # Protobuf definitions
└── ui/               # Design system, reusable UI
    ├── responsive/   # Responsive helpers
    ├── theme/        # Colors, theme definitions
    └── widgets/      # Categorized reusable widgets
        ├── buttons/      # Clickable, follow, tag
        ├── cards/        # Video card, list card, container
        ├── feedback/     # Error, empty, shimmer, privacy
        ├── inputs/       # Search bar
        ├── layout/       # Section header, tab bar, refresh
        ├── media/        # Network image, thumbnail, preview, blur
        ├── overlays/     # Bottom sheet, overlay tag
        ├── text/         # Emoji, min-lines, icon-text
        ├── users/        # Avatar, list tile, tags, guest view
        ├── comments/     # Comment items, reply sheet
        ├── skeletons/    # Loading skeletons
        └── smart_paging_view/ # Paginated list
```

## Layer Rules

### Dependency Direction

```
features/ → core/, ui/
app/      → features/, core/, ui/
core/     → (standalone, no feature imports)
ui/       → core/ (no feature imports)
```

### Bootstrap Architecture

Two-phase bootstrap: `app/bootstrap/` creates concrete instances imperatively, `core/bootstrap/providers/` defines Riverpod provider stubs. `main.dart` bridges them via `ProviderScope(overrides: [...])`.

- `app/bootstrap/app_bootstrap.dart` — platform init (Hive, cookies, cache, locale)
- `app/bootstrap/deferred_app_init.dart` — post-first-frame warmup (MediaKit)
- `core/bootstrap/providers/` — Riverpod stubs consumed by 17+ feature/core files

### Feature Structure

Each feature follows this pattern:

```
features/<name>/
├── application/      # Workflows, commands (orchestration logic)
├── data/             # API clients, repositories, DTOs
│   ├── dtos/
│   └── repositories/
├── domain/           # Entities, repository interfaces
│   ├── entities/
│   └── repositories/
├── presentation/     # UI layer
│   ├── pages/
│   ├── view_models/
│   └── widgets/
├── route_entry.dart  # Router-facing seam
└── feature_scope.dart # Feature-level provider scope
```

### Feature Structure Compliance

| Feature | route_entry | feature_scope | application/ | data/ | domain/ | presentation/ | barrel | Status |
|---------|:-----------:|:------------:|:------------:|:-----:|:-------:|:-------------:|:------:|:------:|
| auth    | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| dynamic | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| favorites | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| history | ✓ | ✓ | n/a | ✓ | ✓ | ✓ | ✓ | FULL |
| home    | ✓ | ✓ | n/a | ✓ | ✓ | ✓ | ✓ | FULL |
| live    | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| notification | ✓ | ✓ | no | ✓ | ✓ | ✓ | ✓ | PARTIAL |
| profile | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| ranking | ✓ | ✓ | n/a | ✓ | ✓ | ✓ | ✓ | FULL |
| search  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| settings | ✓ | ✓ | n/a | ✓ | ✓ | ✓ | ✓ | FULL |
| to_view | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| video   | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |

**Legend:** ✓ = present, `n/a` = not needed (simple CRUD features without orchestration logic), `no` = currently missing and tracked by the active phase. Notification still needs an explicit `application/` seam.

### Barrel Exports

Each feature exposes a `<feature>.dart` barrel file at its root. This is the public API surface for the feature. Other features must NOT import internal files directly — use the barrel export.

Example: `import 'package:culcul/features/auth/auth.dart';`

### Route Ownership

- `lib/app/router/app_routes.dart` is the top-level route graph
- Each feature exposes `route_entry.dart` as the router-facing seam
- Route entry files translate route params to page constructor args
- Route entry files are thin adapters — no workflow logic

### Orchestration Ownership

- Pages gather UI state and invoke one workflow/command object
- Mutation sequencing, login gating, branching → `application/`
- Shared widgets must not absorb feature workflows

## Migration History

The `lib/shared/` directory was retired across phases 0-3:
- **Phase 1**: Decoupled shared boundaries (auth, video, network)
- **Phase 2**: Route seams, orchestration extraction, provider normalization
- **Phase 3**: Structural moves (constants, utils, hooks, pagination, network, services, theme, widgets) — **COMPLETE** as of 2026-05-06

Archived docs: `docs/architecture/archive/`

## Phase 4 (Complete): CI/CD & Code Quality

Completed 2026-05-06. CI pipeline (GitHub Actions), Makefile, and coverage artifact upload.

Archived spec: `docs/superpowers/specs/archive/2026-05-06-phase4-ci-code-quality-design.completed.md`

## Phase 5 (Complete): Test Coverage & CI Hardening

Completed 2026-05-07. 270+ tests added, coverage at ~20%, CI coverage gate active.

Archived spec: `docs/superpowers/specs/archive/2026-05-06-phase5-test-coverage-ci-hardening-design.completed.md`
Archived plan: `docs/superpowers/plans/archive/2026-05-06-phase5-test-coverage-ci-hardening-plan.completed.md`

## Performance Optimization (Complete)

Completed 2026-05-07. Anti-pattern fixes, list rendering optimization, media pipeline optimization.

Archived spec: `docs/superpowers/specs/archive/2026-05-07-performance-optimization-design.completed.md`
Archived plan: `docs/superpowers/plans/archive/2026-05-07-performance-optimization.completed.md`

## Phase 6 (Complete): Architecture Optimization & Code Quality

Completed 2026-05-07. All 13 features normalized to FULL compliance, CLAUDE.md/AGENTS.md reconciled, lint rules tightened, barrel exports standardized.

Archived spec: `docs/superpowers/specs/archive/2026-05-07-phase6-architecture-optimization-design.completed.md`
Archived plan: `docs/superpowers/plans/archive/2026-05-07-phase6-architecture-optimization.completed.md`

## Phase 7 (Complete): Architecture Optimization & Code Quality

Completed 2026-05-07. Directory reorganization, cross-feature decoupling, error handling unification, accessibility.

Archived spec: `docs/superpowers/specs/archive/2026-05-07-phase7-architecture-code-quality-design.completed.md`
Archived plan: `docs/superpowers/plans/archive/2026-05-07-phase7-architecture-code-quality.completed.md`

**Completed:**
1. Core directory reorganization (`core/network/` + `core/pagination/` → `core/data/`)
2. UI widget categorization (33 widgets → 10 logical subdirectories)
3. Test restructuring (`test/shared/` → `test/core/` + `test/ui/`)
4. Bootstrap simplification (extracted provider overrides from `main.dart`)
5. Cross-feature decoupling (42 → 6 imports via core contracts)
6. Video domain purity (removed dead presentation getters, moved mapping to data layer)
7. Error handling unification (15 `dataOrNull ??` → explicit `result.when()`)
8. Core infrastructure fixes (pagination, audio, network — already done in prior phases)
9. Pattern standardization (home route_entry → function pattern)
10. Accessibility (Semantics on AppClickable, FollowButton, AppAvatar)

**Note:** A later 2026-05-08 audit found the residual cross-feature coupling was still materially larger than this closeout estimate. See Phase 8 for the refreshed current-state snapshot.

## Phase 8 (Complete): Architecture Rebaseline & Boundary Cleanup

Completed 2026-05-09. The refreshed Phase 8 pass closed the remaining direct presentation-boundary leaks, tightened app/core public seams, and finished the documentation rebaseline.

Archived spec: `docs/superpowers/specs/archive/2026-05-08-phase8-architecture-optimization-design.completed.md`
Archived plan: `docs/superpowers/plans/archive/2026-05-08-phase8-architecture-optimization.completed.md`

**Completed:**
1. Added explicit architecture guards for `core -> features` imports and cross-feature presentation internals
2. Removed the unnecessary relation/search repository seams from `core/session/**`
3. Tightened `core/core.dart` so `errors/exceptions.dart` is no longer part of the public barrel
4. Removed `app/app.dart -> features/settings/presentation/**` coupling by routing theme state through the settings public seam
5. Moved reusable video cards, thumbnails, skeletons, action sheets, comment widgets, emoji text, and user tags into `ui/widgets/**`
6. Replaced the last direct cross-feature presentation imports with public feature seams (`search.dart`, `live.dart`, `dynamic.dart`, `dynamic/route_entry.dart`)
7. Added a real `application/` seam for notification chat command workflow
8. Removed `dart:io` / `File` from the dynamic domain repository contract via `DynamicUploadImageAsset`

**Current snapshot:**
1. Direct `features/** -> features/**/presentation/(widgets|pages|view_models)` imports: `0`
2. Remaining feature-to-feature imports are public seam imports only (`search.dart`, `live.dart`, `dynamic.dart`)
