import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_queries.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/features/dynamic/application/dynamic_feed_application_providers.dart';
import 'package:culcul/features/dynamic/application/dynamic_feed_controller.dart';
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
  Future<CursorPage<DynamicItem, String>> fetchPage(String? currentCursor) async {
    final apiType = _type == 'all' ? null : _type;
    final result = await ref
        .read(dynamicFeedPortProvider)
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
