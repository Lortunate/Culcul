import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';

abstract class WeeklyRepository {
  Future<Result<HomeWeeklyFeed, AppError>> getWeeklyList();
}
