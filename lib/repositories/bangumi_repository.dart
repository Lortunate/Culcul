import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/api/bangumi_api.dart';
import 'package:culcul/data/models/bangumi/timeline_model.dart';

class BangumiRepository {
  final BangumiApi _api;

  BangumiRepository(this._api);

  Future<Result<List<TimelineResponse>, Exception>> fetchTimeline({
    required int types,
    required int before,
    required int after,
  }) async {
    try {
      final response = await _api.fetchTimeline(types, before, after);
      if (response.code == 0 && response.result != null) {
        return Success(response.result!);
      }
      return Failure(Exception(response.message));
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }
}
