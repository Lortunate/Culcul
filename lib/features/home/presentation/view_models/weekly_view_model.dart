import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/home/feature_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_view_model.g.dart';

@riverpod
Future<HomeWeeklyFeed> weeklyList(Ref ref) async {
  final result = await ref.watch(weeklyRepositoryProvider).getWeeklyList();
  return result.dataOrNull ?? const HomeWeeklyFeed(list: []);
}
