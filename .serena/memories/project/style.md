# Culcul code style and conventions
- Prefer small, feature-scoped widgets and keep UI logic close to the feature unless it is shared.
- Riverpod providers are common for state and repository wiring; use `@riverpod` / `FutureProvider.family` patterns already present in the repo.
- GoRouter typed routes live in `lib/app/router/app_routes.dart` and are used for page navigation.
- Reusable UI primitives live under `lib/ui/widgets`; reuse them instead of introducing ad hoc styling when possible.
- Keep edits minimal and scoped; do not revert unrelated work.
- Use `dart format` and `flutter analyze` after code changes; full-project analyze is expected to pass.