# Phase 20 Execution Plan: Architecture Cleanup & Dead Weight Removal

**Created**: 2026-05-13
**Spec**: `docs/specs/phase20-architecture-cleanup.md`
**Status**: Ready for execution

---

## Execution Strategy

Work items are ordered by risk (low → medium) and dependency (independent items first).
Items WI-1, WI-2, WI-4, WI-5, WI-6, WI-8 are fully independent and can be parallelized.
WI-3 and WI-7 require more judgment and should be done sequentially after the mechanical items.

---

## Phase A: Quick Wins (Parallel — No Code Logic Changes)

### Step 1: Dependency Audit (WI-8)

**Goal**: Remove unused dependencies from `pubspec.yaml`.

1. Grep for `gt3_flutter_plugin` usage in `lib/` — verify still used
2. Grep for `archive` usage in `lib/` — check scope
3. Grep for `flutter_riverpod` usage in `test/` — remove from dev_deps if no tests
4. Grep for `path_drawing` usage in `lib/` — verify scope
5. Remove any confirmed-unused deps from `pubspec.yaml`
6. Run `flutter pub get` to verify resolution

**Verification**: `flutter pub get` succeeds, no import errors in `dart analyze`

---

### Step 2: Remove Abstract Repository Interfaces (WI-1)

**Goal**: Delete 8 abstract repo interfaces, update 8 impl classes.

For each feature (`auth`, `dynamic`, `favorites`, `live`, `notification`, `profile`, `search`, `video`):

1. Read the abstract interface to confirm it has exactly one impl
2. Read the impl class to find `implements XxxRepository` clause
3. Remove `implements XxxRepository` from impl class
4. Remove the abstract interface import from impl file
5. Check if any provider file references the abstract type → update to impl type
6. Delete the abstract interface file
7. Delete empty `domain/repositories/` directory if no other files remain

**Verification**: `dart analyze` passes, no dangling imports

---

### Step 3: Remove RequestCancelToken Wrapper (WI-2)

**Goal**: Replace custom wrapper with Dio's native `CancelToken`.

1. Read `lib/core/data/network/request_cancel_token.dart` to confirm behavior
2. Grep all usages of `RequestCancelToken` across codebase
3. Replace `RequestCancelToken` → `CancelToken` (from `package:dio/dio.dart`)
4. Replace `.dioToken` accesses → direct variable usage
5. Replace `RequestCancelToken()` → `CancelToken()`
6. Update imports: remove custom file import, add/verify dio import
7. Delete `lib/core/data/network/request_cancel_token.dart`

**Verification**: `dart analyze` passes, cancel behavior unchanged

---

### Step 4: Collapse Single-Field Freezed Classes (WI-4)

**Goal**: Replace 2 single-field freezed classes with typedefs or raw String.

1. Read `search_default_hint.dart` — confirm single String field
2. Grep all consumers of `SearchDefaultHint`
3. Replace with `typedef SearchDefaultHint = String` or inline String
4. Read `search_suggestion_entry.dart` — confirm single String field
5. Grep all consumers of `SearchSuggestionEntry`
6. Replace with `typedef SearchSuggestionEntry = String` or inline String
7. Delete the `.dart` and `.freezed.dart` files for both
8. Run `build_runner build` to regenerate (or just delete generated files)

**Verification**: `dart analyze` passes, search feature works

---

### Step 5: i18n Extension Pattern (WI-5)

**Goal**: Replace `i18n(context)` function with `context.t` extension.

1. Read `lib/i18n/i18n.dart` to confirm current implementation
2. Create extension method on `BuildContext` (in appropriate location, e.g., `lib/i18n/i18n_extension.dart` or inline in `strings.g.dart`)
3. Grep all `i18n(context)` call sites
4. Replace `i18n(context).xxx` → `context.t.xxx`
5. Update imports at each call site
6. Delete `lib/i18n/i18n.dart`

**Verification**: `dart analyze` passes, all strings render correctly

---

### Step 6: Remove Barrel Files (WI-6)

**Goal**: Eliminate 2 barrel files, replace with direct imports.

1. Read `lib/ui/assemblies/feed_cards/feed_cards.dart` — list its exports
2. Grep all importers of this barrel
3. Replace each barrel import with the specific file import needed
4. Delete the barrel file
5. Repeat for `lib/core/data/pagination/pagination.dart`

**Verification**: `dart analyze` passes, no unresolved imports

---

## Phase B: Judgment-Required Items (Sequential)

### Step 7: Unify Comment State (WI-3)

**Goal**: Merge duplicate `VideoCommentsState` and `DynamicCommentState` into one.

1. Read both state files, confirm they are structurally identical
2. Create `lib/ui/assemblies/comments/comment_list_state.dart` with unified `CommentListState`
3. Update `VideoCommentsViewModel` to use `CommentListState`
4. Update `DynamicCommentViewModel` to use `CommentListState`
5. Delete the two feature-local state files
6. Run `build_runner build` to regenerate freezed code

**Verification**: `dart analyze` passes, both comment UIs function correctly

---

### Step 8: Flatten Trivial Domain Layers (WI-7)

**Goal**: Remove ceremony-only domain layers where entities are 1:1 DTO mappings.

For each candidate (`search_trending_keyword`, `to_view_entry`, `history_entry`):

1. Read the domain entity — check for business methods
2. Read the corresponding DTO — compare fields
3. Check cross-feature references (grep the entity type name)
4. If entity is pure data with no logic and no cross-feature use:
   - Make the DTO the canonical model
   - Update consumers to use DTO directly
   - Delete the domain entity file
5. Remove empty `domain/` directories

**Verification**: `dart analyze` passes, affected features work correctly

---

## Final Verification Gate

After all steps complete:

```bash
dart analyze                          # Zero errors
dart run build_runner build           # Codegen succeeds
flutter build apk --debug            # App builds
# Manual: launch app, verify core flows
```

---

## Risk Matrix

| Step | WI  | Risk   | Parallelizable | Est. Files Changed |
|------|-----|--------|----------------|-------------------|
| 1    | 8   | LOW    | Yes            | 1 (pubspec.yaml)  |
| 2    | 1   | LOW    | Yes            | ~16               |
| 3    | 2   | LOW    | Yes            | ~17               |
| 4    | 4   | LOW    | Yes            | ~6                |
| 5    | 5   | LOW    | Yes            | ~30+              |
| 6    | 6   | LOW    | Yes            | ~12               |
| 7    | 3   | LOW    | No             | ~6                |
| 8    | 7   | MEDIUM | No             | ~9                |

---

## Notes

- Steps 1–6 (Phase A) can all be dispatched as parallel subagents
- Steps 7–8 (Phase B) should be done after Phase A passes verification
- Each step should run `dart analyze` as its own verification before moving on
- If any step reveals unexpected cross-feature coupling, stop and reassess
