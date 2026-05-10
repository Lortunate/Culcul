import 'package:culcul/features/favorites/domain/repositories/fav_repository.dart';
import 'package:culcul/features/favorites/data/fav_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fav_facade.g.dart';

@riverpod
FavFacade favFacade(Ref ref) {
  return FavFacade(ref.watch(favRepositoryProvider));
}

class FavFacade {
  FavFacade(this.repository);

  final FavRepository repository;
}
