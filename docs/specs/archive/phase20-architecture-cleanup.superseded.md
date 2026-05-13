> Superseded by `docs/specs/phase21-consolidation-and-modernization.md`.
> Archived on 2026-05-13 after Phase 20 cleanup was rolled into Phase 21.

# Phase 20: Architecture Cleanup & Dead Weight Removal

**Date**: 2026-05-13
**Status**: Draft
**Scope**: Remove ceremony-only abstractions, unify duplicated logic, simplify wrappers

## Motivation

Phase 19 identified dead weight. Phase 20 executes the removal. The project has 667 source files with significant ceremony code that adds maintenance cost without enabling testing, polymorphism, or extensibility. This phase makes the codebase leaner and more honest about what it actually does.

## Principles

1. **No interface without a second consumer** — abstract repos exist only if mocked or swapped
2. **No wrapper that leaks its inner type** — either commit to the abstraction or use the real type
3. **No freezed class for a single primitive** — use a typedef or the raw type
4. **No duplicate state/logic** — identical patterns get extracted once
5. **No file under 5 lines of logic** — inline or merge into its only consumer

---

## Work Items

### WI-1: Remove Abstract Repository Interfaces (8 files)

**Problem**: 8 features declare abstract repository interfaces in `domain/repositories/` with exactly one implementation and zero test consumers. The interfaces add maintenance burden (keeping signatures in sync) with no benefit.

**Files to delete**:
- `lib/features/auth/domain/repositories/auth_repository.dart`
- `lib/features/dynamic/domain/repositories/dynamic_repository.dart`
- `lib/features/favorites/domain/repositories/favorite_repository.dart`
- `lib/features/live/domain/repositories/live_repository.dart`
- `lib/features/notification/domain/repositories/notification_repository.dart`
- `lib/features/profile/domain/repositories/profile_repository.dart`
- `lib/features/search/domain/repositories/search_repository.dart`
- `lib/features/video/domain/repositories/video_repository.dart`

**Action**:
1. Remove `implements XxxRepository` / `extends XxxRepository` from each impl class
2. Remove `import ... as domain` from impl files
3. Delete the abstract interface files
4. Update provider return types from abstract to impl class
5. Delete empty `domain/repositories/` directories

**Risk**: LOW — no consumer references the abstract type directly; all use the impl provider.

---

### WI-2: Remove RequestCancelToken Wrapper (1 file, 16 consumers)

**Problem**: `RequestCancelToken` wraps Dio's `CancelToken` but leaks it via `.dioToken` getter. The only added behavior is a null-check on cancel (which CancelToken already handles safely in recent versions). Every consumer that passes it to Dio accesses `.dioToken` anyway.

**File to delete**: `lib/core/data/network/request_cancel_token.dart`

**Action**:
1. Replace all `RequestCancelToken` usages with `CancelToken` from dio
2. Replace `.dioToken` accesses with direct usage
3. Replace `RequestCancelToken()` with `CancelToken()`
4. Delete the wrapper file

**Risk**: LOW — behavioral change is nil; CancelToken.cancel() is already idempotent.

---

### WI-3: Unify Comment State (2 → 1 shared definition)

**Problem**: `VideoCommentsState` and `DynamicCommentState` are byte-for-byte identical:
```dart
@freezed
sealed class XxxState with _$XxxState {
  const factory XxxState({
    @Default(PagedListState<CommentItem>()) PagedListState<CommentItem> paging,
    @Default(CommentSort.hot) CommentSort sort,
  }) = _XxxState;
}
```

**Action**:
1. Create `lib/ui/assemblies/comments/comment_list_state.dart` with a single `CommentListState`
2. Replace both feature-local states with the shared one
3. Delete `video_comments_state.dart` and `dynamic_comment_state.dart`
4. Update view model type references

**Risk**: LOW — pure type rename, no behavioral change.

---

### WI-4: Collapse Single-Field Freezed Classes (2 files)

**Problem**: `SearchDefaultHint` and `SearchSuggestionEntry` each wrap a single `String` field. Freezed generates ~100 lines of boilerplate per class for zero semantic benefit over a typedef.

**Files to delete**:
- `lib/features/search/domain/entities/search_default_hint.dart`
- `lib/features/search/domain/entities/search_suggestion_entry.dart`

**Action**:
1. Replace `SearchDefaultHint` with `typedef SearchDefaultHint = String` (or inline the String)
2. Replace `SearchSuggestionEntry` with `typedef SearchSuggestionEntry = String` (or inline)
3. Update all consumers (likely search view models and widgets)
4. Delete the freezed files and their generated `.freezed.dart` counterparts

