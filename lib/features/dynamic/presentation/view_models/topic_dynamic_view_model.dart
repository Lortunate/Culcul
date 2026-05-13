import 'package:culcul/features/dynamic/data/dtos/dynamic_response.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_queries.dart';
import 'package:culcul/features/dynamic/feature_scope.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_feed_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'topic_dynamic_view_model.g.dart';

// Architecture note: This view model reads the domain repository directly
// instead of routing through dynamic_workflows.dart. The dynamic application
// layer is reserved for multi-step orchestration, while this is a simple
// single-call feed query kept local for readability.
@riverpod
class TopicDynamicNotifier extends _$TopicDynamicNotifier
    with CursorPagedAsyncNotifier<DynamicItem, String>, DynamicFeedController {
  late int _topicId;

  @override
  Future<List<DynamicItem>> build({required int topicId}) async {
    _topicId = topicId;
    return buildFirstPage();
  }

  @override
  Future<CursorPage<DynamicItem, String>> fetchPage(String? currentCursor) async {
    final result = await ref
        .read(dynamicRepositoryProvider)
        .getTopicFeed(TopicDynamicFeedQuery(topicId: _topicId, offset: currentCursor));
    return result.when(
      success: (feed) =>
          CursorPage(items: feed.items, nextCursor: feed.offset, hasMore: feed.hasMore),
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
