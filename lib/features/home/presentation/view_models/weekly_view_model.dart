import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/home/home_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_view_model.g.dart';

@riverpod
Future<HomeWeeklyFeed> weeklyList(Ref ref) async {
  return ref.watch(weeklyRepositoryProvider).getWeeklyList();
}
