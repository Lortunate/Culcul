import 'package:culcul/features/search/application/search_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/search/application/search_facade.dart' show searchFacadeProvider;
export 'package:culcul/features/search/application/search_repository_provider.dart'
    show searchRepositoryProvider;

final searchFacadeEntryProvider = Provider<SearchFacade>(
  (ref) => ref.watch(searchFacadeProvider),
);
