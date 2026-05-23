import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';

/// Ranking feature application boundary.
abstract interface class RankingPort {
  Future<Result<List<VideoModel>, AppError>> getRanking({int? rid});
}
