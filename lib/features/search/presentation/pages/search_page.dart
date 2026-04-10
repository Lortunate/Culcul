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

    return Scaffold(
      appBar: SearchAppBar(
        controller: search.controller,
        focusNode: search.focusNode,
        hintText: search.defaultSearchHint,
        onClear: search.onClear,
        onSearch: search.onSearch,
      ),
      body: _buildSearchBody(search),
    );
  }
}

Widget _buildSearchBody(
  SearchPageState search,
) {
  return switch (search.mode) {
    SearchPageMode.suggestion => SearchSuggestionView(
      term: search.suggestionTerm,
      onSuggestionTap: search.onSearch,
    ),
    SearchPageMode.result => SearchResultView(keyword: search.confirmedKeyword!),
    SearchPageMode.landing => _SearchLandingContent(onTap: search.onSearch),
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
