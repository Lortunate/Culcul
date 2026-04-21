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
- `lib/features/notification/application/chat_page_commands.dart`

For explicitly approved migrations, production imports should now point at the
`application/` file rather than any legacy
`presentation/pages/*_page_commands.dart` adapter. Additional homes should be
added to the guard only when the migration is complete enough to enforce.

## Current pilot moves

- Dynamic detail and notification chat no longer keep page-command adapters in
  `presentation/pages`; their workflows are owned by `application/`.
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

## Intentional transitional adapters

- `lib/features/favorites/presentation/pages/favorites_page_commands.dart` and
  `lib/features/favorites/presentation/pages/favorite_detail_page_commands.dart`
  remain thin UI adapters for dialogs, page invalidation, and navigation. The
  durable folder mutations already live in
  `lib/features/favorites/application/favorite_folder_commands.dart`.
- `lib/features/video/presentation/pages/comment_reply_page_commands.dart`
  remains a thin reply-sheet adapter until a dedicated application home is
  introduced for that flow.
