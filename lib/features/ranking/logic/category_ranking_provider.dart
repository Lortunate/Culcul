import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/models/video/video_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_ranking_provider.g.dart';

@riverpod
Future<List<VideoModel>> categoryRankingList(Ref ref, {int? rid}) async {
  final repository = ref.watch(rankingRepositoryProvider);
  final result = await repository.getRanking(rid: rid);
  
  return switch (result) {
    Success(value: final list) => list,
    Failure(exception: final e) => throw e,
  };
}
