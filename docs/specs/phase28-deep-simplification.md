# Phase 28 Deep Simplification Spec

## Status

Active on 2026-05-15.

Supersedes:

- `docs/specs/archive/2026-05-15-phase27-architecture-simplification.completed.md`

## Context

Phase 27 flattened bootstrap, removed dead infrastructure, eliminated pass-through commands, and cleaned redundant dependencies. The architecture is violation-free with strong guard tests.

However, deeper simplification opportunities remain:

1. **Notification repository god-object** — 7 helper classes + 2 sub-helpers all hold a `NotificationRepositoryImpl` back-reference and navigate to siblings through it. A runtime call cycle exists: `messageSendService → repo.syncMessagesHead() → messageSync → messageSendService`. This makes the system hard to test, reason about, and modify safely.

2. **Trivial alias providers** — 5 hand-written providers are pure forwarding aliases that add indirection without value: `searchDefaultHintProvider`, `clearProfileCacheProvider`, `logoutActionProvider`, `searchPortProvider`, `userCardProvider`.

3. **Hand-written providers** — 4 providers (`relationPortProvider`, `networkQualityPolicy` group, `userProfileInfoProvider`, `watchLaterPortProvider`) should use `@riverpod` codegen for consistency and type safety.

4. **Dependency bloat** — `uuid` package used for a single `Uuid().v4()` call; `archive` package used only for `GZipDecoder` which `dart:io` provides natively.

5. **EndpointPolicy hand-written copyWith** — The only non-generated `copyWith` in the codebase (7 fields). Should use freezed for consistency.

6. **Feature-scope export-only files** — Several `feature_scope.dart` files export a single symbol. These are architecturally approved but some are unnecessary indirection when the consumer could import the source directly.

7. **Home/ranking DTOs without freezed** — `PopularResponseDto`, `WeeklyModelDto`, `FeedResponseDto` use hand-written `fromJson` factories instead of `json_serializable`/`freezed` codegen.

## Goals

1. Refactor notification repository helpers into independent services with explicit dependencies (no circular `repo` back-ref). Break the runtime call cycle.
2. Eliminate 5 trivial alias providers — consumers call the source directly.
3. Migrate 4 hand-written providers to `@riverpod` codegen.
4. Remove `uuid` dependency — replace with inline secure random UUID v4 generator.
5. Remove `archive` dependency — replace with `dart:io` `GZipCodec`.
6. Convert `EndpointPolicy` to freezed.
7. Convert home/ranking DTOs to `json_serializable` codegen.
8. Remove single-export `feature_scope.dart` files where the export adds no access-control value.

## Non-Goals

- No feature-level behavior changes.
- No UI changes.
- No routing restructure.
- No changes to the performance/runtime adaptive system.
- No migration of `sessionCookieRefresherProvider` (override-slot pattern incompatible with codegen).
- No replacement of `extended_image` (gesture features are essential).
- No replacement of `html`, `path_drawing`, `gal`, `gt3_flutter_plugin` (all justified).

## Success Criteria

- [ ] Notification helpers are independent classes with explicit constructor deps; no `repo` back-reference.
- [ ] Runtime call cycle between messageSendService/messageSync is broken via explicit interface or callback injection.
- [ ] 5 trivial alias providers deleted; all consumers updated to use source providers directly.
- [ ] 4 providers migrated to `@riverpod` with `.g.dart` generation.
- [ ] `uuid` removed from pubspec.yaml; inline UUID v4 utility in `core/utils/`.
- [ ] `archive` removed from pubspec.yaml; `dart:io` GZipCodec used instead.
- [ ] `EndpointPolicy` uses freezed with generated `copyWith`.
- [ ] Home/ranking DTOs use `@JsonSerializable` or `@freezed` codegen.
- [ ] Single-export `feature_scope.dart` files removed where safe.
- [ ] All architecture guard tests pass.
- [ ] `flutter analyze` clean.
- [ ] App builds and runs correctly.
- [ ] Source file count reduced by ≥3 files.
- [ ] Dependency count reduced by ≥2 packages.

## Risks

- **Notification refactor scope** — The 7-helper decomposition touches a complex real-time system (WebSocket, DB sync, message send). The runtime call cycle must be broken without changing observable behavior.
- **Provider elimination ripple** — Removing alias providers requires updating all consumer call sites. Mechanical but touches many files.
- **EndpointPolicy freezed migration** — The class is used in hot paths (every network request). Freezed's generated code must not introduce overhead.

## Approach

Execute in risk order: low-risk dependency/provider cleanup first, then DTO codegen migration, then notification refactor (highest risk, last). Each task is independently committable.
