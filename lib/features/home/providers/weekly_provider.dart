import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/models/feed/weekly_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_provider.g.dart';

@riverpod
Future<WeeklyModel> weeklyList(Ref ref) async {
  final repository = ref.watch(weeklyRepositoryProvider);
  return repository.getWeeklyList();
}

