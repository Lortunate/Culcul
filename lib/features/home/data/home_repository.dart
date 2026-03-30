import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/data/api/video_api.dart';
import 'package:culcul/data/models/video/video_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository(api: ref.watch(videoApiProvider));
}

class HomeRepository {
  final VideoApi api;
  final RequestExecutor _executor;

  HomeRepository({required this.api}) : _executor = const RequestExecutor();

  Future<List<VideoModel>> fetchRecommend({
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
            return items
                .where((e) => e['goto'] == 'av')
                .map(VideoModel.fromJson)
                .toList();
          },
        );
    return _unwrap(result);
  }

  Future<List<VideoModel>> fetchPopular({
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
}
