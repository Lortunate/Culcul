import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_queries.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/features/dynamic/application/dynamic_feed_application_providers.dart';
import 'package:culcul/features/dynamic/application/dynamic_feed_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'topic_dynamic_view_model.g.dart';

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
        .read(dynamicFeedPortProvider)
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
