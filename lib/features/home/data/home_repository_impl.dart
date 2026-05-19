import 'package:culcul/features/home/data/home_api.dart';
import 'package:culcul/features/home/data/weekly_api.dart';
import 'package:culcul/features/home/data/dtos/feed_response_dto.dart';
import 'package:culcul/features/home/data/dtos/popular_response_dto.dart';
import 'package:culcul/features/home/data/dtos/weekly_model_dto.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository_impl.g.dart';

@riverpod
HomeRepositoryImpl homeRepositoryImpl(Ref ref) {
  final dio = ref.watch(dioClientProvider);
  return HomeRepositoryImpl(homeApi: HomeApi(dio), weeklyApi: WeeklyApi(dio));
}

class HomeRepositoryImpl {
  final HomeApi? _homeApi;
  final WeeklyApi? _weeklyApi;
  final RequestExecutor _requestExecutor;

  HomeRepositoryImpl({
    required HomeApi homeApi,
    required WeeklyApi weeklyApi,
    RequestExecutor? requestExecutor,
  }) : _homeApi = homeApi,
       _weeklyApi = weeklyApi,
       _requestExecutor = requestExecutor ?? const RequestExecutor();

  @visibleForTesting
  HomeRepositoryImpl.test({RequestExecutor? requestExecutor})
    : _homeApi = null,
      _weeklyApi = null,
      _requestExecutor = requestExecutor ?? const RequestExecutor();

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

  Future<Result<List<VideoModel>, AppError>> fetchPopularPage({
    required int page,
    bool forceRefresh = false,
  }) {
    return _requestExecutor.runApi<List<VideoModel>, PopularResponseDto>(
      () async => _requireHomeApi().fetchPopular(
        pn: page,
        forceRefresh: forceRefresh ? true : null,
      ),
      transform: (data) => data.list,
    );
  }

  Future<Result<List<VideoModel>, AppError>> fetchWeeklyList() {
    return _requestExecutor.runApi<List<VideoModel>, WeeklyModelDto>(
      () async => _requireWeeklyApi().getWeeklyList(),
      transform: (data) => data.list,
    );
  }

  HomeApi _requireHomeApi() {
    assert(_homeApi != null, 'HomeRepositoryImpl.test() requires overridden methods.');
    return _homeApi!;
  }

  WeeklyApi _requireWeeklyApi() {
    assert(_weeklyApi != null, 'HomeRepositoryImpl.test() requires overridden methods.');
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
