import 'dart:async';
import 'package:culcul/features/search/presentation/view_models/search_history_view_model.dart';
import 'package:culcul/features/search/presentation/view_models/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

({
  TextEditingController controller,
  FocusNode focusNode,
  String suggestionTerm,
  String? confirmedKeyword,
  VoidCallback onClear,
  void Function(String) onSearch,
  String? defaultSearchHint,
})
useSearchViewModel(WidgetRef ref) {
  final defaultSearchAsync = ref.watch(defaultSearchProvider);
  final searchController = useTextEditingController();
  final focusNode = useFocusNode();
  final suggestionTerm = useState('');
  final confirmedKeyword = useState<String?>(null);
  final debounceTimer = useRef<Timer?>(null);

  useListenable(focusNode);
  useListenable(searchController);

  void performSearch(String value) {
    final query = value.isEmpty ? (defaultSearchAsync.asData?.value?.text ?? '') : value;

    if (query.isNotEmpty) {
      confirmedKeyword.value = query;
      searchController.text = query;
      searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: query.length),
      );
      ref.read(searchHistoryProvider.notifier).add(query);
      focusNode.unfocus();
      // Clear suggestions when search is confirmed
      suggestionTerm.value = '';
    }
  }

  void onClear() {
    searchController.clear();
    suggestionTerm.value = '';
    confirmedKeyword.value = null;
    focusNode.requestFocus();
  }

  useEffect(() {
    // Auto focus on first load if no keyword
    if (confirmedKeyword.value == null) {
      focusNode.requestFocus();
    }

    void listener() {
      final text = searchController.text;

      // If text changed and matches confirmed, reset confirmed (user is editing)
      if (confirmedKeyword.value != null && text != confirmedKeyword.value) {
        confirmedKeyword.value = null;
      }

      debounceTimer.value?.cancel();
      if (text.isEmpty) {
        suggestionTerm.value = '';
      } else {
        debounceTimer.value = Timer(const Duration(milliseconds: 300), () {
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

  return (
    controller: searchController,
    focusNode: focusNode,
    suggestionTerm: suggestionTerm.value,
    confirmedKeyword: confirmedKeyword.value,
    onClear: onClear,
    onSearch: performSearch,
    defaultSearchHint: defaultSearchAsync.asData?.value?.text,
  );
}
