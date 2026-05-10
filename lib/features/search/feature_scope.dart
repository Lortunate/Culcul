import 'package:culcul/features/search/application/search_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/search/application/search_facade.dart' show searchFacadeProvider;

final searchFacadeEntryProvider = Provider<SearchFacade>(
  (ref) => ref.watch(searchFacadeProvider),
);
