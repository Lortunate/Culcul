# Architecture Guide

Post-refactoring architecture for Culcul (BiliBili 3rd-party client). `lib/shared/` is fully retired.

## Directory Structure

```
lib/
├── app/              # App shell, bootstrap, router
│   ├── bootstrap/    # App initialization
│   ├── router/       # go_router route definitions
│   └── shell/        # Main app shell (bottom nav, etc.)
├── core/             # Infrastructure, cross-cutting concerns
│   ├── bootstrap/    # Riverpod provider stubs for app dependencies
│   │   └── providers/ # CookieJar, CacheStore, Storage provider contracts
│   ├── constants/    # API constants, app dimensions
│   ├── contracts/    # Shared data contracts (VideoModel, UserCard, etc.)
│   ├── errors/       # Error types, ErrorHandler
│   ├── hooks/        # Reusable Flutter hooks
│   ├── network/      # Dio client, interceptors, request executor
│   ├── pagination/   # Paged list state, scroll triggers
│   ├── perf/         # Frame sampling, startup tracing
│   ├── result/       # Result<T> type
│   ├── services/     # Audio handler, media service
│   ├── session/      # Token refresh, cookie management
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
    └── widgets/      # Generic widgets (VideoCard, etc.)
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
| notification | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| profile | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| ranking | ✓ | ✓ | n/a | ✓ | ✓ | ✓ | ✓ | FULL |
| search  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| settings | ✓ | ✓ | n/a | ✓ | ✓ | ✓ | ✓ | FULL |
| to_view | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |
| video   | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | FULL |

**Legend:** ✓ = present, n/a = not needed (simple CRUD features without orchestration logic). All 13 features are FULL as of Phase 6.

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

## Phase 6 (Current): Architecture Optimization & Code Quality

Spec: `docs/superpowers/specs/2026-05-07-phase6-architecture-optimization-design.md`
Plan: `docs/superpowers/plans/2026-05-07-phase6-architecture-optimization.md`

1. Feature structure normalization (5 non-compliant features)
2. Documentation reconciliation (CLAUDE.md/AGENTS.md)
3. Lint tightening (avoid_print, unawaited_futures)
4. Barrel export standardization
