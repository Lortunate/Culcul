import 'package:culcul/features/home/data/home_feed_data_source.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_facade.g.dart';

@riverpod
HomeFacade homeFacade(Ref ref) {
  return HomeFacade(ref.watch(homeFeedDataSourceProvider));
}

class HomeFacade {
  HomeFacade(this._dataSource);

  final HomeFeedDataSource _dataSource;

  Future<Result<List<VideoModel>, AppError>> loadRecommendFeed({
    required int page,
    bool forceRefresh = false,
  }) {
    return _dataSource.fetchRecommendPage(
      page: page,
      forceRefresh: forceRefresh,
    );
  }

  Future<Result<List<VideoModel>, AppError>> loadPopularFeed({
    required int page,
    bool forceRefresh = false,
  }) {
    return _dataSource.fetchPopularPage(
      page: page,
      forceRefresh: forceRefresh,
    );
  }

  Future<Result<List<VideoModel>, AppError>> loadWeeklyFeed() {
    return _dataSource.fetchWeeklyList();
  }
}
