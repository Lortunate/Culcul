import 'package:culcul/features/live/application/live_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/live/application/live_facade.dart' show liveFacadeProvider;
export 'package:culcul/features/live/application/live_repository_provider.dart'
    show liveRepositoryProvider;

final liveFacadeEntryProvider = Provider<LiveFacade>(
  (ref) => ref.watch(liveFacadeProvider),
);
