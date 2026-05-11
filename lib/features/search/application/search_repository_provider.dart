import 'package:culcul/features/search/data/search_repository_impl.dart' as data;
import 'package:culcul/features/search/domain/repositories/search_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchRepositoryProvider = data.searchRepositoryProvider;

final searchRepositoryEntryProvider = Provider<SearchRepository>((ref) {
  return ref.watch(searchRepositoryProvider);
});
