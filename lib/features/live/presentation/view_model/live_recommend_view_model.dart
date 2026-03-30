import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/data/models/live/live_room_model.dart';
import 'package:culcul/features/live/application/use_case/live_room_use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_recommend_view_model.g.dart';

@riverpod
class LiveRecommend extends _$LiveRecommend with OffsetPagedAsyncNotifier<LiveRoomModel> {
  static const _pageSize = 20;

  @override
  Future<List<LiveRoomModel>> build() async {
    return buildFirstPage();
  }

  @override
  Future<List<LiveRoomModel>> fetchPage(int page, {bool refresh = false}) async {
    final result = await ref.read(liveRoomUseCasesProvider).getRecommendList(page);
    return result.when(
      success: (value) => value,
      failure: (error) => throw error.toException(),
    );
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
