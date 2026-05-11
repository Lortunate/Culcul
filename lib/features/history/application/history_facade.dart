import 'package:culcul/features/history/domain/repositories/history_repository.dart';
import 'package:culcul/features/history/application/history_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_facade.g.dart';

@riverpod
HistoryFacade historyFacade(Ref ref) {
  return HistoryFacade(ref.watch(historyRepositoryEntryProvider));
}

class HistoryFacade {
  HistoryFacade(HistoryRepository repository) : _repository = repository;

  // ignore: unused_field
  final HistoryRepository _repository;
}
