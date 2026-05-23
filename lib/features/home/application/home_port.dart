import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';

/// Home feature application boundary.
abstract interface class HomePort {
  Future<Result<List<VideoModel>, AppError>> fetchRecommendPage({
    required int page,
    bool forceRefresh = false,
  });

  Future<Result<List<VideoModel>, AppError>> fetchPopularPage({
    required int page,
    bool forceRefresh = false,
  });

  Future<Result<List<VideoModel>, AppError>> fetchWeeklyList();
}
