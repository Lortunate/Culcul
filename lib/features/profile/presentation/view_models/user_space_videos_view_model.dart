import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/features/profile/application/use_case/profile_query_use_cases.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_videos_view_model.g.dart';

@Riverpod(keepAlive: true)
class UserSpaceVideosNotifier extends _$UserSpaceVideosNotifier
    with OffsetPagedAsyncNotifier<ProfileVideo> {
  int _mid = 0;
  String _order = 'pubdate';
  static const _pageSize = 30;

  @override
  Future<List<ProfileVideo>> build(int mid, {String order = 'pubdate'}) async {
    _mid = mid;
    _order = order;
    return buildFirstPage();
  }

  @override
  Future<List<ProfileVideo>> fetchPage(int page, {bool refresh = false}) async {
    final result = await ref
        .read(profileQueryUseCasesProvider)
        .getSpaceVideos(mid: _mid, page: page, order: _order);
    return result.when(success: (value) => value, failure: (error) => throw error);
  }

  @override
  Object itemId(ProfileVideo item) => item.bvid;

  @override
  bool hasMoreAfterPage(List<ProfileVideo> items) => items.length >= _pageSize;

  Future<void> loadMore() {
    return loadNextPage();
  }

  Future<void> refresh() {
    return refreshPage();
  }
}
