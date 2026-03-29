import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/models/video/video_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_ranking_provider.g.dart';

@riverpod
Future<List<VideoModel>> categoryRankingList(Ref ref, {int? rid}) async {
  final repository = ref.watch(rankingRepositoryProvider);
  return repository.getRanking(rid: rid);
}

