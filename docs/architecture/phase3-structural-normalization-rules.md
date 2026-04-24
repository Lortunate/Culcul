# Phase 3 Structural Normalization Rules

This note defines the ownership model for the post-phase-2 cleanup work. The
goal is consistency, not a full tree rewrite.

## Workflow ownership

- Mutable feature workflows belong under `lib/features/<feature>/application/`.
- A page may gather UI state and invoke one higher-level workflow object at a
  time, but it should not own branching, login gating, repository coordination,
  mutation sequencing, or cross-provider orchestration.
- Files named `presentation/pages/*_page_commands.dart` are transitional
  adapters only. They may remain when they are thin UI wrappers around page-only
  concerns, but once a feature has an approved `application/` home, production
  imports should stop pointing at the presentation-page command file.

## Shared split direction

- `lib/core/**` is the long-term home for infrastructure and cross-cutting
  structural code: network, session, result, errors, services, perf, and stable
  shared contracts.
- `lib/ui/**` is the long-term home for design system code and reusable UI
  primitives: theme, responsive helpers, rendering-focused hooks, and generic
  widgets with no feature workflow knowledge.
- `lib/shared/**` remains a compatibility layer while the split proceeds in
  small pilots. New moves should prefer `core` or `ui` when ownership is clear.

## Guard direction

- Phase 3 architecture guards should check dependency direction and approved
  file-location policy.
- Guards should stay narrow: they should not try to enforce full naming
  symmetry or move every helper in one pass.
- When a feature does not yet have an approved `application/` home, the guard
  should not fail just because a page-command adapter still exists.

## Approved homes

- `lib/features/dynamic/application/dynamic_detail_actions.dart`
- `lib/features/favorites/application/favorite_folder_commands.dart`
- `lib/features/notification/application/chat_page_commands.dart`
- `lib/features/video/application/comment_reply_commands.dart`

For explicitly approved migrations, production imports should now point at the
`application/` file rather than any legacy
`presentation/pages/*_page_commands.dart` adapter. Additional homes should be
added to the guard only when the migration is complete enough to enforce.

## Current pilot moves

- Dynamic detail and notification chat no longer keep page-command adapters in
  `presentation/pages`; their workflows are owned by `application/`.
- `lib/features/favorites/application/favorite_folder_commands.dart` now owns
  the favorites folder mutations that previously flowed through page-command
  adapters.
- `lib/features/video/application/comment_reply_commands.dart` now owns the
  comment-reply workflow that previously flowed through a page-command adapter.
- `lib/core/session/session_cookie_refresher.dart` owns the cross-cutting
  session refresh contract used by shared networking and the auth adapter. The
  matching `lib/shared/session/session_cookie_refresher.dart` file remains a
  compatibility export for existing imports.
- `lib/core/session/session_refresh_provider.dart` owns the app-bootstrap
  session refresh action provider. The legacy
  `lib/shared/providers/session_refresh_provider.dart` file remains a
  compatibility export while imports are tightened.
- `lib/ui/responsive/app_responsive.dart` and
  `lib/ui/responsive/responsive_container.dart` own the responsive UI helpers.
  The matching `lib/shared/responsive/*` files remain compatibility exports for
  existing imports.

## Transitional adapters and accepted direct imports

- Phase 3 only guards legacy `presentation/pages/*_page_commands.dart` paths
  when a branch still has a real presentation-era import target worth blocking.
- Favorites folder commands and video comment reply are no longer transitional
  adapter examples on this branch; their durable ownership now lives in
  `application/`.
- `lib/features/live/application/live_room_page_commands.dart` remains an
  accepted application-owned helper on this branch because
  `live_room_page.dart` imports it directly and there is no retained
  `presentation/pages/*_page_commands.dart` path worth adding to the guard.
