import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/data/models/live/live_room_model.dart';
import 'package:culcul/features/live/data/live_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_recommend_controller.g.dart';

@riverpod
class LiveRecommend extends _$LiveRecommend with OffsetPagedAsyncNotifier<LiveRoomModel> {
  static const _pageSize = 20;

  @override
  Future<List<LiveRoomModel>> build() async {
    return buildFirstPage();
  }

  @override
  Future<List<LiveRoomModel>> fetchPage(int page, {bool refresh = false}) {
    return ref.read(liveRepositoryProvider).fetchRecommendList(page: page);
  }

  @override
  Object itemId(LiveRoomModel item) => item.roomId;

  @override
  bool hasMoreAfterPage(List<LiveRoomModel> items) => items.length >= _pageSize;

  Future<void> refresh() {
    return refreshPage();
  }

  Future<void> loadMore() {
    return loadNextPage();
  }
}
