import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/features/dynamic/dynamic.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_feed_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    final apiType = _type == 'all' ? null : _type;
    final result = await ref
        .read(dynamicRepositoryProvider)
        .getFeed(type: apiType, offset: currentCursor);
    if (result.errorOrNull != null) {
      return const CursorPage(items: [], nextCursor: null, hasMore: false);
    }
    final data = result.dataOrNull!;
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
