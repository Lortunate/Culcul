import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/core/contracts/live_room_summary_contract.dart';
import 'package:culcul/features/live/data/live_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_recommend_provider.g.dart';

@riverpod
class LiveRecommend extends _$LiveRecommend
    with OffsetPagedAsyncNotifier<LiveRoomSummary> {
  static const _pageSize = 20;

  @override
  Future<List<LiveRoomSummary>> build() async {
    return buildFirstPage();
  }

  @override
  Future<List<LiveRoomSummary>> fetchPage(int page) async {
    final result = await ref.read(liveRepositoryProvider).getRecommendList(page: page);
    return result.when(
      success: (data) => data,
      failure: (error) {
        debugPrint('Error loading live recommendations: $error');
        return const <LiveRoomSummary>[];
      },
    );
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
