// ignore_for_file: invalid_use_of_internal_member
import 'package:culcul/core/mixins/paging_mixin.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/models/index.dart';
import 'package:culcul/repositories/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_popular_provider.g.dart';

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
    final result = await ref
        .read(homeRepositoryProvider)
        .fetchPopular(page: page);
    return switch (result) {
      Success(value: final list) => list,
      Failure(exception: final e) => throw e,
    };
  }

  Future<void> refresh() async {
    final oldState = state;
    state = AsyncLoading<List<VideoModel>>().copyWithPrevious(oldState);
    try {
      final result = await ref
          .read(homeRepositoryProvider)
          .fetchPopular(page: 1, forceRefresh: true);
      switch (result) {
        case Success(value: final list):
          page = 1;
          hasMore = true;
          state = AsyncValue.data(list);
        case Failure(exception: final e):
          state = AsyncValue<List<VideoModel>>.error(e, StackTrace.current)
              .copyWithPrevious(oldState);
      }
    } catch (e, st) {
      state = AsyncValue<List<VideoModel>>.error(e, st).copyWithPrevious(oldState);
    }
  }

  Future<void> loadMore() async {
    final oldState = state;
    if (oldState is! AsyncData || !hasMore || oldState.isLoading) return;

    state = AsyncLoading<List<VideoModel>>().copyWithPrevious(oldState);
    await handleLoadMore(
      oldState,
      (newState) => state = newState,
      (item) => item.bvid,
    );
  }
}
