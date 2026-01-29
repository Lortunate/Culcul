import 'package:cilixili/core/mixins/paging_mixin.dart';
import 'package:cilixili/data/repositories/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cilixili/data/models/home/index.dart';

part 'home_recommend_provider.g.dart';

@riverpod
class HomeRecommend extends _$HomeRecommend with PagingMixin<VideoModel> {
  @override
  Future<List<VideoModel>> build() async {
    page = 1;
    hasMore = true;
    return fetchItems(page);
  }

  @override
  Future<List<VideoModel>> fetchItems(int page) {
    return ref.read(homeRepositoryProvider).fetchRecommend(page: page);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> loadMore() async {
    await handleLoadMore(
      state,
      (newState) => state = newState,
      (item) => item.bvid,
    );
  }
}
