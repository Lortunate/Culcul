import 'package:culcul/features/search/domain/repositories/search_repository.dart';
import 'package:culcul/features/search/application/search_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_facade.g.dart';

@riverpod
SearchFacade searchFacade(Ref ref) {
  return SearchFacade(ref.watch(searchRepositoryEntryProvider));
}

class SearchFacade {
  SearchFacade(SearchRepository repository) : _repository = repository;

  // ignore: unused_field
  final SearchRepository _repository;
}
