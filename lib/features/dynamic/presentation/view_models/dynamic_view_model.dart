import 'package:culcul/features/dynamic/data/dtos/dynamic_response.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_queries.dart';
import 'package:culcul/features/dynamic/feature_scope.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_feed_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_view_model.g.dart';

// Architecture note: This view model reads the domain repository directly
// instead of routing through dynamic_workflows.dart. The dynamic application
// layer is reserved for multi-step orchestration, while this is a simple
// single-call feed query kept local for readability.
@riverpod
class DynamicNotifier extends _$DynamicNotifier
    with CursorPagedAsyncNotifier<DynamicItem, String>, DynamicFeedController {
  late String _type;

  @override
  Future<List<DynamicItem>> build(String type) {
    _type = type;
    return buildFirstPage();
  }

  @override
  Future<CursorPage<DynamicItem, String>> fetchPage(String? currentCursor) async {
    final apiType = _type == 'all' ? null : _type;
    final result = await ref
        .read(dynamicRepositoryProvider)
        .getFeed(DynamicFeedQuery(type: apiType, offset: currentCursor));
    return result.when(
      success: (data) =>
          CursorPage(items: data.items, nextCursor: data.offset, hasMore: data.hasMore),
      failure: (_) => const CursorPage(items: [], nextCursor: null, hasMore: false),
    );
  }

  @override
  Object itemId(DynamicItem item) => item.idStr;

  Future<void> loadMore() {
    return loadNextPage();
  }

  Future<void> refresh() {
    return refreshPage();
  }
}
