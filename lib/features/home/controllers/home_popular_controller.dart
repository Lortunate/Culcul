// ignore_for_file: invalid_use_of_internal_member
import 'package:culcul/core/paging_mixin.dart';
import 'package:culcul/data/models/video/video_model.dart';
import 'package:culcul/features/home/data/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_popular_controller.g.dart';

@Riverpod(keepAlive: true)
class HomePopular extends _$HomePopular with PagingMixin<VideoModel> {
  @override
  Future<List<VideoModel>> build() async {
    page = 1;
    hasMore = true;
    return fetchItems(page);
  }

  @override
  Future<List<VideoModel>> fetchItems(int page) async {
    return ref.read(homeRepositoryProvider).fetchPopular(page: page);
  }

  Future<void> refresh() async {
    state = AsyncLoading<List<VideoModel>>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      final list = await ref
          .read(homeRepositoryProvider)
          .fetchPopular(page: 1, forceRefresh: true);
      page = 1;
      hasMore = true;
      return list;
    });
  }

  Future<void> loadMore() async {
    final oldState = state;
    if (oldState is! AsyncData || !hasMore || oldState.isLoading) return;

    state = AsyncLoading<List<VideoModel>>().copyWithPrevious(oldState);
    await handleLoadMore(oldState, (newState) => state = newState, (item) => item.bvid);
  }
}

