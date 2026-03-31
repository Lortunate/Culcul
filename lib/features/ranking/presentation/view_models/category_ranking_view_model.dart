import 'package:culcul/features/ranking/domain/entities/ranking_video.dart';
import 'package:culcul/features/ranking/ranking_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_ranking_view_model.g.dart';

@riverpod
Future<List<RankingVideo>> categoryRankingList(Ref ref, {int? rid}) async {
  return ref.watch(rankingRepositoryProvider).getRanking(rid: rid);
}
