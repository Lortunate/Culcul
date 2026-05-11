# Shared → Core/UI Ownership Normalization: Remaining Roadmap

**Goal:** Drain `lib/shared/` from 118 files to zero by moving infrastructure to
`lib/core/**` and UI primitives to `lib/ui/**`, following dependency order and
the established slice pattern (worktree, guard, move, migrate, delete, docs).

**Context:** The phase-3 structural normalization has completed 7 slices over the
last 3 weeks (contracts, perf, errors, result, session, bootstrap providers,
responsive). 12 directories and 118 files remain. Two completed plans need
archiving before new work begins.

## Dependency Graph (shared/ internal)

```
Layer 0 (no shared/ deps):  constants, utils, errors, hooks
Layer 1 (depends on Layer 0): pagination (depends on utils/list_utils)
Layer 2 (depends on Layer 0+1): network (depends on constants, utils)
Layer 3 (depends on Layer 0+1+2): services (depends on utils, network)
Layer 4 (depends on all): widgets
Independent: theme (circular barrel with ui/)
Stale/re-exports: contracts, responsive, result
```

**Critical path:** constants/utils → pagination → network → services → widgets

---

## Phase 0: Archive Completed Plans

**Goal:** Move the two completed plans to archive.

- `docs/superpowers/plans/2026-05-06-shared-contracts-ownership-normalization-plan.md`
  → `archive/2026-05-06-shared-contracts-ownership-normalization-plan.completed.md`
- `docs/superpowers/plans/2026-05-01-shared-perf-ownership-normalization-plan.md`
  → `archive/2026-05-01-shared-perf-ownership-normalization-plan.completed.md`

**Effort:** Trivial. Single commit.

---

## Phase 1: Delete Stale Artifacts and Re-exports

**Goal:** Remove 14 files that are either stale generated artifacts or pure
re-exports with zero importers.

| Directory | Files to Delete | Reason |
|---|---|---|
| `shared/contracts/` | 7 `.freezed.dart`/`.g.dart` files | Canonical sources now in `core/contracts/` |
| `shared/responsive/` | 4 re-export shims | Point to `ui/responsive/` |
| `shared/result/` | 1 re-export shim | Points to `core/result/` |
| `shared/errors/` | `app_error.dart`, `exceptions.dart` (2 re-exports) | Point to `core/errors/` |

**Guard updates:** Add 7 paths to `phase3_legacy_import_paths_test.dart`:
- `shared/responsive/responsive.dart`, `shared/responsive/app_breakpoints.dart`,
  `shared/responsive/app_responsive.dart`, `shared/responsive/responsive_container.dart`
- `shared/result/result.dart`
- `shared/errors/app_error.dart`, `shared/errors/exceptions.dart`

**Verification:**
```bash
flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact
```

**Effort:** Very low. **Commits:** 1: guard. 2: delete. 3: docs.

---

## Phase 2: Move `error_handler.dart` to `core/errors/`

**Goal:** Move the last real code in `shared/errors/` and delete the directory.

**Files:**
- Move: `shared/errors/error_handler.dart` → `core/errors/error_handler.dart`
- Modify: `shared/widgets/app_error_widget.dart` (sole importer)
- Delete: `shared/errors/` directory

**Guard:** Add `shared/errors/error_handler.dart` to the retired paths.

**Effort:** Very low. 1 file, 1 importer.

---

## Phase 3: Move `constants/` to `core/constants/`

**Goal:** Relocate cross-cutting constants used by 27+ files.

**Files to move:**
- `shared/constants/api_constants.dart` → `core/constants/api_constants.dart`
- `shared/constants/app_dimens.dart` → `core/constants/app_dimens.dart`

**Import migration (~27 importers):**
- `shared/network/` (3 files: `dio_client.dart`, `csrf_interceptor.dart`, `cache_interceptor.dart`)
- `shared/widgets/` (3 files)
- ~21 feature files across auth, dynamic, favorites, history, home, live,
  notification, profile, ranking, search, to_view, video

**Guard:** Add both `shared/constants/` paths.

**Effort:** Medium. **Commits:** 1: guard. 2: move + migrate shared/ consumers.
3: migrate feature consumers. 4: delete + docs.

---

## Phase 4: Move `utils/` to `core/utils/`

**Goal:** Relocate 11 utility files used by 52+ files.

**Files to move (all 11):**
- `format_utils.dart`, `format_extensions.dart` (43 importers)
- `crypto_utils.dart`, `id_utils.dart`, `json_utils.dart`, `json_compute.dart`
- `list_utils.dart`, `danmaku_mask_parser.dart`
- `share_utils.dart`, `toast_utils.dart`, `validation_utils.dart`

