# Architecture Guide

Current implemented baseline for Culcul (BiliBili 3rd-party client). `lib/shared/` is fully retired, and all features now follow a standardized slice architecture. The remaining active architecture work is semantic rather than structural: the repo already has the right top-level buckets, but some feature facades, barrels, and docs still need convergence before the public seams are truly clean.

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

### Feature Structure Presence Snapshot

| Feature | route_entry | feature_scope | application/ | data/ | domain/ | presentation/ | barrel | Shape |
|---------|:-----------:|:------------:|:------------:|:-----:|:-------:|:-------------:|:------:|:-----:|
| auth    | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | PRESENT |
| dynamic | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | PRESENT |
| favorites | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | PRESENT |
| history | ✓ | ✓ | n/a | ✓ | ✓ | ✓ | ✓ | PRESENT |
| home    | ✓ | ✓ | n/a | ✓ | ✓ | ✓ | ✓ | PRESENT |
| live    | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | PRESENT |
| notification | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | PRESENT |
| profile | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | PRESENT |
| ranking | ✓ | ✓ | n/a | ✓ | ✓ | ✓ | ✓ | PRESENT |
| search  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | PRESENT |
| settings | ✓ | ✓ | n/a | ✓ | ✓ | ✓ | ✓ | PRESENT |
| to_view | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | PRESENT |
| video   | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | PRESENT |

**Legend:** ✓ = present, n/a = not needed (simple CRUD features without orchestration logic). This table records directory/surface presence only. It does not mean the repo is currently boundary-clean or that Phase 9 is complete.

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

**Historical note:** This was the Phase 7 closeout snapshot, not the current repo truth. Later cleanup exposed additional ownership drift, which is why Phase 9 now treats cross-feature presentation imports and weak feature seams as active work again.

## Phase 8 (Superseded): Architecture Optimization & Code Readability

Started 2026-05-08. Deep audit revealed structural debts in core, app, UI, and feature layers.

Archived spec: `docs/superpowers/specs/archive/2026-05-08-phase8-architecture-optimization-design.superseded.md`
Archived plan: `docs/superpowers/plans/archive/2026-05-08-phase8-architecture-optimization.superseded.md`

This phase is no longer the active baseline. Several planned items were already absorbed into the codebase, but the remaining work changed shape enough that a new planning baseline was required.

## Phase 9 (Archived as Substantially Complete): Architecture Rebaseline & Ownership Realignment

Started 2026-05-09 and archived on 2026-05-11 after the repo-wide boundary rebaseline largely landed.

Archived spec: `docs/superpowers/specs/archive/2026-05-09-phase9-architecture-rebaseline-design.superseded.md`
Archived plan: `docs/superpowers/plans/archive/2026-05-09-phase9-architecture-rebaseline.superseded.md`

**Verified carried-forward state:**
1. `lib/core/**` no longer imports `features/**`; runtime/session contracts are rooted in `core/contracts/**` and boot wiring is verified from `app/runtime/root_overrides.dart`.
2. Cross-feature presentation reuse now flows through explicit shared surfaces (`lib/ui/compositions/**`) or feature barrels/route seams rather than another feature's `presentation/**` internals.
3. Runtime ownership, shared composition extraction, feature-public-seam legality, DTO re-export cleanup, and video danmaku boundary rules all have checked-in architecture tests.

**Guardrails inherited from Phase 9:**
1. `test/architecture/phase9_runtime_ownership_guard_test.dart`
2. `test/architecture/phase9_core_session_feature_boundary_guard_test.dart`
3. `test/architecture/phase9_shared_feed_cards_guard_test.dart`
4. `test/architecture/phase9_shared_comment_text_user_guard_test.dart`
5. `test/architecture/phase9_feature_public_seams_guard_test.dart`
6. `test/architecture/phase9_video_danmaku_boundary_guard_test.dart`
7. `test/architecture/phase9_video_domain_dto_reexport_guard_test.dart`
8. `test/architecture/phase9_dynamic_domain_dto_reexport_guard_test.dart`
9. `test/architecture/phase9_live_domain_dto_reexport_guard_test.dart`

