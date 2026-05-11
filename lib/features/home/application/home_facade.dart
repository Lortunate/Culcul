import 'package:culcul/features/home/data/home_feed_data_source.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_facade.g.dart';

typedef HomePageLoader =
    Future<Result<List<VideoModel>, AppError>> Function({
      required int page,
      bool forceRefresh,
    });

typedef HomeWeeklyLoader = Future<Result<List<VideoModel>, AppError>> Function();

@riverpod
HomePageLoader homeRecommendFeedCapability(Ref ref) {
  final dataSource = ref.watch(homeFeedDataSourceProvider);
  return ({required int page, bool forceRefresh = false}) {
    return dataSource.fetchRecommendPage(
      page: page,
      forceRefresh: forceRefresh,
    );
  };
}

@riverpod
HomePageLoader homePopularFeedCapability(Ref ref) {
  final dataSource = ref.watch(homeFeedDataSourceProvider);
  return ({required int page, bool forceRefresh = false}) {
    return dataSource.fetchPopularPage(
      page: page,
      forceRefresh: forceRefresh,
    );
  };
}

@riverpod
HomeWeeklyLoader homeWeeklyFeedCapability(Ref ref) {
  final dataSource = ref.watch(homeFeedDataSourceProvider);
  return dataSource.fetchWeeklyList;
}
