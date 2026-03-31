import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/features/live/domain/entities/live_room_summary.dart';
import 'package:culcul/features/live/application/live_room_workflows.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_recommend_view_model.g.dart';

@riverpod
class LiveRecommend extends _$LiveRecommend
    with OffsetPagedAsyncNotifier<LiveRoomSummary> {
  static const _pageSize = 20;

  @override
  Future<List<LiveRoomSummary>> build() async {
    return buildFirstPage();
  }

  @override
  Future<List<LiveRoomSummary>> fetchPage(int page, {bool refresh = false}) async {
    final result = await ref.read(liveRoomWorkflowsProvider).getRecommendList(page);
    return result.when(success: (value) => value, failure: (error) => throw error);
  }

  @override
  Object itemId(LiveRoomSummary item) => item.roomId;

  @override
  bool hasMoreAfterPage(List<LiveRoomSummary> items) => items.length >= _pageSize;

  Future<void> refresh() {
    return refreshPage();
  }

  Future<void> loadMore() {
    return loadNextPage();
  }
}
