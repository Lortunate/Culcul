import 'package:culcul/features/search/domain/repositories/search_repository.dart';
import 'package:culcul/features/search/data/search_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_facade.g.dart';

@riverpod
SearchFacade searchFacade(Ref ref) {
  return SearchFacade(ref.watch(searchRepositoryProvider));
}

class SearchFacade {
  SearchFacade(this.repository);

  final SearchRepository repository;
}
