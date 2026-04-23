import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/ranking/data/models/ranking_video.dart';

abstract class RankingRepository {
  Future<Result<List<RankingVideo>, AppError>> getRanking({int? rid});
}
