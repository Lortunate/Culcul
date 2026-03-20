// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchSuggestions)
final searchSuggestionsProvider = SearchSuggestionsFamily._();

final class SearchSuggestionsProvider
    extends
        $AsyncNotifierProvider<SearchSuggestions, List<SearchSuggestionTag>> {
  SearchSuggestionsProvider._({
    required SearchSuggestionsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'searchSuggestionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchSuggestionsHash();

  @override
  String toString() {
    return r'searchSuggestionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SearchSuggestions create() => SearchSuggestions();

  @override
  bool operator ==(Object other) {
    return other is SearchSuggestionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchSuggestionsHash() => r'274b642052fe058a98f6cf80a3106d6cd4012947';

final class SearchSuggestionsFamily extends $Family
    with
        $ClassFamilyOverride<
          SearchSuggestions,
          AsyncValue<List<SearchSuggestionTag>>,
          List<SearchSuggestionTag>,
          FutureOr<List<SearchSuggestionTag>>,
          String
        > {
  SearchSuggestionsFamily._()
    : super(
        retry: null,
        name: r'searchSuggestionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SearchSuggestionsProvider call(String term) =>
      SearchSuggestionsProvider._(argument: term, from: this);

  @override
  String toString() => r'searchSuggestionsProvider';
}

abstract class _$SearchSuggestions
    extends $AsyncNotifier<List<SearchSuggestionTag>> {
  late final _$args = ref.$arg as String;
  String get term => _$args;

  FutureOr<List<SearchSuggestionTag>> build(String term);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<SearchSuggestionTag>>,
              List<SearchSuggestionTag>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<SearchSuggestionTag>>,
                List<SearchSuggestionTag>
              >,
              AsyncValue<List<SearchSuggestionTag>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(defaultSearch)
final defaultSearchProvider = DefaultSearchProvider._();

final class DefaultSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<DefaultSearchData?>,
          DefaultSearchData?,
          FutureOr<DefaultSearchData?>
        >
    with
        $FutureModifier<DefaultSearchData?>,
        $FutureProvider<DefaultSearchData?> {
  DefaultSearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'defaultSearchProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$defaultSearchHash();

  @$internal
  @override
  $FutureProviderElement<DefaultSearchData?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DefaultSearchData?> create(Ref ref) {
    return defaultSearch(ref);
  }
}

String _$defaultSearchHash() => r'120f8c084dfe09fc4763294d63ac911e7f47b310';

@ProviderFor(trendingRanking)
final trendingRankingProvider = TrendingRankingProvider._();

final class TrendingRankingProvider
    extends
        $FunctionalProvider<
          AsyncValue<TrendingRankingData?>,
          TrendingRankingData?,
          FutureOr<TrendingRankingData?>
        >
    with
        $FutureModifier<TrendingRankingData?>,
        $FutureProvider<TrendingRankingData?> {
  TrendingRankingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trendingRankingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trendingRankingHash();

  @$internal
  @override
  $FutureProviderElement<TrendingRankingData?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TrendingRankingData?> create(Ref ref) {
    return trendingRanking(ref);
  }
}

String _$trendingRankingHash() => r'd6cca2d4d5ae32fe73ddcee3303d27f016595fe7';

@ProviderFor(SearchResult)
final searchResultProvider = SearchResultFamily._();

final class SearchResultProvider
    extends $AsyncNotifierProvider<SearchResult, SearchResultData?> {
  SearchResultProvider._({
    required SearchResultFamily super.from,
    required (String, {String searchType, String order, int duration})
    super.argument,
  }) : super(
         retry: null,
         name: r'searchResultProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchResultHash();

  @override
  String toString() {
    return r'searchResultProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  SearchResult create() => SearchResult();

  @override
  bool operator ==(Object other) {
    return other is SearchResultProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchResultHash() => r'eed31376cca8640b09babd8f71b13415f8b9dff2';

final class SearchResultFamily extends $Family
    with
        $ClassFamilyOverride<
          SearchResult,
          AsyncValue<SearchResultData?>,
          SearchResultData?,
          FutureOr<SearchResultData?>,
          (String, {String searchType, String order, int duration})
        > {
  SearchResultFamily._()
    : super(
        retry: null,
        name: r'searchResultProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  SearchResultProvider call(
    String keyword, {
    String searchType = 'all',
    String order = 'totalrank',
    int duration = 0,
  }) => SearchResultProvider._(
    argument: (
      keyword,
      searchType: searchType,
      order: order,
      duration: duration,
    ),
    from: this,
  );

  @override
  String toString() => r'searchResultProvider';
}

abstract class _$SearchResult extends $AsyncNotifier<SearchResultData?> {
  late final _$args =
      ref.$arg as (String, {String searchType, String order, int duration});
  String get keyword => _$args.$1;
  String get searchType => _$args.searchType;
  String get order => _$args.order;
  int get duration => _$args.duration;

  FutureOr<SearchResultData?> build(
    String keyword, {
    String searchType = 'all',
    String order = 'totalrank',
    int duration = 0,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<SearchResultData?>, SearchResultData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SearchResultData?>, SearchResultData?>,
              AsyncValue<SearchResultData?>,
              Object?,
              Object?
            >;
    element.handleCreate(
      ref,
      () => build(
        _$args.$1,
        searchType: _$args.searchType,
        order: _$args.order,
        duration: _$args.duration,
      ),
    );
  }
}
