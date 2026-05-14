<!-- gitnexus:start -->
# GitNexus — Code Intelligence

This project is indexed by GitNexus as **Culcul** (2084 symbols, 2880 relationships, 27 execution flows). Use the GitNexus MCP tools to understand code, assess impact, and navigate safely.

> If any GitNexus tool warns the index is stale, run `npx gitnexus analyze` in terminal first.

## Always Do

- **MUST run impact analysis before editing any symbol.** Before modifying a function, class, or method, run `gitnexus_impact({target: "symbolName", direction: "upstream"})` and report the blast radius (direct callers, affected processes, risk level) to the user.
- **MUST run `gitnexus_detect_changes()` before committing** to verify your changes only affect expected symbols and execution flows.
- **MUST warn the user** if impact analysis returns HIGH or CRITICAL risk before proceeding with edits.
- When exploring unfamiliar code, use `gitnexus_query({query: "concept"})` to find execution flows instead of grepping. It returns process-grouped results ranked by relevance.
- When you need full context on a specific symbol — callers, callees, which execution flows it participates in — use `gitnexus_context({name: "symbolName"})`.

## Never Do

- NEVER edit a function, class, or method without first running `gitnexus_impact` on it.
- NEVER ignore HIGH or CRITICAL risk warnings from impact analysis.
- NEVER rename symbols with find-and-replace — use `gitnexus_rename` which understands the call graph.
- NEVER commit changes without running `gitnexus_detect_changes()` to check affected scope.

## Resources

| Resource | Use for |
|----------|---------|
| `gitnexus://repo/Culcul/context` | Codebase overview, check index freshness |
| `gitnexus://repo/Culcul/clusters` | All functional areas |
| `gitnexus://repo/Culcul/processes` | All execution flows |
| `gitnexus://repo/Culcul/process/{name}` | Step-by-step execution trace |

## CLI

| Task | Read this skill file |
|------|---------------------|
| Understand architecture / "How does X work?" | `.claude/skills/gitnexus/gitnexus-exploring/SKILL.md` |
| Blast radius / "What breaks if I change X?" | `.claude/skills/gitnexus/gitnexus-impact-analysis/SKILL.md` |
| Trace bugs / "Why is X failing?" | `.claude/skills/gitnexus/gitnexus-debugging/SKILL.md` |
| Rename / extract / split / refactor | `.claude/skills/gitnexus/gitnexus-refactoring/SKILL.md` |
| Tools, resources, schema reference | `.claude/skills/gitnexus/gitnexus-guide/SKILL.md` |
| Index, status, clean, wiki CLI commands | `.claude/skills/gitnexus/gitnexus-cli/SKILL.md` |

<!-- gitnexus:end -->

## Architecture (Phase 25 — Surface Reduction)

`lib/shared/` is **fully retired**. The architecture is `app/` + `features/` + `core/` + `ui/`. Phases 1–24 completed structural cleanup, barrel elimination, freezed/@riverpod migration, model deduplication, abstract repo removal, dead weight removal, provider/bootstrap cleanup, runtime/network consolidation, and source-of-truth cleanup. Phase 25 targets architecture surface reduction: narrow feature public seams, thin domain layer collapse, generated/source audit separation, router alias cleanup, and dependency/config source-of-truth cleanup.

Active spec: `docs/specs/phase25-architecture-surface-reduction.md`
Active plan: `docs/plans/phase25-architecture-surface-reduction.md`
Architecture guide: `docs/architecture/architecture-guide.md`
Archived: Phase 22 spec/plan, Phase 23 performance draft, and completed Phase 24 spec/plan in `docs/specs/archive/` and `docs/plans/archive/`

