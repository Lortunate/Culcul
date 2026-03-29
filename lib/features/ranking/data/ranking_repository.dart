import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/api/ranking_api.dart';
import 'package:culcul/data/models/video/video_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ranking_repository.g.dart';

@riverpod
RankingRepository rankingRepository(Ref ref) {
  return RankingRepository(ref.watch(rankingApiProvider));
}

class RankingRepository extends BaseRepository {
  final RankingApi _api;

  RankingRepository(this._api);

  Future<List<VideoModel>> getRanking({int? rid}) async {
    final data = await requestApi(() => _api.fetchRanking(rid: rid));
    return data.list;
  }
}