Phase 9 is no longer the active baseline because the remaining debt changed shape from repo-wide legality problems to localized readability and public-seam problems.

## Phase 10 (Superseded After Partial Landing): Slice Normalization & Public Seam Hardening

Started 2026-05-11 and superseded on 2026-05-11. The focus was normalizing high-debt slices and shrinking implementation-shaped feature APIs.

Archived spec: `docs/superpowers/specs/archive/2026-05-11-phase10-slice-normalization-and-public-seam-hardening-design.superseded.md`
Archived plan: `docs/superpowers/plans/archive/2026-05-11-phase10-slice-normalization-and-public-seam-hardening.superseded.md`

**Verified landed state from Phase 10:**
1. `feature_scope.dart` facade entrypoints exist across the repo and no longer default to exporting raw data providers.
2. `dynamic` already has `application/` and `data/article_parsing/` slices, and `video/presentation/` is already split into `detail/`, `player/`, `comments/`, and `overlays/`.
3. `phase10_*` architecture tests exist and pass, which proves a first pass of seam hardening landed.

**Why Phase 10 was superseded instead of marked complete:**
1. The docs diverged: `CLAUDE.md` still treated Phase 10 as active while this guide had already started speaking as if it were completed and archived.
2. Some public seams were only shape-correct, not semantically converged:
   - `home` still lets presentation depend on `data/home_feed_data_source.dart`
   - `notification` still exposes a repository-shaped facade
   - `dynamic.dart` and `video.dart` still selectively re-export `presentation/**` symbols
3. The first-generation Phase 10 guards were too syntactic to prove the stronger claim that all feature public APIs were deliberate and minimal.

**Guardrails inherited from Phase 10:**
1. `test/architecture/phase10_barrel_public_api_guard_test.dart`
2. `test/architecture/phase10_feature_scope_facade_guard_test.dart`
3. `test/architecture/phase10_dynamic_domain_purity_test.dart`
4. `test/architecture/phase10_video_presentation_decomposition_test.dart`

Phase 10 therefore remains important historical context, but it is no longer the truthful active baseline.

## Phase 12 (Active): Capability Facade Simplification & Generator-First Convergence

Started 2026-05-12. The focus is simplifying the active feature seams themselves: remove thin wrapper layers, stop exporting implementation-shaped public contracts, and lean more consistently on the repo's existing mainstream generator stack instead of adding more hand-written glue.

Active spec: `docs/superpowers/specs/2026-05-12-phase12-capability-facade-simplification-and-generator-first-design.md`
Active plan: `docs/superpowers/plans/2026-05-12-phase12-capability-facade-simplification-and-generator-first.md`

**Current verified debt carried into Phase 12:**
1. Several non-core facades are still thin wrappers or repository-entry aliases in `auth`, `favorites`, `history`, `profile`, `ranking`, `settings`, and `to_view`.
2. `notification` was split into inbox/chat capability facades, but the broader repo still has repository-entry aliases in other features.
3. `dynamic`, `video`, `live`, and `search` no longer publish `presentation/**` internals through `*_public_contracts.dart`, but the remaining feature roots still need the same cleanup pattern.
4. The repo already includes Riverpod Generator, Freezed, Json Serializable, Retrofit, and Drift, and the active slices now use generator-driven capability providers more consistently.

**Phase 12 target state:**
1. One truthful active baseline across `CLAUDE.md`, `architecture-guide.md`, spec, and plan.
2. Public feature seams expose capabilities, not implementation placement, and root public files carry the cross-feature contracts that were previously hidden in `*_public_contracts.dart`.
3. Empty facades are removed or merged into clearer providers or capability services.
4. `home` and `notification` are the reference slices for simplification-first seam design.
5. Generator-first patterns replace repetitive custom glue inside the slices touched by this phase, especially provider entry wrappers.
