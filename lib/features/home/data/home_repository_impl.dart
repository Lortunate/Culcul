import 'package:culcul/features/home/data/home_api.dart';
import 'package:culcul/core/models/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/utils/json_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository_impl.g.dart';

@riverpod
HomeRepositoryImpl homeRepositoryImpl(Ref ref) {
  final dio = ref.watch(dioClientProvider);
  return HomeRepositoryImpl(homeApi: HomeApi(dio));
}

class HomeRepositoryImpl {
  final HomeApi _homeApi;
  final RequestExecutor _requestExecutor;

  HomeRepositoryImpl({required HomeApi homeApi, RequestExecutor? requestExecutor})
    : _homeApi = homeApi,
      _requestExecutor = requestExecutor ?? const RequestExecutor();

  Future<Result<List<VideoModel>, AppError>> fetchRecommendPage({
    required int page,
    bool forceRefresh = false,
  }) {
    return _requestExecutor.runApi<List<VideoModel>, Object>(
      () async => _homeApi.fetchRecommend(
        freshIdx: page,
        freshIdx1h: page,
        forceRefresh: forceRefresh ? true : null,
      ),
      transform: (data) {
        final root = JsonUtils.asStringKeyedMap(data);
        final videos = <VideoModel>[];
        for (final item in JsonUtils.parseObjectList(root?['item'])) {
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
      },
    );
  }

  Future<Result<List<VideoModel>, AppError>> fetchPopularPage({
    required int page,
    bool forceRefresh = false,
  }) {
    return _requestExecutor.runApi<List<VideoModel>, Object>(
      () async =>
          _homeApi.fetchPopular(pn: page, forceRefresh: forceRefresh ? true : null),
      transform: parseVideoModelListEnvelope,
    );
  }

  Future<Result<List<VideoModel>, AppError>> fetchWeeklyList() {
    return _requestExecutor.runApi<List<VideoModel>, Object>(
      () async => _homeApi.fetchWeeklyList(),
      transform: parseVideoModelListEnvelope,
    );
  }
}
