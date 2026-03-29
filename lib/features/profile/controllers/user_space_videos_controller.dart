import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/models/user/user_space_video_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_videos_controller.g.dart';

@Riverpod(keepAlive: true)
class UserSpaceVideosNotifier extends _$UserSpaceVideosNotifier {
  int _page = 1;
  bool _hasMore = true;
  int _mid = 0;
  String _order = 'pubdate';

  @override
  Future<List<UserSpaceVideoModel>> build(int mid, {String order = 'pubdate'}) async {
    _mid = mid;
    _order = order;
    _page = 1;
    _hasMore = true;
    return _fetchVideos();
  }

  Future<List<UserSpaceVideoModel>> _fetchVideos() async {
    final repository = ref.read(profileRepositoryProvider);
    final videos = await repository.getSpaceVideos(mid: _mid, page: _page, order: _order);
    if (videos.length < 30) {
      _hasMore = false;
    } else {
      _page++;
    }
    return videos;
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    final oldState = state;
    if (oldState.asData?.value == null) return;

    state = AsyncLoading<List<UserSpaceVideoModel>>().copyWithPrevious(oldState);

    try {
      final newItems = await _fetchVideos();

      final previousItems = oldState.asData!.value;
      final existingIds = previousItems.map((e) => e.bvid).toSet();
      final uniqueNewItems = newItems
          .where((e) => !existingIds.contains(e.bvid))
          .toList();

      state = AsyncData([...previousItems, ...uniqueNewItems]);
    } catch (e, st) {
      state = AsyncError<List<UserSpaceVideoModel>>(e, st).copyWithPrevious(oldState);
    }
  }

  Future<void> refresh() async {
    _page = 1;
    _hasMore = true;
    state = const AsyncLoading();
    try {
      final items = await _fetchVideos();
      state = AsyncData(items);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

