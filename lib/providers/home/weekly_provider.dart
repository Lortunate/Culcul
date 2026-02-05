import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/models/weekly_model.dart';
import 'package:culcul/repositories/weekly_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_provider.g.dart';

@riverpod
WeeklyRepository weeklyRepository(Ref ref) {
  return WeeklyRepository(ref.watch(weeklyApiProvider));
}

@riverpod
Future<WeeklyModel> weeklyList(Ref ref) async {
  final repository = ref.watch(weeklyRepositoryProvider);
  final result = await repository.getWeeklyList();
  return switch (result) {
    Success(value: final value) => value,
    Failure(exception: final e) => throw e,
    _ => throw Exception('Unexpected result type'),
  };
}
