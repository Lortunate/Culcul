import 'dart:async';

import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/core/storage/storage_keys.dart';
import 'package:culcul/features/search/application/search_application_providers.dart';
import 'package:culcul/features/search/application/search_workflows.dart';
import 'package:culcul/features/search/presentation/widgets/hot_search_section.dart';
import 'package:culcul/features/search/presentation/widgets/search_result_view.dart';
import 'package:culcul/features/search/presentation/widgets/search_suggestion_view.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/ui/widgets/buttons/app_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _searchPagePadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);

final _searchHistoryProvider = NotifierProvider<_SearchHistory, List<String>>(
  _SearchHistory.new,
);

enum _SearchPageMode { landing, suggestion, result }

class _SearchHistory extends Notifier<List<String>> {
  @override
  List<String> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getStringList(StorageKeys.searchHistory) ?? [];
  }

  Future<void> add(String term) async {
    final nextHistory = addSearchHistoryEntry(state, term);
    state = nextHistory;
    await ref
        .read(sharedPreferencesProvider)
        .setStringList(StorageKeys.searchHistory, nextHistory);
  }

  Future<void> remove(String term) async {
    final nextHistory = removeSearchHistoryEntry(state, term);
    state = nextHistory;
    await ref
        .read(sharedPreferencesProvider)
        .setStringList(StorageKeys.searchHistory, nextHistory);
  }

  Future<void> clear() async {
    state = [];
    await ref.read(sharedPreferencesProvider).remove(StorageKeys.searchHistory);
  }
}

({
  TextEditingController controller,
  FocusNode focusNode,
  String suggestionTerm,
  String? confirmedKeyword,
  _SearchPageMode mode,
  VoidCallback onClear,
  void Function(String) onSearch,
  String? defaultSearchHint,
})
_useSearchViewModel(WidgetRef ref) {
  final defaultSearchAsync = ref.watch(defaultSearchProvider);
  final searchController = useTextEditingController();
  final focusNode = useFocusNode();
  final suggestionTerm = useState('');
  final confirmedKeyword = useState<String?>(null);
  final debounceTimer = useRef<Timer?>(null);

  useListenable(focusNode);
  useListenable(searchController);

  void performSearch(String value) {
    final query = value.isEmpty ? (defaultSearchAsync.asData?.value ?? '') : value;

    if (query.isNotEmpty) {
      confirmedKeyword.value = query;
      searchController.text = query;
      searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: query.length),
      );
      ref.read(_searchHistoryProvider.notifier).add(query);
      focusNode.unfocus();
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
    if (confirmedKeyword.value == null) {
      focusNode.requestFocus();
    }

    void listener() {
      final text = searchController.text;

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

  final mode = switch ((
    focusNode.hasFocus,
    searchController.text.isNotEmpty,
    confirmedKeyword.value,
  )) {
    (true, true, _) => _SearchPageMode.suggestion,
    (false, _, final keyword?) when keyword.isNotEmpty => _SearchPageMode.result,
    _ => _SearchPageMode.landing,
  };

  return (
    controller: searchController,
    focusNode: focusNode,
    suggestionTerm: suggestionTerm.value,
    confirmedKeyword: confirmedKeyword.value,
    mode: mode,
    onClear: onClear,
    onSearch: performSearch,
    defaultSearchHint: defaultSearchAsync.asData?.value,
  );
}

class SearchPage extends HookConsumerWidget {
  final ValueChanged<String> onOpenVideo;
  final ValueChanged<int> onOpenUser;
  final void Function(int topicId, String topicName) onOpenTopic;

  const SearchPage({
    super.key,
    required this.onOpenVideo,
    required this.onOpenUser,
    required this.onOpenTopic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = _useSearchViewModel(ref);
    void onSearch(String rawTerm) {
      final normalizedTerm = normalizeSearchTerm(rawTerm);
      if (normalizedTerm == null) {
        return;
      }
      search.onSearch(normalizedTerm);
    }

    return Scaffold(
      appBar: _SearchAppBar(
        controller: search.controller,
        focusNode: search.focusNode,
        hintText: search.defaultSearchHint,
        onClear: search.onClear,
        onSearch: onSearch,
      ),
      body: switch (search.mode) {
        _SearchPageMode.suggestion => SearchSuggestionView(
          term: search.suggestionTerm,
          onSuggestionTap: onSearch,
        ),
        _SearchPageMode.result => SearchResultView(
          keyword: search.confirmedKeyword!,
          onOpenVideo: onOpenVideo,
          onOpenUser: onOpenUser,
          onOpenTopic: onOpenTopic,
        ),
        _SearchPageMode.landing => ListView(
          padding: _searchPagePadding,
          children: [
            Consumer(
              builder: (context, ref, _) {
                final t = Translations.of(context);
                final history = ref.watch(_searchHistoryProvider);

                if (history.isEmpty) return const SizedBox.shrink();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            t.search.history,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: AppClickable(
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: AppClickable(
                                  onTap: () =>
                                      ref.read(_searchHistoryProvider.notifier).clear(),
                                  child: Icon(
                                    Icons.delete_outline_rounded,
                                    size: 18,
                                    color: Theme.of(context).textTheme.labelSmall?.color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: history
                          .map(
                            (tag) => AppClickable(
                              onTap: () => onSearch(tag),
                              child: AppTag(
                                text: tag,
                                fontSize: 13,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                borderRadius: 6,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),
            HotSearchSection(onTap: onSearch),
          ],
        ),
      },
    );
  }
}

class _SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? hintText;
  final VoidCallback onClear;
  final ValueChanged<String> onSearch;

  const _SearchAppBar({
    required this.controller,
    required this.focusNode,
    this.hintText,
    required this.onClear,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return AppBar(
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Container(
        height: 36,
        margin: const EdgeInsets.only(left: CulculSpacing.xs, right: CulculSpacing.xxs),
        decoration: BoxDecoration(
          color:
              theme.inputDecorationTheme.fillColor ?? colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(CulculRadius.lg),
          border: Border.all(color: Colors.transparent, width: 0.0),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            Icon(Icons.search_rounded, size: 18, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: CulculSpacing.xs),
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                textInputAction: TextInputAction.search,
                onSubmitted: onSearch,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: colorScheme.primary,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: colorScheme.onSurface,
                  height: 1.2,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: hintText ?? t.search.placeholder,
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    fontSize: 13,
                    height: 1.2,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            if (controller.text.isNotEmpty) ...[
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                icon: Icon(
                  Icons.cancel,
                  size: 16,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
                onPressed: onClear,
              ),
              const SizedBox(width: CulculSpacing.xxs),
            ] else
              const SizedBox(width: 14),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: CulculSpacing.xs),
          child: TextButton(
            onPressed: () => onSearch(controller.text),
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(
                horizontal: CulculSpacing.md,
                vertical: CulculSpacing.xs,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: colorScheme.primary,
            ),
            child: Text(
              t.search.button,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
