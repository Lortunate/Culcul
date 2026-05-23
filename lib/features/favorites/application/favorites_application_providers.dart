import 'package:culcul/features/favorites/application/favorites_port.dart';
import 'package:culcul/features/favorites/data/fav_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_application_providers.g.dart';

@riverpod
FavoritesPort favoritesPort(Ref ref) {
  return ref.watch(favRepositoryProvider);
}
