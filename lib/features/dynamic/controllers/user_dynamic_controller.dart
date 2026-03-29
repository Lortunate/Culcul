import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/features/dynamic/controllers/dynamic_feed_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository.dart';

part 'user_dynamic_controller.g.dart';

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
    final repository = ref.read(dynamicRepositoryProvider);
    final feed = await repository.getSpaceDynamicFeed(
      hostMid: _hostMid,
      offset: currentCursor,
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
