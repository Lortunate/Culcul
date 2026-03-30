import 'package:culcul/features/ranking/domain/entities/ranking_video.dart';
import 'package:culcul/features/ranking/application/use_case/ranking_use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_ranking_view_model.g.dart';

@riverpod
Future<List<RankingVideo>> categoryRankingList(Ref ref, {int? rid}) async {
  final result = await ref.watch(rankingUseCasesProvider).getRanking(rid: rid);
  return result.when(success: (value) => value, failure: (error) => throw error);
}
