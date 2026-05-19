# Core

- Flutter app `culcul`, repo root `E:/Projects/Flutter/Culcul`.
- Top-level `lib/` shape: `app/`, `core/`, `features/`, `ui/`, `i18n/`, `protos/`; `lib/shared/` is retired and must not return.
- Read `mem:tech_stack` for framework/package/codegen details.
- Read `mem:conventions` for architecture boundaries and current Phase 37 rules.
- Read `mem:suggested_commands` for Git Bash command forms and project entrypoints.
- Read `mem:task_completion` before ending coding work.
- App entry: `lib/main.dart` calls `AppBootstrap.initialize()`, merges bootstrap overrides with `createRootOverrides()`, validates overrides, starts `FrameTimingSampler`, runs `TranslationProvider` + `ProviderScope` + `CulculApp`, then schedules deferred init after first frame.
- `lib/app/app.dart` owns root `MaterialApp.router`, theme, localization delegates, global scaffold messenger, and watches `routerProvider` + `appThemeModeProvider`.
- `app/` owns startup, root overrides, typed router, and shell composition. `core/` owns cross-feature primitives with real runtime/platform value. `features/<feature>` owns feature DTOs, repositories, state, UI, routes, and workflows. `ui/` owns reusable UI primitives and approved UI public API.
- Feature folders currently include: `auth`, `dynamic`, `favorites`, `history`, `home`, `live`, `notification`, `profile`, `ranking`, `search`, `settings`, `to_view`, `video`.
- Active architecture source: `docs/architecture/architecture-guide.md`, `docs/specs/2026-05-19-phase37-modern-architecture-consolidation.md`, `docs/plans/2026-05-19-phase37-modern-architecture-consolidation.md`. Phase 35/36 are superseded before code execution.