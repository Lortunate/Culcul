import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/data/api/ranking_api.dart';
import 'package:culcul/data/models/video/video_model.dart';

class RankingRepository extends BaseRepository {
  final RankingApi _api;

  RankingRepository(this._api);

  Future<Result<List<VideoModel>, AppException>> getRanking({int? rid}) async {
    final result = await safeApiCall(() => _api.fetchRanking(rid: rid));

    return switch (result) {
      Success(value: final data) => Success(data.list),
      Failure(exception: final e) => Failure(e),
    };
  }
}