**Key rules**:
- `core/` and `ui/` must NOT import from `features/`
- Features must NOT import another feature's `presentation/**` or `data/**` internals
- `route_entry.dart` is the router-facing seam; `feature_scope.dart` and `<feature>.dart` are the approved runtime/composition seams
- `feature_scope.dart` exports only runtime composition needed outside the feature; do not export data/presentation internals by default
- DTOs belong in `data/dtos/`, never in `domain/`
- Every shared model has exactly ONE definition in `core/contracts/`
- All domain entities and DTOs use freezed — no hand-written `copyWith` or equality
- No typedef-only or re-export-only files — import the source directly
- No barrel-chain files (file that only re-exports other files) except `core_contracts.dart` and the approved UI public API `lib/ui/ui.dart`
- All dependencies pinned to specific versions (no `any`)
- Prefer `shared_preferences` + `flutter_secure_storage` over Hive for local storage
- Prefer `dio_smart_retry` over custom retry logic; prefer generated providers over hand-written wiring
- Riverpod 3 work MUST use `@riverpod` generated providers and `Notifier`/`AsyncNotifier` patterns — no new hand-written providers
- go_router is already typed/generated through `go_router_builder`; do not rewrite routing unless a route seam is actually broken
- Prefer `pointycastle` + `crypto` for cryptography; do not use `encrypt` wrapper
- Features must reuse `VideoOwner`/`VideoStat` from core contracts — no feature-local duplicates
- Repository interfaces only where they enable mocking or polymorphism — simple features use impl directly
- Simple features (ranking, history) may omit `domain/` layer if no business logic exists
- Single error hierarchy: `AppError` (sealed, implements Exception) — no separate `AppException`
- Single notification pattern: `AppFeedback` extension on `BuildContext` — no raw ScaffoldMessenger calls
- Shared API services in `core/services/` for cross-feature endpoints (comments, etc.)
- No business logic in DTOs — business methods belong in domain entities only
- If architecture docs disagree, the active Phase 25 spec/plan override older phase text

<!-- BEGIN BEADS INTEGRATION v:1 profile:full hash:f65d5d33 -->
## Issue Tracking with bd (beads)

**IMPORTANT**: This project uses **bd (beads)** for ALL issue tracking. Do NOT use markdown TODOs, task lists, or other tracking methods.

### Why bd?

- Dependency-aware: Track blockers and relationships between issues
- Git-friendly: Dolt-powered version control with native sync
- Agent-optimized: JSON output, ready work detection, discovered-from links
- Prevents duplicate tracking systems and confusion

### Quick Start

**Check for ready work:**

```bash
bd ready --json
```

**Create new issues:**

```bash
bd create "Issue title" --description="Detailed context" -t bug|feature|task -p 0-4 --json
bd create "Issue title" --description="What this issue is about" -p 1 --deps discovered-from:bd-123 --json
```

**Claim and update:**

```bash
bd update <id> --claim --json
bd update bd-42 --priority 1 --json
```

**Complete work:**

```bash
bd close bd-42 --reason "Completed" --json
```

### Issue Types

- `bug` - Something broken
- `feature` - New functionality
- `task` - Work item (tests, docs, refactoring)
- `epic` - Large feature with subtasks
- `chore` - Maintenance (dependencies, tooling)

### Priorities

- `0` - Critical (security, data loss, broken builds)
- `1` - High (major features, important bugs)
- `2` - Medium (default, nice-to-have)
- `3` - Low (polish, optimization)
- `4` - Backlog (future ideas)

### Workflow for AI Agents

1. **Check ready work**: `bd ready` shows unblocked issues
2. **Claim your task atomically**: `bd update <id> --claim`
3. **Work on it**: Implement, test, document
4. **Discover new work?** Create linked issue:
   - `bd create "Found bug" --description="Details about what was found" -p 1 --deps discovered-from:<parent-id>`
5. **Complete**: `bd close <id> --reason "Done"`

### Quality
- Use `--acceptance` and `--design` fields when creating issues
- Use `--validate` to check description completeness

### Lifecycle
- `bd defer <id>` / `bd supersede <id>` for issue management
- `bd stale` / `bd orphans` / `bd lint` for hygiene
- `bd human <id>` to flag for human decisions
- `bd formula list` / `bd mol pour <name>` for structured workflows

### Auto-Sync

bd automatically syncs via Dolt:

- Each write auto-commits to Dolt history
- Use `bd dolt push`/`bd dolt pull` for remote sync
- No manual export/import needed!

### Important Rules

- Use bd for ALL task tracking
- Always use `--json` flag for programmatic use
- Link discovered work with `discovered-from` dependencies
- Check `bd ready` before asking "what should I work on?"
- Do NOT create markdown TODO lists
- Do NOT use external issue trackers
- Do NOT duplicate tracking systems

For more details, see README.md and docs/QUICKSTART.md.

## Session Completion

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd dolt push
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds

<!-- END BEADS INTEGRATION -->
