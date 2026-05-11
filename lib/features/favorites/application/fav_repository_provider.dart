import 'package:culcul/features/favorites/data/fav_repository_impl.dart' as data;
import 'package:culcul/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final favRepositoryProvider = data.favRepositoryProvider;

final favRepositoryEntryProvider = Provider<FavoriteRepository>((ref) {
  return ref.watch(favRepositoryProvider);
});
