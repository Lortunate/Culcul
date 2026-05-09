import 'package:culcul/core/session/search_providers.dart';
import 'package:culcul/features/search/application/search_service_adapter.dart';
import 'package:riverpod/misc.dart' show Override;

export 'data/search_repository_impl.dart' show searchRepositoryProvider;

class SearchFeatureScope {
  const SearchFeatureScope._();

  static List<Override> overrides() {
    return [
      searchServiceProvider.overrideWith((ref) {
        return SearchServiceAdapter(ref);
      }),
    ];
  }
}
