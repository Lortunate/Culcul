import 'package:culcul/features/ranking/data/ranking_repository_impl.dart' as data;
import 'package:culcul/features/ranking/domain/repositories/ranking_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rankingRepositoryProvider = data.rankingRepositoryProvider;

final rankingRepositoryEntryProvider = Provider<RankingRepository>((ref) {
  return ref.watch(rankingRepositoryProvider);
});
