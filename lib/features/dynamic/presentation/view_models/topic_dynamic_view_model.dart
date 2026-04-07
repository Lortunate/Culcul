import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/features/dynamic/dynamic.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_feed_view_model.dart';
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
        .read(dynamicRepositoryProvider)
        .getTopicFeed(topicId: _topicId, offset: currentCursor);
    if (result.errorOrNull != null) {
      return const CursorPage(items: [], nextCursor: null, hasMore: false);
    }
    final feed = result.dataOrNull!;
    return CursorPage(items: feed.items, nextCursor: feed.offset, hasMore: feed.hasMore);
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
