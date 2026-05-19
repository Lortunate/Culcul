# culcul

A 3rd-party BiliBili client built with Flutter.

## Bootstrap

From a fresh checkout or worktree, install dependencies first:

```bash
flutter pub get
```

## Recover Ignored Generated Artifacts

This repo does not track generated `*.g.dart` files. A fresh checkout/worktree
can therefore be missing required artifacts such as:

- `lib/i18n/strings.g.dart`
- `lib/app/router/app_routes.g.dart`

Use the repo-local recovery helper from Git Bash:

```bash
bash scripts/bootstrap_codegen.sh
```

The script runs the repository's required code generation sequence:

```bash
flutter pub get
dart run slang
dart run build_runner build --delete-conflicting-outputs
```

If `build_runner` reports `InvalidOutputException` for
`lib/i18n/strings.g.dart`, verify the file exists before treating recovery as
failed because `dart run slang` may already have restored it.

After recovery, a focused validation command is:

```bash
flutter test test/app/shell/main_shell_responsive_test.dart --reporter compact
```

If you need a broader check, run:

```bash
flutter analyze --no-fatal-infos
```

## Architecture Guard

For the repo-local architecture guard entrypoint, run:

```bash
bash tool/architecture/run_architecture_guards.sh
```
