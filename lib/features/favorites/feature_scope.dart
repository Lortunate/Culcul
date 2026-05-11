import 'package:culcul/features/favorites/application/fav_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/favorites/application/fav_facade.dart' show favFacadeProvider;
export 'package:culcul/features/favorites/application/fav_repository_provider.dart'
    show favRepositoryProvider;

final favFacadeEntryProvider = Provider<FavFacade>(
  (ref) => ref.watch(favFacadeProvider),
);
