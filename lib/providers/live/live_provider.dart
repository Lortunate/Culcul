import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/models/live/live_room_model.dart';
import 'package:culcul/repositories/live_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_provider.g.dart';

@riverpod
class LiveRecommend extends _$LiveRecommend {
  @override
  Future<List<LiveRoomModel>> build() async {
    return _fetchItems();
  }

  Future<List<LiveRoomModel>> _fetchItems() async {
    final result = await ref.read(liveRepositoryProvider).fetchRecommendList();
    return switch (result) {
      Success(value: final list) => list,
      Failure(exception: final e) => throw e,
    };
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchItems());
  }
}
