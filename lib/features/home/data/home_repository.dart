import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/home/data/home_api.dart';
import 'package:culcul/features/home/data/mappers/home_feed_mapper.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/home/domain/repositories/home_repository.dart' as domain;
import 'package:culcul/features/home/models/home_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
domain.HomeRepository homeRepository(Ref ref) {
  return HomeRepositoryImpl(api: ref.watch(homeApiProvider));
}

class HomeRepositoryImpl implements domain.HomeRepository {
  final HomeApi api;
  final RequestExecutor _executor;

  HomeRepositoryImpl({required this.api}) : _executor = const RequestExecutor();

  Future<List<VideoModel>> fetchRecommendModels({
    int page = 1,
    bool forceRefresh = false,
  }) async {
    final Result<List<VideoModel>, AppError> result = await _executor
        .runApi<List<VideoModel>>(
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
    return _unwrap(result);
  }

  Future<List<VideoModel>> fetchPopularModels({
    int page = 1,
    int pageSize = 20,
    bool forceRefresh = false,
  }) async {
    final Result<List<VideoModel>, AppError> result = await _executor
        .runApi<List<VideoModel>>(
          () async => api.fetchPopular(
            pn: page,
            ps: pageSize,
            forceRefresh: forceRefresh ? true : null,
          ),
          transform: (data) => data.list,
        );
    return _unwrap(result);
  }

  List<VideoModel> _unwrap(Result<List<VideoModel>, AppError> result) {
    return result.when(success: (value) => value, failure: (error) => throw error);
  }

  @override
  Future<List<HomeVideo>> fetchRecommend({
    int page = 1,
    bool forceRefresh = false,
  }) async {
    return (await fetchRecommendModels(
      page: page,
      forceRefresh: forceRefresh,
    )).map((item) => item.toDomain()).toList();
  }

  @override
  Future<List<HomeVideo>> fetchPopular({
    int page = 1,
    int pageSize = 20,
    bool forceRefresh = false,
  }) async {
    return (await fetchPopularModels(
      page: page,
      pageSize: pageSize,
      forceRefresh: forceRefresh,
    )).map((item) => item.toDomain()).toList();
  }
}
