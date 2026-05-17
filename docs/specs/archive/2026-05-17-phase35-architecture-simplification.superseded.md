# Phase 35 Architecture Simplification Spec

## Status

Superseded by Phase 36.

Supersedes:

- `docs/specs/archive/2026-05-17-phase34-architecture-modernization.completed.md`

Implementation plan:

- `docs/plans/archive/2026-05-17-phase35-architecture-simplification.superseded.md`

Superseding spec:

- `docs/specs/2026-05-18-phase36-aggressive-architecture-cleanup.md`

Tracking issue:

- `culcul-jlg`: Phase 35 architecture simplification and source cleanup.

## Context

Phase 34 closed the previous source-of-truth modernization work and pushed the
branch. The current top-level shape remains correct:

```text
lib/
  app/       app shell, bootstrap, router
  core/      infrastructure and cross-feature contracts
  features/  feature-owned data/application/presentation code
  ui/        reusable design-system and shared UI primitives
```

Local planning audit for Phase 35:

- Active branch: `codex/phase34-architecture-modernization`.
- Ready bd work: `culcul-mt9`, `culcul-phn`, `culcul-xap`.
- GitNexus repo index exists for `Culcul`, but the MCP report says it is two
  commits behind HEAD. Refresh with `npx gitnexus analyze` before code edits.
- `lib/` has 920 Dart files, dominated by generated Freezed, Drift, protobuf,
  and Slang output. Source cleanup must ignore generated size noise.
- Largest non-generated source files are in notification data, video
  presentation/data, profile widgets, home widgets, and core network/audio
  services.

Current dependency direction is already modern enough for this phase:

- Riverpod 3 with generator packages. New state owners use generated providers
  and `Notifier` or `AsyncNotifier`.
- go_router 17 with `go_router_builder`. Routing stays typed/generated unless a
  route boundary is broken.
- Drift plus `drift_flutter` for local databases. Database ownership should be
  explicit per feature, with DAOs/accessors only when they own real queries.
- Freezed 3, Dio/Retrofit, Slang, media_kit, and platform packages stay unless
  replacing custom code removes meaningful source or risk.

## Goals

- Make Phase 35 the only active architecture source of truth. This goal was
  superseded before implementation by Phase 36.
- Archive Phase 34 as completed.
- Execute the remaining ready cleanup through bd, not an extra markdown tracker.
- Extract one shared comment API owner for cross-feature comment calls.
- Finish the single app feedback pattern and remove raw/toast-like duplicates.
- Reduce analyzer info debt without weakening rules.
- Keep direct imports, narrow feature seams, and one real owner for each shared
  concept.

## Non-Goals

- Do not rewrite the whole directory structure.
- Do not reintroduce `lib/shared/`.
- Do not add compatibility shims for removed local APIs.
- Do not add repository interfaces or wrapper services unless they support
  mocking, polymorphism, or a real runtime boundary.
- Do not create part-file decompositions, alias providers, export-only barrels,
  or pass-through files just to reduce line counts.
- Do not regenerate protobuf output unless `.proto` sources change and the
  protobuf tool path is documented.

## Workstreams

### WS-1: Planning Rollover

Archive Phase 34 docs as completed, create this Phase 35 spec and plan, and
update `CLAUDE.md` plus `docs/architecture/architecture-guide.md`.

### WS-2: Shared Comment Service

Route through `culcul-mt9`. Video and Dynamic must call one shared comment API
owner for the common BiliBili comment endpoints. Article cursor-specific logic
stays feature-owned.

### WS-3: App Feedback Source

Route through `culcul-phn`. Feature presentation code uses the single
`AppFeedback` surface. Raw `ScaffoldMessenger`, ad hoc toast helpers, or
feature-local notification wrappers are removed unless they own platform
behavior that `AppFeedback` cannot represent.

### WS-4: Analyzer Info Debt

Route through `culcul-xap`. Fix info-level lints in small source batches. Do
not disable analyzer rules or add ignore comments unless the rule is provably
wrong for that line.

### WS-5: Large Source Files With Real Seams

Use line-count and GitNexus impact evidence before splitting. Candidate areas:

- `lib/features/notification/data/notification_repository_impl.dart`
- `lib/features/video/presentation/detail/video_detail_view_model.dart`
- `lib/features/video/data/video_repository_impl.dart`
- `lib/core/services/audio_handler.dart`
- `lib/core/data/network/endpoint_policy.dart`
- `lib/core/data/network/providers/wbi_helper_provider.dart`

Split only when the extracted file owns behavior with a stable name. Otherwise
leave it alone.

### WS-6: Dependency And Codegen Modernization

Use current package docs before changing APIs. Prefer upgrades or packages only
when they remove custom code, remove duplicated logic, or simplify generation.
Run generated-output review after any dependency or builder change.

## Hard Rules

- `app/`, `core/`, `features/`, and `ui/` stay as the top-level code shape.
- `core/` and `ui/` must not import `features/`.
- A feature must not import another feature's `presentation/` or `data/`
  internals.
- Shared contracts live in `core/contracts/`; feature-local DTOs live under the
  owning feature `data/dtos/`.
- `AppError` is the single error hierarchy.
- `core/feedback/app_feedback.dart` is the only feature-facing feedback API.
- Avoid new barrel files. Keep only `core_contracts.dart` and `lib/ui/ui.dart`
  as approved public export surfaces.
- New Riverpod work uses generated providers with `Notifier` or
  `AsyncNotifier` when state owns behavior.
- Simple features may omit `domain/` and `application/` when those directories
  would only pass calls through.

## Validation

Run the smallest relevant gate for each slice, then the phase gates:

```bash
dart run build_runner build
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

Before code commits:

```bash
npx gitnexus analyze
gitnexus_detect_changes(scope: "all")
```

## Acceptance Criteria

- `CLAUDE.md` and `docs/architecture/architecture-guide.md` point to Phase 35.
- Phase 34 spec and plan are archived as completed.
- Only one active spec exists under `docs/specs/`.
- Only one active plan exists under `docs/plans/`.
- Every implementation slice maps to a bd issue.
- Comment, feedback, analyzer, and large-file cleanup do not add new duplicate
  source-of-truth definitions.
- Architecture tests pass after any code slice.
