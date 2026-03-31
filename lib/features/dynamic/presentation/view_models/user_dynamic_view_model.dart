import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/features/dynamic/application/dynamic_workflows.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_feed_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_dynamic_view_model.g.dart';

@Riverpod(keepAlive: true)
class UserDynamicNotifier extends _$UserDynamicNotifier
    with CursorPagedAsyncNotifier<DynamicItem, String>, DynamicFeedController {
  int _hostMid = 0;

  @override
  Future<List<DynamicItem>> build(int hostMid) async {
    _hostMid = hostMid;
    return buildFirstPage();
  }

  @override
  Future<CursorPage<DynamicItem, String>> fetchPage(
    String? currentCursor, {
    bool refresh = false,
  }) async {
    final result = await ref
        .read(dynamicFeedWorkflowProvider)
        .call(DynamicFeedQuery(hostMid: _hostMid, offset: currentCursor));
    final feed = result.when(success: (value) => value, failure: (error) => throw error);
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
