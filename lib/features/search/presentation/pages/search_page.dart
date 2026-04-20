import 'package:culcul/features/search/application/search_workflows.dart';
import 'package:culcul/features/search/presentation/hooks/use_search_view_model.dart';
import 'package:culcul/features/search/presentation/widgets/hot_search_section.dart';
import 'package:culcul/features/search/presentation/widgets/search_app_bar.dart';
import 'package:culcul/features/search/presentation/widgets/search_history_section.dart';
import 'package:culcul/features/search/presentation/widgets/search_result_view.dart';
import 'package:culcul/features/search/presentation/widgets/search_suggestion_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _searchPagePadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = useSearchViewModel(ref);
    final onSearch = _buildOnSearch(search);

    return Scaffold(
      appBar: SearchAppBar(
        controller: search.controller,
        focusNode: search.focusNode,
        hintText: search.defaultSearchHint,
        onClear: search.onClear,
        onSearch: onSearch,
      ),
      body: _buildSearchBody(search, onSearch),
    );
  }
}

Widget _buildSearchBody(SearchPageState search, ValueChanged<String> onSearch) {
  return switch (search.mode) {
    SearchPageMode.suggestion => SearchSuggestionView(
      term: search.suggestionTerm,
      onSuggestionTap: onSearch,
    ),
    SearchPageMode.result => SearchResultView(keyword: search.confirmedKeyword!),
    SearchPageMode.landing => _SearchLandingContent(onTap: onSearch),
  };
}

ValueChanged<String> _buildOnSearch(SearchPageState search) {
  return (rawTerm) {
    final submission = prepareSearchSubmission(rawTerm);
    if (submission == null) {
      return;
    }
    search.onSearch(submission.term);
  };
}

class _SearchLandingContent extends StatelessWidget {
  const _SearchLandingContent({required this.onTap});

  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: _searchPagePadding,
      children: [
        SearchHistorySection(onTap: onTap),
        const SizedBox(height: 32),
        HotSearchSection(onTap: onTap),
      ],
    );
  }
}
