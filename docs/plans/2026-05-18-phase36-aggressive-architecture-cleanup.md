# Phase 36 Aggressive Architecture Cleanup Plan

## Operating Rules

- Spec: `docs/specs/2026-05-18-phase36-aggressive-architecture-cleanup.md`.
- Epic: `culcul-rg4`.
- Use `bd` for work status. Do not create markdown task trackers.
- Run GitNexus impact before editing any function, class, or method.
- Stop before editing HIGH or CRITICAL risk symbols.
- Use Context7 before changing library APIs.
- Keep generated files consistent with build_runner.
- Delete obsolete code after callers move. Do not leave compatibility shims.

## Recommended Target Structure

```text
lib/
  app/       startup, root provider overrides, router, shell
  core/      contracts, infra, errors, result, feedback, storage, perf
  features/  feature-owned data/application/presentation/domain
  ui/        shared UI primitives, theme, responsive helpers
  i18n/      localization sources and generated files
  protos/    generated protobuf integration surface
```

Feature internals:

```text
features/<feature>/
  data/
    api/
    dtos/
    local/
    repositories/
  application/
    providers/
    controllers/
  presentation/
    pages/
    widgets/
    view_models/
  domain/
    entities/
    policies/
```

## Phase Plan

| Phase | Work | Scope | Output | Verification |
| --- | --- | --- | --- | --- |
| 1. Code audit | Re-scan source tree, imports, generated files, bd status, GitNexus status. | `lib`, `test`, `docs`, `.beads` | Current architecture problem list and candidate slices. | `bd list --json`, `git status`, GitNexus query/detect baseline. |
| 2. Duplicate detection | Identify duplicate DTO/model/entity/state/config/error/network/storage patterns. | `core/contracts`, `core/data`, `features/*/{data,domain,application,presentation}` | Merge/delete list with owning path for each concept. | Import search shows one owner per concept before editing. |
| 3. Directory design | Apply target folder rules to candidate features. | Mostly `features/video`, `features/dynamic`, `features/notification`, `features/profile`, `features/live` | Feature-local move map. | Architecture guide and import guards agree with target structure. |
| 4. Model unification | Move shared shapes to `core/contracts`; keep remote payloads in `data/dtos`; delete empty domain entities. | DTO/entity/model files and mappers | One model owner per payload. | Build runner, analyzer, model import scan. |
| 5. State unification | Replace ad hoc state owners with generated Riverpod providers and feature view models. | `application`, `presentation/view_models` | One provider owner per state concept. | Provider import scan, focused tests. |
| 6. Network/storage/config unification | Consolidate Dio/cache/policy/storage keys/database owners. | `core/data`, `core/storage`, feature `data/local` | Single network/cache/storage/database path per concern. | Analyzer, repository tests, no duplicate key/policy definitions. |
| 7. UI/business split | Move business logic out of widgets and remove direct presentation imports of DTO internals where not needed. | `features/*/presentation`, `features/*/application` | Smaller widgets; view models own coordination. | Widget-focused analyzer and tests. |
| 8. Dead code removal | Delete unused helpers, wrappers, aliases, empty adapters, export-only barrels. | `core/utils`, `features/**/*helpers.dart`, `features/**/*utils.dart`, route/provider aliases | Deleted or merged files. | `rg` import checks, analyzer. |
| 9. Performance cleanup | Reduce startup work, rebuild scope, stream breadth, cache pressure, media lifecycle leaks. | `main.dart`, `app/bootstrap`, `core/perf`, hot features | Measured/simple reductions with no new cache unless justified. | Existing performance docs updated; analyze/tests pass. |
| 10. Archive old architecture | Move old docs to archive; delete old code after no callers remain. | `docs/specs`, `docs/plans`, `docs/architecture`, optional `archive` | Only Phase 36 active. | Architecture guide links only active spec/plan plus archived history. |
| 11. Build/test/run validation | Regenerate, format, analyze, test, detect affected flows. | Whole repo or focused touched paths | Green validation report. | build_runner, formatter, analyzer, focused tests, architecture guards, GitNexus detect_changes. |

## Delete, Merge, Archive Candidates

Delete or merge first when import checks prove no behavior loss:

- Helper files: `auth_repository_impl.helpers.dart`,
  `notification_repository_impl.message_support_helpers.dart`,
  `notification_list_page_helpers.dart`, `chat_view_model.helpers.dart`,
  `video_detail_view_model.helpers.dart`, `player_view_model.load_helpers.dart`.
- Utility files: `core/utils/format_utils.dart`, `json_utils.dart`,
  `list_utils.dart`, `share_utils.dart`,
  `home_feed_view_utils.dart`, `controls_utils.dart`.
- Completed utility removals: `core/utils/id_utils.dart` was localized into
  `home_video_actions.dart` because BVID conversion has a single caller;
  `core/utils/danmaku_mask_parser.dart` was localized into
  `video_extra_workflows.dart` because mask parsing is video-only application
  logic.
- Mapper files: `article_detail_parser.mapper.dart`,
  `dynamic_item_extensions.mappers.dart`, `favorite_mapper.dart`,
  `history_mapper.dart`.
- Split repository files: notification repository partial services and sync
  helpers, auth repository flow/helper split, video load helper split.
- Duplicate model families: DTO/entity/model pairs for favorites, live,
  dynamic, profile, search, and shared contracts.
- Docs: superseded specs/plans go under existing `docs/**/archive`.

Do not delete generated files directly unless their source file was removed and
build_runner confirms the generated output disappears.

## First Executable Slice

Slice A is documentation and routing/source-of-truth alignment:

1. Keep Phase 36 spec/plan as the active source of truth.
2. Confirm `docs/architecture/architecture-guide.md` points to these files.
3. Scan route/provider aliases and identify low-risk route pointer cleanup.
4. For each route/provider symbol to edit, run GitNexus impact and report risk.
5. Apply one low-risk cleanup slice.
6. Regenerate if required, format touched Dart files, analyze, run focused tests,
   run architecture guards, then GitNexus detect_changes.

## Validation Commands

Prefer Dart MCP tools where available:

```bash
dart run build_runner build --delete-conflicting-outputs
dart format lib test
flutter analyze
flutter test
bash tool/architecture/run_architecture_guards.sh
```

Final GitNexus check:

```text
detect_changes(scope: "all", repo: "Culcul")
```
