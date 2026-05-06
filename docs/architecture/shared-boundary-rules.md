# Shared Boundary Rules

Phase 1 introduces architecture guards that keep `lib/shared` independent from
feature packages and force `lib/app/router/app_routes.dart` to avoid broad
feature barrel imports. Phase 2 continues that cleanup by routing home pages
through `lib/features/home/route_entry.dart` instead of importing presentation
pages directly from `app_routes.dart`, and by standardizing feature-level route
entry seams for the centralized router.

## Rules

1. `lib/shared/**` must not import anything under `package:culcul/features/...`.
2. Shared UI should depend on shared contracts, callbacks, or app-level
   abstractions instead of feature presentation widgets.
3. `lib/app/router/app_routes.dart` must not import broad feature barrels such
   as `package:culcul/features/auth/auth.dart`.
4. Routing code should import only the narrow route entry points or other
   explicitly-scoped APIs it needs.
5. Home routing must flow through `package:culcul/features/home/route_entry.dart`
   instead of importing `presentation/pages/home_page.dart` or
   `presentation/pages/weekly_screen.dart` in `app_routes.dart`.
6. New feature routes should expose a `route_entry.dart` seam owned by the
   feature, with small builder functions and any route-only input objects
   needed to construct the target page.
7. Route entry files are routing adapters, not workflow layers. They may map
   route parameters into page constructor arguments, but they should not own
   login gating, provider writes, mutation sequencing, or snackbar/toast
   behavior.

## Phase 2 Follow-up

Current branch conventions are documented in
`docs/architecture/phase2-route-and-orchestration-rules.md`.
Phase-3 normalization targets are documented in
`docs/architecture/phase3-structural-normalization-rules.md`.

In practice this means:

- `lib/app/router/app_routes.dart` depends on feature route entry seams such as
  `lib/features/dynamic/route_entry.dart`,
  `lib/features/notification/route_entry.dart`, and
  `lib/features/favorites/route_entry.dart`.
- route input DTOs like `ChatRouteInput` and `CommentReplyRouteInput` are
  acceptable when a route needs more than primitive parameters.
- command extraction belongs in feature-owned helpers such as
  `application/*workflow*.dart` and `application/*commands*.dart`, including
  approved homes such as `favorite_folder_commands.dart`,
  `comment_reply_commands.dart`, and `live_room_page_commands.dart`.
- narrowly scoped page command adapters like `*_page_commands.dart` are
  transitional only where they still exist, and they should stop owning
  production workflow imports once phase-3 documents an approved
  `application/` home for that feature.
- bootstrap-owned provider contracts now live under
  `lib/core/bootstrap/providers/**`.
- the retired shared provider paths
  `lib/shared/providers/cache_store_provider.dart`,
  `lib/shared/providers/cookie_jar_provider.dart`, and
  `lib/shared/providers/storage_provider.dart` are removed.
  Production imports must use `package:culcul/core/bootstrap/providers/*`.
- `lib/shared/providers/**` is retired.
- WBI signing ownership now lives under
  `lib/shared/network/providers/**`.
- canonical perf helpers now live under `lib/core/perf/**`.
- the old `lib/shared/perf/**` paths are retired. Production imports must use
  `package:culcul/core/perf/*`.
- New provider declarations must live next to their owning infrastructure
  domain instead of being added to a generic shared provider bucket.
- old shared session shims are gone; canonical session contracts remain under
  `lib/core/session/**`.
- canonical shared contracts now live under `lib/core/contracts/**`.
- the former `lib/shared/contracts/**` paths are retired. Production imports must
  use `package:culcul/core/contracts/*`.
- the former `lib/shared/errors/**` directory is fully retired. Canonical error
  types and ErrorHandler live under `lib/core/errors/**`.
- the former `lib/shared/responsive/**` directory is fully retired. Canonical
  responsive helpers live under `lib/ui/responsive/**`.
- the former `lib/shared/result/**` directory is fully retired. The canonical
  result type lives under `lib/core/result/**`.

## Guard Coverage

- `test/architecture/shared_boundary_guard_test.dart`
  checks for `shared -> features` imports.
- `test/architecture/auth_video_architecture_guard_test.dart`
  checks for broad feature barrel imports in `app_routes.dart` and verifies the
  home route entry boundary.
- `test/architecture/phase3_workflow_ownership_guard_test.dart`
  checks that phase-3 normalization docs stay linked and that explicitly
  approved workflow migrations replace production imports of legacy
  page-command locations.
- `test/architecture/provider_bootstrap_ownership_guard_test.dart`
  checks that production code no longer imports retired
  `package:culcul/shared/providers/*` bootstrap shims or the deleted
  shared-session shim paths.

## Known Violations At Guard Introduction

- `lib/shared/widgets/video_actions_bottom_sheet.dart`
  imports `package:culcul/features/to_view/to_view.dart`.
- `lib/app/router/app_routes.dart`
  imports broad feature barrels for multiple features including `auth` and
  `video`.

These violations are intentionally left in place for follow-up cleanup work;
the new guards make them explicit and prevent the boundary from drifting
further.
