import 'dart:async';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/request_cancel_token.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/features/search/data/search_repository_impl.dart';
import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';
import 'package:culcul/features/search/domain/repositories/search_repository.dart'
    as domain;
import 'package:culcul/features/search/presentation/view_models/search_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('searchSuggestionsProvider cancels in-flight request on dispose', () async {
    final repository = _FakeSearchRepository(delaySuggestions: true);
    final container = ProviderContainer(
      overrides: [searchRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(
      searchSuggestionsProvider('flutter'),
      (_, _) {},
      fireImmediately: true,
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));

    subscription.close();
    await Future<void>.delayed(Duration.zero);

    expect(repository.lastSuggestionsCancelToken?.isCancelled, isTrue);
    repository.completeSuggestions();
  });
}

class _FakeSearchRepository extends Fake implements domain.SearchRepository {
  final bool delaySuggestions;
  final Completer<Result<List<SearchSuggestionEntry>, AppError>> _suggestionsCompleter =
      Completer<Result<List<SearchSuggestionEntry>, AppError>>();

  _FakeSearchRepository({this.delaySuggestions = false});

  RequestCancelToken? lastSuggestionsCancelToken;

  @override
  Future<Result<List<SearchSuggestionEntry>, AppError>> getSuggestions(
    String term, {
    RequestCancelToken? cancelToken,
  }) async {
    lastSuggestionsCancelToken = cancelToken;
    if (delaySuggestions) {
      return _suggestionsCompleter.future;
    }
    return const Success(<SearchSuggestionEntry>[]);
  }

  void completeSuggestions() {
    if (_suggestionsCompleter.isCompleted) {
      return;
    }
    _suggestionsCompleter.complete(const Success(<SearchSuggestionEntry>[]));
  }

  @override
  Future<Result<SearchDefaultHint?, AppError>> getDefaultSearch({
    bool forceRefresh = false,
  }) async {
    return const Success(null);
  }

  @override
  Future<Result<List<SearchTrendingKeyword>, AppError>> getTrendingRanking({
    bool forceRefresh = false,
  }) async {
    return const Success(<SearchTrendingKeyword>[]);
  }

  @override
  Future<Result<SearchResultPage, AppError>> search({
    required String keyword,
    int page = 1,
    String searchType = 'all',
    String order = 'totalrank',
    int duration = 0,
    RequestCancelToken? cancelToken,
  }) async {
    throw UnimplementedError();
  }
}
