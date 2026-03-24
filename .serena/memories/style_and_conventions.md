# Style and conventions
- Follow `AGENT.md`: use semantic theme colors from project theme, avoid hardcoded colors, keep UI modern/flat and familiar to Bilibili users.
- Keep widgets focused and composable; split large pages into smaller private widgets or widgets files when readability improves.
- Avoid deep widget nesting and preserve public APIs unless required.
- Prefer minimal targeted refactors over over-design or formatting-only changes.
- Use modern Dart/Flutter APIs where they fit naturally (e.g. pattern matching, concise closures).