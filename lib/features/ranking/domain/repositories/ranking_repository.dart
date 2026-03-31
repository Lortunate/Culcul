import 'package:culcul/features/ranking/domain/entities/ranking_video.dart';

abstract class RankingRepository {
  Future<List<RankingVideo>> getRanking({int? rid});
}
