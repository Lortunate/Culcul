import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/features/dynamic/application/use_case/dynamic_use_cases.dart';
import 'package:culcul/features/dynamic/presentation/view_model/dynamic_feed_view_model.dart';
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
  Future<CursorPage<DynamicItem, String>> fetchPage(
    String? currentCursor, {
    bool refresh = false,
  }) async {
    final result = await ref
        .read(dynamicFeedUseCaseProvider)
        .call(DynamicFeedQuery(topicId: _topicId, offset: currentCursor));
    final feed = result.when(
      success: (value) => value,
      failure: (error) => throw error.toException(),
    );
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
