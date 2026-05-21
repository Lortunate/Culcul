# Culcul UI Design Unification

Date: 2026-05-20
Status: Draft for review

## Goal

Unify Culcul's app-wide visual language across shared widgets and high-visibility feature screens while preserving the existing content-community brand feel. The pass should make radius, spacing, surfaces, component states, and transitions feel intentional and consistent without changing feature behavior.

## Current Context

The app already has a central design layer:

- `lib/ui/theme/culcul_theme.dart`
- `lib/ui/theme/culcul_theme.components.dart`
- `lib/ui/theme/culcul_tokens.dart`
- `lib/ui/theme/culcul_colors.dart`
- shared widgets under `lib/ui/widgets/**`
- route transitions under `lib/app/router/route_transitions.dart`

The existing direction is Material 3 with Culcul brand colors. The main issue is not missing infrastructure, but uneven adoption. Feature widgets still contain many local `BorderRadius`, `EdgeInsets`, `BoxDecoration`, `BoxShadow`, and animation duration values.

## Design Direction

Keep Culcul light, friendly, and content-first. Do not move the app toward a neutral enterprise Material 3 look.

The unified style should use:

- clean white or near-surface content areas
- soft but not oversized rounded corners
- subtle borders before heavy shadows
- brand color for emphasis and action, not large decorative backgrounds
- compact information density for feeds, comments, video metadata, and search
- motion that feels quick and smooth rather than theatrical

## Token Rules

### Spacing

Use `CulculSpacing` as the source of truth for shared and feature UI spacing.

Recommended semantics:

- `xxs`: icon/text micro gaps
- `xs`: compact chip and inline padding
- `sm`: dense list and control spacing
- `md`: default page and card spacing
- `lg`: section spacing
- `xl`: empty state or large layout spacing

Feature code may still use local calculated spacing when layout depends on viewport, safe area, or media player constraints, but fixed visual spacing should prefer tokens.

### Radius

Use `CulculRadius` as the source of truth for rounded corners.

Recommended semantics:

- `xs`: tiny tags, badges, overlays
- `sm`: tabs, compact chips, small controls
- `md`: default buttons and inputs
- `lg`: cards, media thumbnails, bottom controls
- `xl`: modal sheets and large grouped surfaces

Avoid ad hoc values such as `3`, `14`, `18`, `20`, `22`, `28`, and `999` unless the component is intentionally pill-shaped or constrained by platform conventions.

### Surfaces

Default hierarchy:

- page background: `scaffoldBackgroundColor`
- default card/list surface: `colorScheme.surface`
- nested or muted surface: `colorScheme.surfaceContainerLow`
- emphasized grouped surface: `colorScheme.surfaceContainer`
- borders: `colorScheme.outlineVariant`

Prefer border and background contrast before adding shadows. Use shadows only for overlays, floating media controls, and modal-like elements.

## Component Rules

### Theme Components

Normalize component themes in `culcul_theme.components.dart` first:

- card shape and border
- filled, outlined, and text button shape
- input decoration fill, padding, and state borders
- tab and bottom navigation styling
- divider color and thickness

Hard-coded component values inside the theme file should use `CulculSpacing` and `CulculRadius`.

### Shared Widgets

Update shared widgets before feature widgets:

- `AppCardContainer`
- `AppBottomSheet`
- `AppSearchBar`
- `AppTabBar`
- `AppTag`
- `FollowButton`
- feedback and empty/error state widgets

These components should expose only necessary customization. Avoid pushing every one-off style knob into the shared API.

### Feature Surfaces

Prioritize feature areas by visual impact:

1. `video`: video detail, bottom bars, controls, action sheets, comments
2. `dynamic`: topic picker, dynamic cards, article block cards, comments
3. `profile`: profile sections, video sections, action grids
4. `notification`: chat input, category grid, notification cards
5. `search` and `auth`: search bars, filter bars, login panel, text fields

Feature changes should mostly replace hard-coded values with tokens or shared widgets. Avoid broad layout rewrites unless they are needed to remove obvious inconsistency.

## Motion Rules

Use `CulculMotion` for shared animation timing and curves.

Recommended semantics:

- `fast`: small state transitions, icon/text swaps, hover/press-like feedback
- `standard`: control, chip, and list item transitions
- `emphasized`: modal and route entry transitions
- `routeForward`, `routeReverse`, `routeModal`: route-specific durations

Route transitions should remain centralized in `lib/app/router/route_transitions.dart`. Existing fade-scale and slide transitions are a good base, but curves should be consistent across route types.

Local animation durations in features should move to tokens when they are visual transitions. Do not replace durations that represent media seek positions, debounce intervals, playback throttling, network timing, or feedback display time.

## Implementation Strategy

Work in small, verifiable slices:

1. Normalize tokens and theme component usage.
2. Normalize shared widgets that are reused across screens.
3. Apply the shared design language to the highest-impact `video` and `dynamic` surfaces.
4. Continue with `profile`, `notification`, `search`, and `auth`.
5. Run analyzer, focused widget tests, and visual checks after each slice.

Because the current working tree contains unrelated edits, each slice should avoid touching files outside the intended UI scope.

## Verification

Minimum verification before considering the pass complete:

- `flutter analyze`
- focused widget tests for changed shared widgets
- existing tests covering affected feature surfaces when available
- manual or browser/device screenshots for representative mobile viewport screens:
  - home/feed
  - video detail and comments
  - dynamic detail or publish surface
  - profile
  - search
  - auth/login

Visual review should check that text does not overflow, tap targets remain usable, route transitions are not jarring, and dark mode keeps enough contrast.

## Open Decisions

Default decision: preserve the current Culcul brand feel and content-community tone.

Before implementation, confirm whether this pass should stop after shared widgets plus `video` and `dynamic`, or continue through all listed feature areas in this session.
