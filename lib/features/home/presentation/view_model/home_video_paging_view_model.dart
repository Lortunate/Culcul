import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/data/models/video/video_model.dart';

mixin HomeVideoPagingViewModel on OffsetPagedAsyncNotifier<VideoModel> {
  @override
  Object itemId(VideoModel item) => item.bvid;

  @override
  bool hasMoreAfterPage(List<VideoModel> items) => items.isNotEmpty;

  Future<void> refresh() => refreshPage();

  Future<void> loadMore() => loadNextPage();
}
