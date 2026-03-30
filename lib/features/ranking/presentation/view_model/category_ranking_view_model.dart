import 'package:culcul/data/models/video/video_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/ranking/data/ranking_repository.dart';

part 'category_ranking_view_model.g.dart';

@riverpod
Future<List<VideoModel>> categoryRankingList(Ref ref, {int? rid}) async {
  final repository = ref.watch(rankingRepositoryProvider);
  return repository.getRanking(rid: rid);
}
