# Phase 25 Architecture Surface Reduction Spec

> Completed on 2026-05-14 by `docs/specs/archive/2026-05-14-phase25-architecture-surface-reduction.completed.md`.
> Follow-up seam hardening continues in `docs/specs/phase26-application-seam-hardening.md`.

## Status

Active on 2026-05-14.

Supersedes:

- `docs/specs/archive/2026-05-14-phase24-architecture-source-of-truth-consolidation.superseded.md`
- `docs/plans/archive/2026-05-14-phase24-architecture-source-of-truth-consolidation.superseded.md`

## Context

Phase 24 closed the urgent source-of-truth drift: active docs now agree, `lib/shared/` remains retired, provider/bootstrap placeholders are gone, runtime/network policy is centralized, and architecture guards exist.

The remaining architecture debt is mostly surface-area debt rather than broken behavior:

- `lib/features/**/feature_scope.dart` exports many data and presentation internals as a broad composition surface.
- `lib/app/router/app_routes.dart` re-exports feature route input types, creating a router-owned alias for feature-owned API.
- Simple features still carry thin `domain/` directories even when the domain type is only a transport/view shape.
- Generated artifacts are mixed into source scans and make architecture counts noisy unless tooling filters them consistently.
- `pubspec.yaml` contains a duplicated `dev_dependencies:` heading and several low-use or platform-only dependencies that need an explicit keep/remove decision.
- Some generated package usage is visible only through build outputs or platform registrants, so dependency cleanup needs usage evidence rather than blind deletion.

Phase 25 reduces public API surface, trims empty architecture layers, and tightens dependency/config ownership. Behavior should remain stable; internal compatibility with old import paths is not required.

## Goals

1. Make each feature expose the smallest useful public seam.
2. Remove feature `domain/` layers that contain no business behavior and only duplicate data/view shapes.
3. Keep generated files out of architectural debt counts unless the check specifically targets generated output.
4. Normalize dependency/config ownership so `pubspec.yaml`, generated plugin registrants, and code usage agree.
5. Replace router/app aliases for feature types with direct feature-owned imports.
6. Keep Flutter and Riverpod architecture aligned with current guidance:
   - data/repository owns mutable source of truth;
   - state flows down and events flow up;
   - new or rewritten state uses generated Riverpod `Notifier`/`AsyncNotifier`;
   - providers are used for dependency injection and test overrides, not as duplicate business layers.

## Non-Goals

- No UI redesign.
- No routing rewrite or navigation behavior change.
- No new state-management framework.
- No new cache/database/network package unless existing code proves the current stack cannot express the requirement.
- No compatibility shims for old internal imports after call sites are migrated.

## Target Architecture

### Feature Public Surface

Allowed feature public files:

- `route_entry.dart` for router-facing definitions and page builders.
- `feature_scope.dart` only for runtime composition that must be consumed outside the feature.
- `<feature>.dart` only when the feature has a real product API consumed by other features.

`feature_scope.dart` should not export presentation widgets or data repositories by default. Prefer direct imports from the owning source file inside the feature and explicit, narrow exports for cross-feature composition.

### Domain Layer

Keep `domain/` only when it contains business rules, invariants, or feature-owned behavior. If a type is only a DTO-shaped view model, move or collapse it into the data/presentation layer that owns it.

Shared reusable contracts still live in `core/contracts/`.

### Generated And Tooling Surface

Architecture scans must distinguish source files from generated files:

- Exclude `*.g.dart`, `*.freezed.dart`, protobuf output, and localization generated output from source debt counts by default.
- Include generated files only in codegen verification tasks.
- Keep guard output stable enough to compare phase-to-phase.

### Dependency And Config Ownership

Every dependency in `pubspec.yaml` must have one of:

- direct source usage;
- generated-code usage;
- platform/plugin registrant usage;
- documented keep rationale.

Remove duplicate YAML headings and stale config. Prefer the existing popular stack (`dio`, `retrofit`, Riverpod, Freezed, Drift, shared preferences / secure storage policy) before adding alternatives.

## Success Criteria

- Active pointers in `CLAUDE.md`, this spec, the plan, and `docs/architecture/architecture-guide.md` match.
- Phase 24 active spec/plan are archived as superseded with Phase 25 pointers.
- Feature scope exports are audited and reduced where they expose data/presentation internals without cross-feature need.
- Thin domain directories are either kept with rationale or collapsed.
- Generated files are excluded from architecture source counts.
- `pubspec.yaml` has a single `dev_dependencies:` heading.
- Dependency audit records keep/remove decisions for low-use and generated/platform-only packages.
- Architecture guards, analyzer, codegen/localization, and focused tests pass before merge.

## Verification

- Run GitNexus impact analysis before editing any function, class, or method.
- Run architecture checks:
  - `bash tool/architecture/run_architecture_guards.sh`
- Run generation after model/provider/config changes:
  - `dart run slang`
  - `dart run build_runner build --delete-conflicting-outputs`
- Run:
  - `flutter analyze`
  - focused tests for every touched feature
  - `gitnexus_detect_changes(scope: "all")` before commit
