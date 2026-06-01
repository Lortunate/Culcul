// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_application_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchSuggestions)
final searchSuggestionsProvider = SearchSuggestionsFamily._();

final class SearchSuggestionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
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
  $FutureProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    final argument = this.argument as String;
    return searchSuggestions(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchSuggestionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchSuggestionsHash() => r'6de0a7382caf72a0f2a277eb4f3f5dcd25f7fb80';

final class SearchSuggestionsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<String>>, String> {
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

@ProviderFor(DefaultSearch)
final defaultSearchProvider = DefaultSearchProvider._();

final class DefaultSearchProvider extends $AsyncNotifierProvider<DefaultSearch, String?> {
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
  DefaultSearch create() => DefaultSearch();
}

String _$defaultSearchHash() => r'3951026eb0a53c08c60a421f8edef7ad9e13a8bd';

abstract class _$DefaultSearch extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(TrendingRanking)
final trendingRankingProvider = TrendingRankingProvider._();

final class TrendingRankingProvider
    extends $AsyncNotifierProvider<TrendingRanking, List<SearchTrendingItem>> {
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
  TrendingRanking create() => TrendingRanking();
}

String _$trendingRankingHash() => r'03d06748ce8a31061a0a850c22085420d389ee59';

abstract class _$TrendingRanking extends $AsyncNotifier<List<SearchTrendingItem>> {
  FutureOr<List<SearchTrendingItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<SearchTrendingItem>>, List<SearchTrendingItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SearchTrendingItem>>, List<SearchTrendingItem>>,
              AsyncValue<List<SearchTrendingItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(topicSearch)
final topicSearchProvider = TopicSearchFamily._();

final class TopicSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SearchTopicEntry>>,
          List<SearchTopicEntry>,
          FutureOr<List<SearchTopicEntry>>
        >
    with
        $FutureModifier<List<SearchTopicEntry>>,
        $FutureProvider<List<SearchTopicEntry>> {
  TopicSearchProvider._({
    required TopicSearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'topicSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$topicSearchHash();

  @override
  String toString() {
    return r'topicSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SearchTopicEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SearchTopicEntry>> create(Ref ref) {
    final argument = this.argument as String;
    return topicSearch(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TopicSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$topicSearchHash() => r'40bbdc78aeebe473578195ed602e8cd3afe24824';

final class TopicSearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<SearchTopicEntry>>, String> {
  TopicSearchFamily._()
    : super(
        retry: null,
        name: r'topicSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TopicSearchProvider call(String keyword) =>
      TopicSearchProvider._(argument: keyword, from: this);

  @override
  String toString() => r'topicSearchProvider';
}
