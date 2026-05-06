# Phase 2 Route And Orchestration Rules

This note captures the practical architecture rules established by the
phase-2 cleanup work on this branch. It is intentionally narrow: describe the
current routing and command boundaries, not a future rewrite.

Phase-3 normalization follow-up is tracked in
`docs/architecture/phase3-structural-normalization-rules.md`.

## Route ownership

- `lib/app/router/app_routes.dart` remains the top-level route graph.
- Each feature should provide a `route_entry.dart` file as the router-facing
  seam.
- `app_routes.dart` should depend on feature route entry functions, not on
  `presentation/pages/*.dart` files directly.
- Route entry files may define small typed inputs for route payloads when
  primitives are not enough, for example `ChatRouteInput` and
  `CommentReplyRouteInput`.
- Route entry files should stay thin: they translate route parameters into page
  constructor arguments and nothing more.

## Orchestration ownership

- Presentation pages may gather UI state, read providers, and invoke one
  higher-level command object at a time.
- Mutation sequencing, repository coordination, login gating, and branching
  behavior should live outside the widget tree.
- This branch currently uses two acceptable shapes:
  - feature-owned workflows/commands under `application/`
  - narrowly scoped page adapters such as `*_page_commands.dart`
- Phase 3 tightens this rule: page-command adapters are transitional UI seams,
  while durable workflow ownership belongs in `application/`.
- Shared or reusable widgets must not absorb feature workflows while this
  extraction happens.

## Current branch examples

- Routing seams:
  - `lib/features/dynamic/route_entry.dart`
  - `lib/features/favorites/route_entry.dart`
  - `lib/features/live/route_entry.dart`
  - `lib/features/notification/route_entry.dart`
  - `lib/features/video/route_entry.dart`
- Feature workflows/commands:
  - `lib/features/dynamic/application/dynamic_detail_actions.dart`
  - `lib/features/dynamic/application/dynamic_workflows.dart`
  - `lib/features/favorites/application/favorite_folder_commands.dart`
  - `lib/features/live/application/live_room_page_commands.dart`
  - `lib/features/notification/application/chat_page_commands.dart`
  - `lib/features/video/application/comment_reply_commands.dart`

## What phase 2 does not require

- moving the whole router out of `app_routes.dart`
- forcing every feature into the same folder layout immediately
- renaming every command helper to one canonical suffix in this branch

## Phase 3 readiness

- The routing seam is now explicit enough to reduce `app_routes.dart` page
  coupling without a full navigation redesign.
- Durable workflow ownership already lives in `application/` for dynamic
  detail, notification chat, favorites folder commands, video comment reply,
  and the live room page helper used directly by its page.
- Guard tightening should only happen after production ownership is actually
  clean; once that is true, the approved `application/` home becomes the only
  production import target for that workflow.