**Import migration (~52 importers):**
- `shared/network/` (1: `json_compute.dart`)
- `shared/widgets/` (6 files)
- `shared/pagination/` (1: `list_utils.dart`)
- `shared/services/` (1: `share_utils.dart`)
- ~40 feature files

**Guard:** Add all 11 `shared/utils/` paths.

**Effort:** Medium-high. **Commits:** 1: guard. 2: move + migrate shared/ consumers.
3-5: migrate feature consumers in batches. 6: delete + docs.

---

## Phase 5: Move `hooks/` + `pagination/` to `core/`

**Goal:** Relocate the pagination framework and its hook companion.

**Files to move:**
- `shared/hooks/use_managed_easy_refresh_controller.dart` → `core/hooks/`
- `shared/pagination/` (7 files) → `core/pagination/`:
  - `page_query.dart`, `paged_list_state.dart`, `paged_list_state.freezed.dart`,
    `paged_list_state_transitions.dart`, `paged_async_notifier.dart`,
    `pagination_load_gate.dart`, `scroll_load_trigger.dart`

**Import migration (~42 importers):**
- Hooks: 5 (4 features + 1 shared widget)
- Pagination: 37 feature files

**Guard:** Add 8 paths (1 hooks + 7 pagination).

**Deps:** Phase 4 (`list_utils.dart` used by pagination).

**Effort:** Medium. **Commits:** 1: guard. 2: move + migrate shared/ consumers.
3-4: migrate feature consumers. 5: delete + docs.

---

## Phase 6: Move `network/` to `core/network/` (INFLECTION POINT)

**Goal:** Relocate the entire network infrastructure (25 files, 65 importers).

**Files to move (all):**
- Root: `dio_client.dart` (+.g.dart), `resource_api.dart` (+.g.dart),
  `resource_api_provider.dart` (+.g.dart), `request_executor.dart`,
  `request_executor_binding.dart`, `request_cancel_token.dart`,
  `network_concurrency_executor.dart`, `network_concurrency_profiles.dart`,
  `network_quality_policy.dart`
- `interceptors/` (7): token, csrf, retry, cache, in_flight_dedup, network_quality, wbi
- `models/` (3): `api_response.dart` (+.freezed.dart, +.g.dart)
- `providers/` (1): `wbi_helper_provider.dart`
- `dtos/` (2): `comment_contract_dto.dart`, `video_model_contract_dto.dart`

**Import migration (65 importers, 122 occurrences):**
- `shared/services/media_service.dart` (internal shared/ consumer)
- ~60 feature files across all features

**Guard:** Add all `shared/network/` source paths (skip .g.dart, .freezed.dart).

**Deps:** Phase 3 (constants) + Phase 4 (utils). By this point, `shared/network/`
has zero remaining `shared/` dependencies except `shared/constants/` and
`shared/utils/` which will already be in `core/`.

**Effort:** High. **Commits:** 1: guard. 2: move + migrate shared/ consumers.
3-5: migrate feature consumers in batches. 6: delete + docs.

---

## Phase 7: Move `services/` to `core/services/`

**Goal:** Relocate audio and media services.

**Files to move:**
- `audio_handler.dart`, `audio_playback_state_gate.dart`
- `media_service.dart`, `media_service.g.dart`

**Import migration (~4 importers):**
- `features/video/presentation/view_models/player_view_model.dart`
- `features/home/presentation/widgets/home_video_actions.dart`
- `shared/widgets/app_image_preview.dart` (until Phase 9 moves it)

**Guard:** Add 3 `shared/services/` source paths.

**Deps:** Phase 4 (utils) + Phase 6 (network, for `media_service.dart`).

**Effort:** Low. **Commits:** 1: guard. 2: move + migrate. 3: delete + docs.

---

## Phase 8: Resolve Theme Circular Barrel → `ui/theme/`

**Goal:** Break the circular re-export chain and move theme code to its canonical
home under `lib/ui/theme/`.

**Circular chain to resolve:**
```
shared/theme/app_theme.dart  →  exports ui/theme/app_theme.dart
ui/theme/app_theme.dart      →  exports shared/theme/culcul_colors.dart
                                 exports shared/theme/culcul_theme.dart
```

**Resolution steps:**
1. Move 4 files to `ui/theme/`:
   - `culcul_colors.dart`, `culcul_theme.dart`,
     `culcul_theme.components.dart` (part), `culcul_theme_palette.dart` (part)
2. Update `ui/theme/app_theme.dart`: change from `package:culcul/shared/theme/`
   exports to local relative exports
