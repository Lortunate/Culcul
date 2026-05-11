import 'package:culcul/features/history/data/history_repository_impl.dart' as data;
import 'package:culcul/features/history/domain/repositories/history_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final historyRepositoryProvider = data.historyRepositoryProvider;

final historyRepositoryEntryProvider = Provider<HistoryRepository>((ref) {
  return ref.watch(historyRepositoryProvider);
});
