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

## Phase 5 (Current): Test Coverage & CI Hardening

Spec: `docs/superpowers/specs/2026-05-06-phase5-test-coverage-ci-hardening-design.md`
Plan: `docs/superpowers/plans/2026-05-06-phase5-test-coverage-ci-hardening-plan.md`

1. Cover zero-coverage features (history, ranking, to_view)
2. Cover core/utils/, core/errors/, core/session/, core/contracts/
3. Cover auth data layer
4. Add CI coverage threshold gate
5. Architecture guide maintenance
