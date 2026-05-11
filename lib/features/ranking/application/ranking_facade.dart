import 'package:culcul/features/ranking/domain/repositories/ranking_repository.dart';
import 'package:culcul/features/ranking/application/ranking_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ranking_facade.g.dart';

@riverpod
RankingFacade rankingFacade(Ref ref) {
  return RankingFacade(ref.watch(rankingRepositoryEntryProvider));
}

class RankingFacade {
  RankingFacade(RankingRepository repository) : _repository = repository;

  // ignore: unused_field
  final RankingRepository _repository;
}
