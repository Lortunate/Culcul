import 'package:culcul/data/models/live/live_room_model.dart';
import 'package:culcul/features/live/data/live_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_recommend_controller.g.dart';

@riverpod
class LiveRecommend extends _$LiveRecommend {
  int _page = 1;

  @override
  Future<List<LiveRoomModel>> build() async {
    _page = 1;
    return _fetchItems(page: 1);
  }

  Future<List<LiveRoomModel>> _fetchItems({required int page}) async {
    return ref.read(liveRepositoryProvider).fetchRecommendList(page: page);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    _page = 1;
    state = await AsyncValue.guard(() => _fetchItems(page: 1));
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.hasError || state.value == null) return;

    try {
      final nextPage = _page + 1;
      final newItems = await _fetchItems(page: nextPage);

      if (newItems.isNotEmpty) {
        _page = nextPage;
        // Merge with existing items
        state = AsyncValue.data([...state.value!, ...newItems]);
      }
    } catch (e) {
      // Handle load more error silently or use a separate state provider for UI feedback
      // For now, we just keep the current state to avoid breaking the list
    }
  }
}
