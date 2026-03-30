import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';

mixin HomeVideoPagingViewModel on OffsetPagedAsyncNotifier<HomeVideo> {
  @override
  Object itemId(HomeVideo item) => item.bvid;

  @override
  bool hasMoreAfterPage(List<HomeVideo> items) => items.isNotEmpty;

  Future<void> refresh() => refreshPage();

  Future<void> loadMore() => loadNextPage();
}
