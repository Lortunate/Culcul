# culcul

A 3rd-party BiliBili client built with Flutter.

## Bootstrap

From a fresh checkout or worktree, install dependencies first:

```bash
flutter pub get
```

## Recover Ignored Generated Artifacts

This repo ignores most generated Dart artifacts. A fresh checkout/worktree can
therefore be missing required artifacts such as:

- `lib/i18n/strings.g.dart`
- `lib/app/router/app_routes.g.dart`

Checked-in generated exceptions are limited to bootstrap/runtime artifacts that
must exist before local code generation can run:

- `lib/core/runtime/runtime_lifecycle_provider.g.dart`
- `lib/core/runtime/runtime_performance_policy_provider.g.dart`
- `lib/features/profile/data/local/profile_cache_database.g.dart`
- `lib/protos/dm.pb.dart`
- `lib/protos/dm.pbenum.dart`

Use the repo-local recovery helper from Git Bash:

```bash
bash scripts/bootstrap_codegen.sh
```

The script runs the repository's required code generation sequence:

```bash
flutter pub get
dart run slang
dart run build_runner build
```

Launcher icons are regenerated separately when `assets/icon/icon.png` or
`flutter_launcher_icons.yaml` changes:

```bash
dart run flutter_launcher_icons
```

If `build_runner` reports `InvalidOutputException` for
`lib/i18n/strings.g.dart`, verify the file exists before treating recovery as
failed because `dart run slang` may already have restored it.

After recovery, run the active validation commands:

```bash
bash tool/architecture/run_architecture_guards.sh
bash tool/format_dart.sh --check
flutter analyze --no-fatal-infos
```

There are currently no checked-in tests. Once tests exist, run:

```bash
flutter test
```

## Architecture Guard

For the repo-local architecture guard entrypoint, run:

```bash
bash tool/architecture/run_architecture_guards.sh
```
