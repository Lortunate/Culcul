// ignore_for_file: invalid_use_of_internal_member
import 'package:culcul/core/mixins/paging_mixin.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/models/index.dart';
import 'package:culcul/repositories/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_recommend_provider.g.dart';

@Riverpod(keepAlive: true)
class HomeRecommend extends _$HomeRecommend with PagingMixin<VideoModel> {
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
        .fetchRecommend(page: page);
    return switch (result) {
      Success(value: final list) => list,
      Failure(exception: final e) => throw e,
    };
  }

  Future<void> refresh() async {
    final oldState = state;
    // 保留旧数据，显示加载状态
    state = AsyncLoading<List<VideoModel>>().copyWithPrevious(oldState);
    try {
      final result = await ref
          .read(homeRepositoryProvider)
          .fetchRecommend(page: 1, forceRefresh: true);
      switch (result) {
        case Success(value: final list):
          page = 1;
          hasMore = true;
          state = AsyncValue.data(list);
        case Failure(exception: final e):
          // 发生错误时，如果有旧数据，则恢复旧数据并显示错误（或者用 SnackBar 提示，这里先保留旧数据）
          // AsyncValue.error 会覆盖 data 吗？如果不使用 copyWithPrevious，是的。
          // 我们希望保留数据但显示错误提示？或者让 UI 处理。
          // 这里简单起见，返回错误状态，但带有旧数据
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
