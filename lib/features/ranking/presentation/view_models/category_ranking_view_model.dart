import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/ranking/feature_scope.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_ranking_view_model.g.dart';

@riverpod
Future<List<VideoModel>> categoryRankingList(Ref ref, {int? rid}) async {
  final result = await ref.watch(rankingRepositoryProvider).getRanking(rid: rid);
  return result.when(
    success: (data) => data,
    failure: (error) {
      debugPrint('Error loading ranking: $error');
      return const <VideoModel>[];
    },
  );
}
