import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/api/video_api.dart';
import 'package:culcul/data/models/video_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository(
    api: ref.watch(videoApiProvider),
  );
}

class HomeRepository {
  final VideoApi api;

  HomeRepository({required this.api});

  Future<Result<List<VideoModel>, AppException>> fetchRecommend({
    int page = 1,
    bool forceRefresh = false,
  }) async {
    try {
      final params = <String, dynamic>{
        'fresh_type': 4,
        'ps': 20,
        'fresh_idx': page,
        'fresh_idx_1h': page,
      };

      if (forceRefresh) {
        params['force_refresh'] = true;
      }

      final response = await api.fetchRecommend(params);

      if (response.isSuccess) {
        final items = response.data?.item ?? [];
        final list = items
            .where((e) => e['goto'] == 'av')
            .map((e) => VideoModel.fromJson(e))
            .toList();
        return Success(list);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<List<VideoModel>, AppException>> fetchPopular({
    int page = 1,
    int pageSize = 20,
    bool forceRefresh = false,
  }) async {
    try {
      final Map<String, dynamic> params = {'pn': page, 'ps': pageSize};
      if (forceRefresh) {
        params['force_refresh'] = true;
      }

      final response = await api.fetchPopular(params);

      if (response.isSuccess) {
        return Success(response.data?.list ?? []);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }
}
