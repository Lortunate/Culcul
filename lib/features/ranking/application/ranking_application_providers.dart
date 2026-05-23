import 'package:culcul/features/ranking/application/ranking_port.dart';
import 'package:culcul/features/ranking/data/ranking_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ranking_application_providers.g.dart';

@riverpod
RankingPort rankingPort(Ref ref) {
  return ref.watch(rankingRepositoryProvider);
}
