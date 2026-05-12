import 'package:culcul/features/home/feature_scope.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_view_model.g.dart';

@riverpod
Future<List<VideoModel>> weeklyList(Ref ref) async {
  final result = await ref.watch(homeRepositoryImplProvider).fetchWeeklyList();
  return result.when(
    success: (data) => data,
    failure: (error) {
      debugPrint('Error loading weekly list: $error');
      return const <VideoModel>[];
    },
  );
}
