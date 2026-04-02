import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';

abstract class HomeRepository {
  Future<Result<List<HomeVideo>, AppError>> fetchRecommend({
    int page = 1,
    bool forceRefresh = false,
  });

  Future<Result<List<HomeVideo>, AppError>> fetchPopular({
    int page = 1,
    bool forceRefresh = false,
  });
}