3. Delete `shared/theme/app_theme.dart` (re-export shim)
4. Delete `shared/theme/` directory

**Import migration:** ZERO. No file in the codebase imports `shared/theme/`
directly. All consumers use `ui/ui.dart` → `ui/theme/app_theme.dart`.

**Guard:** Add `shared/theme/app_theme.dart` (the shim).

**Effort:** Low. **Commits:** 1: move + fix barrel. 2: delete + docs.

---

## Phase 9: Move `widgets/` to `ui/widgets/` (FINAL BOSS)

**Goal:** Relocate all 48 widget files to their canonical design-system home.

**Sub-batch strategy (4 batches to keep reviews manageable):**

**Sub-batch 9a — Leaf widgets (~12 files, low internal deps):**
- `adaptive_blur.dart`, `app_overlay_tag.dart`, `app_min_lines_text.dart`,
  `app_tag.dart`, `app_tab_bar.dart`, `sliver_tab_bar_delegate.dart`,
  `icon_text.dart`, `follow_button.dart`, `privacy_error_widget.dart`,
  `video_actions_bottom_sheet.dart`, `guest_view.dart` + `guest_view/` (3 parts)

**Sub-batch 9b — Base primitives (~7 files):**
- `app_shimmer.dart`, `app_clickable.dart`, `app_selectable_text.dart`,
  `app_search_bar.dart`, `app_section_header.dart`, `refresh_header_footer.dart`,
  `app_empty_state_widget.dart`

**Sub-batch 9c — Composite widgets (~14 files):**
- `app_network_image.dart`, `app_network_image_prefetcher.dart`, `app_avatar.dart`,
  `app_card_container.dart`, `app_error_widget.dart`, `bilibili_emoji_text.dart`,
  `user_list_tile.dart`, `user_tags.dart`, `app_bottom_sheet.dart`,
  `app_image_preview.dart`, `app_image_preview.widgets.dart`,
  `skeletons/` (4 files)

**Sub-batch 9d — High-traffic composites (~15 files):**
- `video_thumbnail.dart`, `video_card.dart` + `video_card/` (3 parts),
  `video_list_card.dart` + `video_list_card/` (3 parts),
  `smart_paging_view.dart` + `smart_paging_view/` (2 parts)

**Total import migration:** 116 importers, ~205 occurrences across all features.

**Guard:** Add all `shared/widgets/` source paths.

**Deps:** All previous phases (1-8) must be complete. Widgets depend on
utils, constants, hooks, pagination, errors, and services — all of which
will be in `core/` by this point.

**Effort:** Very high. **Commits per sub-batch:** 1: guard (first batch only).
2: move + migrate. 3: delete + verify.

---

## Post-Phase 9: Final Cleanup

1. Verify `lib/shared/` is empty
2. Delete `lib/shared/` directory entirely
3. Update `docs/architecture/shared-boundary-rules.md` — document that
   `lib/shared/` is fully retired
4. Update `docs/architecture/phase3-structural-normalization-rules.md`
5. Add permanent architecture guard: fail if any file exists under `lib/shared/`
6. Run full validation:
   ```bash
   flutter test test/architecture --reporter compact
   flutter analyze
   ```

---

## Effort Summary

| Phase | Description | Files | Importers | Effort |
|---|---|---|---|---|
| 0 | Archive plans | 2 renames | 0 | Trivial |
| 1 | Delete stale/re-exports | 14 deleted | 0 | Very low |
| 2 | error_handler → core/errors | 1 moved | 1 | Very low |
| 3 | constants → core/constants | 2 moved | ~27 | Medium |
| 4 | utils → core/utils | 11 moved | ~52 | Med-high |
| 5 | hooks+pagination → core | 8 moved | ~42 | Medium |
| 6 | network → core/network | 25 moved | ~65 | High |
| 7 | services → core/services | 4 moved | ~4 | Low |
| 8 | theme → ui/theme | 4 moved | 0 | Low |
| 9 | widgets → ui/widgets | 48 moved | ~116 | Very high |

**Total:** 118 files, ~307 importers across all phases.

**Recommended session grouping:**
- Session 1: Phases 0-2 (quick wins, 17 files removed)
- Session 2: Phase 3 + Phase 4 (constants + utils, foundational moves)
- Session 3: Phase 5 (hooks + pagination)
- Session 4: Phase 6 (network, the big one)
- Session 5: Phases 7-8 (services + theme, quick)
- Session 6-7: Phase 9 sub-batches (widgets)
- Session 8: Post-phase-9 cleanup + final verification
