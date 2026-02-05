import 'package:culcul/data/api/ranking_api.dart';
import 'package:culcul/domain/entities/video_ranking.dart';

class RankingRepository {
  final RankingApi _api;

  RankingRepository(this._api);

  Future<List<VideoItem>> getRanking({int? rid}) async {
    final queryParameters = <String, dynamic>{};

    if (rid != null) {
      queryParameters['rid'] = rid;
    }

    final response = await _api.fetchRanking(queryParameters);

    if (response.isSuccess && response.data != null) {
      final rankingResponse = response.data!;
      return rankingResponse.list.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return VideoItem(
          id: item.bvid,
          coverUrl: item.pic,
          title: item.title,
          upName: item.owner.name,
          playCount: item.stat.view,
          likeCount: item.stat.like,
          danmakuCount: item.stat.danmaku,
          rank: index + 1,
          pts: null,
        );
      }).toList();
    } else {
      throw Exception(
        'API Error: code=${response.code}, message=${response.message}',
      );
    }
  }
}
