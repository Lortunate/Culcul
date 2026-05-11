import 'package:culcul/features/history/application/history_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/history/application/history_facade.dart' show historyFacadeProvider;
export 'package:culcul/features/history/application/history_repository_provider.dart'
    show historyRepositoryProvider;

final historyFacadeEntryProvider = Provider<HistoryFacade>(
  (ref) => ref.watch(historyFacadeProvider),
);
