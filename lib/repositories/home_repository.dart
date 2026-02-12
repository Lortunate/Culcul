import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/repositories/base_repository.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/api/video_api.dart';
import 'package:culcul/data/models/video/video_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository(api: ref.watch(videoApiProvider));
}

class HomeRepository extends BaseRepository {
  final VideoApi api;

  HomeRepository({required this.api});

  Future<Result<List<VideoModel>, AppException>> fetchRecommend({
    int page = 1,
    bool forceRefresh = false,
  }) async {
    final result = await safeApiCall(
      () => api.fetchRecommend(
        freshIdx: page,
        freshIdx1h: page,
        forceRefresh: forceRefresh ? true : null,
      ),
    );

    return switch (result) {
      Success(value: final data) => () {
        final items = data.item;
        final list = items
            .where((e) => e['goto'] == 'av')
            .map((e) => VideoModel.fromJson(e))
            .toList();
        return Success<List<VideoModel>, AppException>(list);
      }(),
      Failure(exception: final e) => Failure<List<VideoModel>, AppException>(e),
    };
  }

  Future<Result<List<VideoModel>, AppException>> fetchPopular({
    int page = 1,
    int pageSize = 20,
    bool forceRefresh = false,
  }) async {
    final result = await safeApiCall(
      () => api.fetchPopular(
        pn: page,
        ps: pageSize,
        forceRefresh: forceRefresh ? true : null,
      ),
    );

    return switch (result) {
      Success(value: final data) => Success(data.list),
      Failure(exception: final e) => Failure(e),
    };
  }
}
