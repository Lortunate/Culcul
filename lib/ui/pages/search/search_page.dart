import 'package:culcul/ui/pages/search/hooks/use_search_controller.dart';
import 'package:culcul/ui/pages/search/widgets/hot_search_section.dart';
import 'package:culcul/ui/pages/search/widgets/search_app_bar.dart';
import 'package:culcul/ui/pages/search/widgets/search_history_section.dart';
import 'package:culcul/ui/pages/search/widgets/search_result_view.dart';
import 'package:culcul/ui/pages/search/widgets/search_suggestion_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = useSearchController(ref);

    Widget buildBody() {
      if (search.focusNode.hasFocus) {
        if (search.controller.text.isNotEmpty) {
          return SearchSuggestionView(
            term: search.suggestionTerm,
            onSuggestionTap: search.onSearch,
          );
        }
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            SearchHistorySection(onTap: search.onSearch),
            const SizedBox(height: 32),
            HotSearchSection(onTap: search.onSearch),
          ],
        );
      }

      if (search.confirmedKeyword != null) {
        return SearchResultView(keyword: search.confirmedKeyword!);
      }

      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          SearchHistorySection(onTap: search.onSearch),
          const SizedBox(height: 32),
          HotSearchSection(onTap: search.onSearch),
        ],
      );
    }

    return Scaffold(
      appBar: SearchAppBar(
        controller: search.controller,
        focusNode: search.focusNode,
        hintText: search.defaultSearchHint,
        onClear: search.onClear,
        onSearch: search.onSearch,
      ),
      body: buildBody(),
    );
  }
}
