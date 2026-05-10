import 'package:culcul/features/history/domain/repositories/history_repository.dart';
import 'package:culcul/features/history/data/history_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_facade.g.dart';

@riverpod
HistoryFacade historyFacade(Ref ref) {
  return HistoryFacade(ref.watch(historyRepositoryProvider));
}

class HistoryFacade {
  HistoryFacade(this.repository);

  final HistoryRepository repository;
}
