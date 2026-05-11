import 'package:culcul/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:culcul/features/favorites/application/fav_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fav_facade.g.dart';

@riverpod
FavFacade favFacade(Ref ref) {
  return FavFacade(ref.watch(favRepositoryEntryProvider));
}

class FavFacade {
  FavFacade(FavoriteRepository repository) : _repository = repository;

  // ignore: unused_field
  final FavoriteRepository _repository;
}
