import 'package:culcul/core/base_repository.dart';
import 'package:culcul/data/api/ranking_api.dart';
import 'package:culcul/data/models/video/video_model.dart';

class RankingRepository extends BaseRepository {
  final RankingApi _api;

  RankingRepository(this._api);

  Future<List<VideoModel>> getRanking({int? rid}) async {
    final data = await requestApi(() => _api.fetchRanking(rid: rid));
    return data.list;
  }
}

