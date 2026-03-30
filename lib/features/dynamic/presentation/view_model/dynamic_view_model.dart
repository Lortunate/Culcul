import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/features/dynamic/presentation/view_model/dynamic_feed_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository.dart';

part 'dynamic_view_model.g.dart';

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
  Future<CursorPage<DynamicItem, String>> fetchPage(
    String? currentCursor, {
    bool refresh = false,
  }) async {
    final repo = ref.read(dynamicRepositoryProvider);
    final apiType = _type == 'all' ? null : _type;
    final data = await repo.getFeed(type: apiType, offset: currentCursor);
    return CursorPage(items: data.items, nextCursor: data.offset, hasMore: data.hasMore);
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
