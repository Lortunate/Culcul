import 'package:culcul/features/ranking/data/models/ranking_video.dart';
import 'package:culcul/features/ranking/ranking.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_ranking_view_model.g.dart';

@riverpod
Future<List<RankingVideo>> categoryRankingList(Ref ref, {int? rid}) async {
  final result = await ref.watch(rankingRepositoryProvider).getRanking(rid: rid);
  return result.dataOrNull ?? const <RankingVideo>[];
}
