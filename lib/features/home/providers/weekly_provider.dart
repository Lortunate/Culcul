import 'package:culcul/data/models/feed/weekly_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/home/data/weekly_repository.dart';

part 'weekly_provider.g.dart';

@riverpod
Future<WeeklyModel> weeklyList(Ref ref) async {
  final repository = ref.watch(weeklyRepositoryProvider);
  return repository.getWeeklyList();
}
