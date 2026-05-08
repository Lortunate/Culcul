// Pagination utilities for the app.
//
// Two strategies are available — pick one per view model:
//
// Mixin-based (`OffsetPagedAsyncNotifier`, `CursorPagedAsyncNotifier`):
//   Mix into an `AsyncNotifier` for simple list + load-more.
//   Manages page tracking, dedup, and refresh internally.
//   Best for: straightforward infinite-scroll lists.
//
// State-based (`PagedListState` + `PagedListStateTransitions`):
//   Freezed state class with explicit transition helpers.
//   Composable with other state dimensions (filters, sorting, etc.).
//   Best for: complex UIs that need fine-grained control over pagination state.
export 'page_query.dart';
export 'paged_async_notifier.dart';
export 'paged_list_state.dart';
export 'paged_list_state_transitions.dart';
export 'pagination_load_gate.dart';
export 'scroll_load_trigger.dart';
