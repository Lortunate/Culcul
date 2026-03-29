// ignore_for_file: invalid_use_of_internal_member
import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/data/models/video/video_model.dart';
import 'package:culcul/features/home/data/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_recommend_controller.g.dart';

@Riverpod(keepAlive: true)
class HomeRecommend extends _$HomeRecommend with OffsetPagedAsyncNotifier<VideoModel> {
  @override
  Future<List<VideoModel>> build() async {
    return buildFirstPage();
  }

  @override
  Future<List<VideoModel>> fetchPage(int page, {bool refresh = false}) async {
    return ref
        .read(homeRepositoryProvider)
        .fetchRecommend(page: page, forceRefresh: refresh);
  }

  @override
  Object itemId(VideoModel item) => item.bvid;

  @override
  bool hasMoreAfterPage(List<VideoModel> items) => items.isNotEmpty;

  Future<void> refresh() {
    return refreshPage();
  }

  Future<void> loadMore() {
    return loadNextPage();
  }
}
