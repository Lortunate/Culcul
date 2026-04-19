# Shared Boundary Rules

Phase 1 introduces architecture guards that keep `lib/shared` independent from
feature packages and force `lib/app/router/app_routes.dart` to avoid broad
feature barrel imports.

## Rules

1. `lib/shared/**` must not import anything under `package:culcul/features/...`.
2. Shared UI should depend on shared contracts, callbacks, or app-level
   abstractions instead of feature presentation widgets.
3. `lib/app/router/app_routes.dart` must not import broad feature barrels such
   as `package:culcul/features/auth/auth.dart`.
4. Routing code should import only the narrow route entry points or other
   explicitly-scoped APIs it needs.

## Guard Coverage

- `test/architecture/shared_boundary_guard_test.dart`
  checks for `shared -> features` imports.
- `test/architecture/auth_video_architecture_guard_test.dart`
  checks for broad feature barrel imports in `app_routes.dart`.

## Known Violations At Guard Introduction

- `lib/shared/widgets/video_actions_bottom_sheet.dart`
  imports `package:culcul/features/to_view/to_view.dart`.
- `lib/app/router/app_routes.dart`
  imports broad feature barrels for multiple features including `auth`, `home`,
  and `video`.

These violations are intentionally left in place for follow-up cleanup work;
the new guards make them explicit and prevent the boundary from drifting
further.
