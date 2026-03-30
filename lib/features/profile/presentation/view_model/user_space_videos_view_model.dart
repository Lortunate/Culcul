import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/data/models/user/user_space_video_model.dart';
import 'package:culcul/features/profile/application/use_case/profile_query_use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_videos_view_model.g.dart';

@Riverpod(keepAlive: true)
class UserSpaceVideosNotifier extends _$UserSpaceVideosNotifier
    with OffsetPagedAsyncNotifier<UserSpaceVideoModel> {
  int _mid = 0;
  String _order = 'pubdate';
  static const _pageSize = 30;

  @override
  Future<List<UserSpaceVideoModel>> build(int mid, {String order = 'pubdate'}) async {
    _mid = mid;
    _order = order;
    return buildFirstPage();
  }

  @override
  Future<List<UserSpaceVideoModel>> fetchPage(int page, {bool refresh = false}) async {
    final result = await ref
        .read(profileQueryUseCasesProvider)
        .getSpaceVideos(mid: _mid, page: page, order: _order);
    return result.when(
      success: (value) => value,
      failure: (error) => throw error.toException(),
    );
  }

  @override
  Object itemId(UserSpaceVideoModel item) => item.bvid;

  @override
  bool hasMoreAfterPage(List<UserSpaceVideoModel> items) => items.length >= _pageSize;

  Future<void> loadMore() {
    return loadNextPage();
  }

  Future<void> refresh() {
    return refreshPage();
  }
}
