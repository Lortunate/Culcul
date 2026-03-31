import 'package:culcul/features/home/domain/entities/home_video.dart';

abstract class WeeklyRepository {
  Future<HomeWeeklyFeed> getWeeklyList();
}
