import 'package:culcul/features/home/data/home_api.dart';
import 'package:culcul/features/home/data/weekly_api.dart';
import 'package:culcul/features/home/data/dtos/feed_response_dto.dart';
import 'package:culcul/features/home/data/dtos/popular_response_dto.dart';
import 'package:culcul/features/home/data/dtos/weekly_model_dto.dart';
import 'package:culcul/features/home/domain/repositories/home_repository.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_feed_data_source.g.dart';

@riverpod
HomeFeedDataSource homeFeedDataSource(Ref ref) {
  final dio = ref.watch(dioClientProvider);
  return HomeFeedDataSource(homeApi: HomeApi(dio), weeklyApi: WeeklyApi(dio));
}

class HomeFeedDataSource implements HomeRepository {
  static const int _popularPageSize = 20;

  final HomeApi? _homeApi;
  final WeeklyApi? _weeklyApi;
  final RequestExecutor _requestExecutor;

  HomeFeedDataSource({
    required HomeApi homeApi,
    required WeeklyApi weeklyApi,
    RequestExecutor? requestExecutor,
  }) : _homeApi = homeApi,
       _weeklyApi = weeklyApi,
       _requestExecutor = requestExecutor ?? const RequestExecutor();

  @visibleForTesting
  HomeFeedDataSource.test({RequestExecutor? requestExecutor})
    : _homeApi = null,
      _weeklyApi = null,
      _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  Future<Result<List<VideoModel>, AppError>> fetchRecommendPage({
    required int page,
    bool forceRefresh = false,
  }) {
    return _requestExecutor.runApi<List<VideoModel>, FeedResponseDto>(
      () async => _requireHomeApi().fetchRecommend(
        freshIdx: page,
        freshIdx1h: page,
        forceRefresh: forceRefresh ? true : null,
      ),
      transform: (data) => _parseRecommendItems(data.item),
    );
  }

  @override
  Future<Result<List<VideoModel>, AppError>> fetchPopularPage({
    required int page,
    bool forceRefresh = false,
  }) {
    return _requestExecutor.runApi<List<VideoModel>, PopularResponseDto>(
      () async => _requireHomeApi().fetchPopular(
        pn: page,
        ps: _popularPageSize,
        forceRefresh: forceRefresh ? true : null,
      ),
      transform: (data) => data.list,
    );
  }

  @override
  Future<Result<List<VideoModel>, AppError>> fetchWeeklyList() {
    return _requestExecutor.runApi<List<VideoModel>, WeeklyModelDto>(
      () async => _requireWeeklyApi().getWeeklyList(),
      transform: (data) => data.list,
    );
  }

  HomeApi _requireHomeApi() {
    assert(_homeApi != null, 'HomeFeedDataSource.test() requires overridden methods.');
    return _homeApi!;
  }

  WeeklyApi _requireWeeklyApi() {
    assert(_weeklyApi != null, 'HomeFeedDataSource.test() requires overridden methods.');
    return _weeklyApi!;
  }

  static List<VideoModel> _parseRecommendItems(List<Map<String, dynamic>> items) {
    final videos = <VideoModel>[];
    for (final item in items) {
      if (item['goto'] != 'av') {
        continue;
      }
      try {
        videos.add(VideoModel.fromJson(item));
      } catch (_) {
        // Skip malformed entries instead of failing the whole page.
      }
    }
    return videos;
  }
}
