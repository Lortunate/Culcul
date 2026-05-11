import 'package:culcul/features/dynamic/application/dynamic_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/dynamic/application/dynamic_facade.dart' show dynamicFacadeProvider;
export 'package:culcul/features/dynamic/application/dynamic_repository_provider.dart'
    show dynamicRepositoryProvider;
export 'package:culcul/features/dynamic/application/emote_repository_provider.dart'
    show emoteRepositoryProvider;

final dynamicFacadeEntryProvider = Provider<DynamicFacade>(
  (ref) => ref.watch(dynamicFacadeProvider),
);
