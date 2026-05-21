# Culcul UI Design Unification Plan

Date: 2026-05-20
Related spec: `docs/superpowers/specs/2026-05-20-ui-design-unification-design.md`
Tracking issue: `culcul-fqx`

## Execution Model

Run this plan in parallel where file ownership is disjoint.

The implementation should be split into four workstreams:

1. Theme and motion foundation.
2. Shared widgets.
3. High-visibility feature surfaces.
4. Verification and screenshot review.

Each workstream should own a disjoint file set and avoid touching unrelated UI files.

## Workstream 1: Theme and Motion Foundation

Owner files:

- `lib/ui/theme/culcul_tokens.dart`
- `lib/ui/theme/culcul_theme.dart`
- `lib/ui/theme/culcul_theme.components.dart`
- `lib/app/router/route_transitions.dart`

Goal:

Centralize the app's radius, spacing, component, and motion defaults so shared widgets and feature pages can inherit the same language.

Implementation scope:

1. Normalize `CulculSpacing`, `CulculRadius`, and `CulculMotion` semantics if any gaps exist between intended usage and current values.
2. Update the theme component builders so cards, buttons, inputs, dividers, and tab surfaces all use the same radius and padding scale.
3. Keep route transitions centralized and aligned with the motion tokens.

Tests:

- Add or update widget tests for theme-dependent shared widgets if behavior changes.
- Run `flutter test` for any touched shared widget tests.
- Run `flutter analyze`.

## Workstream 2: Shared Widgets

Owner files:

- `lib/ui/widgets/cards/app_card_container.dart`
- `lib/ui/widgets/overlays/app_bottom_sheet.dart`
- `lib/ui/widgets/inputs/app_search_bar.dart`
- `lib/ui/widgets/layout/app_tab_bar.dart`
- `lib/ui/widgets/buttons/app_tag.dart`
- `lib/ui/widgets/buttons/follow_button.dart`

Goal:

Make the shared UI primitives reflect the unified design tokens instead of maintaining their own local radius and spacing values.

Implementation scope:

1. Replace hard-coded shape and padding values with token-based or theme-based values where the shared widget API allows it.
2. Keep backwards compatibility for existing call sites.
3. Prefer small API changes over broad rewrites.

Tests:

- Update or add widget tests for the shared widgets if the appearance or defaults change.
- Run any existing tests under `test/ui/**` that cover these widgets.

## Workstream 3: High-Visibility Feature Surfaces

Owner files:

- `lib/features/video/presentation/player/vertical_video_page.bottom_bar.dart`
- `lib/features/video/presentation/player/controls/**`
- `lib/features/video/presentation/comments/**`
- `lib/features/dynamic/presentation/widgets/topic_picker.dart`
- `lib/features/dynamic/presentation/pages/article_detail_page_block_renderers.cards.dart`
- `lib/features/profile/presentation/widgets/**`
- `lib/features/notification/presentation/widgets/**`
- `lib/features/search/presentation/widgets/search_app_bar.dart`
- `lib/features/auth/presentation/widgets/login_panel.dart`

Goal:

Align the highest-traffic screens with the shared surface rules, especially the places where local radius, spacing, chip shape, and motion currently diverge most.

Implementation scope:

1. Replace one-off corner radii with `CulculRadius` or inherited theme shapes.
2. Standardize control spacing and section padding.
3. Remove local animation timings where they duplicate the shared motion tokens.
4. Preserve behavior, state, and text content.

Tests:

- Update or add feature widget tests for the touched screens.
- Run focused widget tests for video, dynamic, profile, search, auth, and notification surfaces.
- Capture screenshots for mobile viewport review after the implementation slice lands.

## Workstream 4: Verification

Verification order:

1. `flutter analyze`
2. Focused widget tests for changed shared widgets and feature surfaces
3. Visual review of representative screens

Screens to review:

- home/feed
- video detail
- dynamic detail or publish surface
- profile
- search
- auth/login
- notification input or conversation surface

## Recommended Parallel Order

Start workstreams 1 and 2 in parallel because they touch different files and establish the shared language.

Then start workstream 3 in parallel across disjoint subgroups:

- video
- dynamic
- profile/notification
- search/auth

Keep the implementation incremental so each subgroup can be reviewed and tested before the next one starts.