**Risk**: LOW — these are leaf types with no complex behavior.

---

### WI-5: Remove i18n Convenience Wrapper (1 file)

**Problem**: `lib/i18n/i18n.dart` contains a single line:
```dart
Translations i18n(BuildContext context) => Translations.of(context);
```
This saves 15 characters per call site but adds a file and an import.

**Action**:
1. Replace all `i18n(context).xxx` calls with `Translations.of(context).xxx`
   — OR keep the function but move it into `lib/i18n/strings.g.dart` as an extension
2. Delete `lib/i18n/i18n.dart`

**Alternative**: If the team prefers the short form, convert to an extension method on `BuildContext`:
```dart
extension I18nContext on BuildContext {
  Translations get t => Translations.of(this);
}
```
This is more idiomatic Flutter and eliminates the standalone file. Usage becomes `context.t.xxx`.

**Recommended**: Use the `context.t` extension pattern — it's shorter than both alternatives and follows Flutter conventions.

**Risk**: LOW — mechanical find-and-replace.

---

### WI-6: Remove Unnecessary Barrel Files (2 files)

**Problem**: These barrel files only re-export and add no logic:
- `lib/ui/assemblies/feed_cards/feed_cards.dart` (5 exports)
- `lib/core/data/pagination/pagination.dart` (6 exports)

Per architecture rules: "No barrel-chain files except `core_contracts.dart`"

**Action**:
1. Find all importers of these barrel files
2. Replace with direct imports of the specific file needed
3. Delete the barrel files

**Risk**: LOW — import path changes only.

---

### WI-7: Flatten Trivial Domain Layers

**Problem**: Features like `favorites`, `search`, `notification` have `domain/entities/` with models that are only used by their own feature's presentation layer. When there's no cross-feature sharing and no business logic transformation, the domain layer is pure ceremony.

**Action** (conservative):
1. For features where domain entities are 1:1 mappings of DTOs with no business methods: move entities into `data/` as the canonical model (DTO becomes the entity)
2. Remove empty `domain/` directories
3. Keep `domain/entities/` only where models have business logic or are shared via `core/contracts/`

**Candidates for flattening**:
- `search/domain/entities/search_trending_keyword.dart` → inline or move to data
- `to_view/domain/entities/to_view_entry.dart` → check if it's just a DTO rename
- `history/domain/entities/history_entry.dart` → already no abstract repo, check if domain layer adds value

**Risk**: MEDIUM — requires verifying each entity isn't referenced cross-feature.

---

### WI-8: Dependency Audit

**Problem**: Some dependencies may be replaceable or removable.

**Audit items**:
- `gt3_flutter_plugin: ^0.1.1` — GeeTest captcha. Verify still used.
- `archive: ^4.0.9` — Check if only used in one place; if so, is it worth the dep?
- `flutter_riverpod: ^3.3.1` in dev_dependencies — No tests exist. Remove if unused.
- `path_drawing: ^1.0.1` — Verify usage scope.

**Action**: Grep each dependency, remove if unused, document if niche but necessary.

**Risk**: LOW — removing unused deps has no runtime effect.

---

## Execution Order

1. **WI-8** (Dependency Audit) — quick wins, no code changes needed
2. **WI-1** (Remove Abstract Repos) — largest file count reduction
3. **WI-2** (Remove RequestCancelToken) — simple mechanical replacement
4. **WI-4** (Collapse Single-Field Freezed) — small but clean
5. **WI-5** (i18n Extension) — improves DX
6. **WI-6** (Remove Barrels) — import cleanup
7. **WI-3** (Unify Comment State) — requires careful testing
8. **WI-7** (Flatten Domain Layers) — most judgment required

## Success Criteria

- [ ] Zero abstract repository interfaces without a second consumer
- [ ] Zero wrapper classes that leak their inner type
- [ ] Zero single-field freezed classes
- [ ] Zero barrel files (except `core_contracts.dart`)
- [ ] Comment state defined exactly once
- [ ] `dart analyze` passes with zero errors
- [ ] `dart run build_runner build` succeeds
- [ ] App builds and runs without regression

## Out of Scope

- Adding tests (separate initiative)
- Riverpod 3 migration of remaining hand-written providers in `core/session/` (these use the override pattern intentionally)
- Router restructuring (go_router_builder is working fine)
- UI/widget refactoring (separate from architecture cleanup)
