import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/features/ranking/data/ranking_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_ranking_view_model.g.dart';

@riverpod
Future<List<VideoModel>> categoryRankingList(Ref ref, {int? rid}) async {
  final result = await ref.watch(rankingRepositoryProvider).getRanking(rid: rid);
  return result.when(
    success: (data) => data,
    failure: (error) {
      DevLogger.log('feature', 'ranking.category.load_error', <String, Object?>{
        'rid': rid,
        'error': error,
      });
      return const <VideoModel>[];
    },
  );
}
