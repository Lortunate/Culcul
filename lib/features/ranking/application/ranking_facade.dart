import 'package:culcul/features/ranking/domain/repositories/ranking_repository.dart';
import 'package:culcul/features/ranking/data/ranking_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ranking_facade.g.dart';

@riverpod
RankingFacade rankingFacade(Ref ref) {
  return RankingFacade(ref.watch(rankingRepositoryProvider));
}

class RankingFacade {
  RankingFacade(this.repository);

  final RankingRepository repository;
}
