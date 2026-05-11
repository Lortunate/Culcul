import 'package:culcul/features/ranking/application/ranking_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/ranking/application/ranking_facade.dart' show rankingFacadeProvider;
export 'package:culcul/features/ranking/application/ranking_repository_provider.dart'
    show rankingRepositoryProvider;

final rankingFacadeEntryProvider = Provider<RankingFacade>(
  (ref) => ref.watch(rankingFacadeProvider),
);
