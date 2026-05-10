import 'package:culcul/core/contracts/search_port.dart';
import 'package:culcul/core/session/search_providers.dart';
import 'package:culcul/features/search/application/search_service_adapter.dart';
import 'package:culcul/features/search/data/search_repository_impl.dart';
import 'package:riverpod/misc.dart' show Override;

export 'data/search_repository_impl.dart' show searchRepositoryProvider;

class SearchFeatureScope {
  const SearchFeatureScope._();

  static List<Override> overrides() {
    return [
      searchPortProvider.overrideWith((ref) {
        return ref.read(searchRepositoryProvider) as SearchPort;
      }),
      searchServiceProvider.overrideWith((ref) {
        return SearchServiceAdapter(ref);
      }),
    ];
  }
}
