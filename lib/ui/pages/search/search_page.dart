import 'dart:async';
import 'package:culcul/ui/pages/search/widgets/hot_search_section.dart';
import 'package:culcul/ui/pages/search/widgets/search_app_bar.dart';
import 'package:culcul/ui/pages/search/widgets/search_history_section.dart';
import 'package:culcul/ui/pages/search/widgets/search_result_view.dart';
import 'package:culcul/ui/pages/search/widgets/search_suggestion_view.dart';
import 'package:culcul/providers/search/search_history_provider.dart';
import 'package:culcul/providers/search/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultSearchAsync = ref.watch(defaultSearchProvider);
    final searchController = useTextEditingController();
    final focusNode = useFocusNode();

    useListenable(focusNode);
    useListenable(searchController);

    final suggestionTerm = useState('');
    final confirmedKeyword = useState<String?>(null);
    final debounceTimer = useRef<Timer?>(null);

    void performSearch(String value) {
      final query = value.isEmpty
          ? (defaultSearchAsync.asData?.value?.name ?? '')
          : value;
      if (query.isNotEmpty) {
        confirmedKeyword.value = query;
        searchController.text = query;
        searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: query.length),
        );
        ref.read(searchHistoryProvider.notifier).add(query);
        focusNode.unfocus();
      }
    }

    useEffect(() {
      focusNode.requestFocus();
      void listener() {
        final text = searchController.text;

        if (confirmedKeyword.value != null && text != confirmedKeyword.value) {
          confirmedKeyword.value = null;
        }

        debounceTimer.value?.cancel();
        if (text.isEmpty) {
          suggestionTerm.value = '';
        } else {
          debounceTimer.value = Timer(const Duration(milliseconds: 500), () {
            suggestionTerm.value = text;
          });
        }
      }

      searchController.addListener(listener);
      return () {
        searchController.removeListener(listener);
        debounceTimer.value?.cancel();
      };
    }, [searchController]);

    Widget buildBody() {
      if (focusNode.hasFocus) {
        if (searchController.text.isNotEmpty) {
          return SearchSuggestionView(
            term: suggestionTerm.value,
            onSuggestionTap: performSearch,
          );
        }
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            SearchHistorySection(onTap: performSearch),
            const SizedBox(height: 32),
            HotSearchSection(onTap: performSearch),
          ],
        );
      }

      if (confirmedKeyword.value != null) {
        return SearchResultView(keyword: confirmedKeyword.value!);
      }

      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          SearchHistorySection(onTap: performSearch),
          const SizedBox(height: 32),
          HotSearchSection(onTap: performSearch),
        ],
      );
    }

    return Scaffold(
      appBar: SearchAppBar(
        controller: searchController,
        focusNode: focusNode,
        hintText: defaultSearchAsync.asData?.value?.showName,
        onClear: () {
          searchController.clear();
          suggestionTerm.value = '';
          confirmedKeyword.value = null;
          focusNode.requestFocus();
        },
        onSearch: performSearch,
      ),
      body: buildBody(),
    );
  }
}
