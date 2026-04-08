import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/home/data/home_api.dart';
import 'package:culcul/features/home/data/home_feed_mapper.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/home/domain/repositories/home_repository.dart' as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository_impl.g.dart';

@riverpod
domain.HomeRepository homeRepository(Ref ref) {
  return HomeRepositoryImpl(api: HomeApi(ref.watch(dioClientProvider)));
}

class HomeRepositoryImpl implements domain.HomeRepository {
  static const int _defaultPopularPageSize = 20;
  final HomeApi api;
  final RequestExecutor _executor;

  HomeRepositoryImpl({required this.api}) : _executor = const RequestExecutor();

  Future<Result<List<VideoModel>, AppError>> fetchRecommendModels({
    int page = 1,
    bool forceRefresh = false,
  }) async {
    return _executor.runApi<List<VideoModel>>(
      () async => api.fetchRecommend(
        freshIdx: page,
        freshIdx1h: page,
        forceRefresh: forceRefresh ? true : null,
      ),
      transform: (data) {
        final items = data.item;
        final videos = <VideoModel>[];
        for (final item in items) {
          if (item['goto'] != 'av') continue;
          try {
            videos.add(VideoModel.fromJson(item));
          } catch (_) {
            // Skip malformed entries instead of failing the whole page.
          }
        }
        return videos;
      },
    );
  }

  Future<Result<List<VideoModel>, AppError>> fetchPopularModels({
    int page = 1,
    bool forceRefresh = false,
  }) async {
    return _executor.runApi<List<VideoModel>>(
      () async => api.fetchPopular(
        pn: page,
        ps: _defaultPopularPageSize,
        forceRefresh: forceRefresh ? true : null,
      ),
      transform: (data) => data.list,
    );
  }

  @override
  Future<Result<List<HomeVideo>, AppError>> fetchRecommend({
    int page = 1,
    bool forceRefresh = false,
  }) async {
    final result = await fetchRecommendModels(page: page, forceRefresh: forceRefresh);
    return result.map((models) => models.map((item) => item.toDomain()).toList());
  }

  @override
  Future<Result<List<HomeVideo>, AppError>> fetchPopular({
    int page = 1,
    bool forceRefresh = false,
  }) async {
    final result = await fetchPopularModels(page: page, forceRefresh: forceRefresh);
    return result.map((models) => models.map((item) => item.toDomain()).toList());
  }
}
