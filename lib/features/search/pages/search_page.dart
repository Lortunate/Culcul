import 'dart:async';
import 'package:cilixili/core/theme/app_colors.dart';
import 'package:cilixili/features/search/providers/search_provider.dart';
import 'package:cilixili/i18n/strings.g.dart';
import 'package:cilixili/shared/widgets/index.dart';
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
    final isSearching = useState(false);
    final searchTerm = useState('');
    final debounceTimer = useRef<Timer?>(null);

    useEffect(() {
      focusNode.requestFocus();
      void listener() {
        final text = searchController.text;
        isSearching.value = text.isNotEmpty;
        debounceTimer.value?.cancel();
        if (text.isEmpty) {
          searchTerm.value = '';
        } else {
          debounceTimer.value = Timer(const Duration(milliseconds: 500), () {
            searchTerm.value = text;
          });
        }
      }

      searchController.addListener(listener);
      return () {
        searchController.removeListener(listener);
        debounceTimer.value?.cancel();
      };
    }, [searchController]);

    return Scaffold(
      appBar: _SearchAppBar(
        controller: searchController,
        focusNode: focusNode,
        hintText: defaultSearchAsync.asData?.value?.showName,
        onClear: () {
          searchController.clear();
          isSearching.value = false;
          searchTerm.value = '';
        },
        onSearch: (value) {
          final query = value.isEmpty
              ? (defaultSearchAsync.asData?.value?.name ?? '')
              : value;
          if (query.isNotEmpty) {}
        },
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              _SearchHistorySection(),
              const SizedBox(height: 32),
              _HotSearchSection(),
            ],
          ),
          if (isSearching.value)
            Positioned.fill(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: _SearchSuggestionView(
                  term: searchTerm.value,
                  onSuggestionTap: (suggestion) {
                    searchController.text = suggestion;
                    searchController.selection = TextSelection.fromPosition(
                      TextPosition(offset: suggestion.length),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
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
    final isDark = theme.brightness == Brightness.dark;
    final t = Translations.of(context);

    return AppBar(
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Container(
        height: 36,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.background,
          borderRadius: BorderRadius.circular(18),
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textInputAction: TextInputAction.search,
          onSubmitted: onSearch,
          textAlignVertical: TextAlignVertical.center,
          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 14),
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText ?? t.search.placeholder,
            hintStyle: theme.textTheme.labelSmall?.copyWith(fontSize: 14),
            prefixIcon: Icon(
              Icons.search_rounded,
              size: 18,
              color: theme.textTheme.labelSmall?.color,
            ),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.cancel, size: 16),
                    onPressed: onClear,
                  )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TextButton(
            onPressed: () => onSearch(controller.text),
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: AppColors.primary,
            ),
            child: Text(
              t.search.button,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchSuggestionView extends ConsumerWidget {
  final String term;
  final ValueChanged<String> onSuggestionTap;

  const _SearchSuggestionView({
    required this.term,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (term.isEmpty) return const SizedBox.shrink();
    final suggestionAsync = ref.watch(searchSuggestionsProvider(term));

    return suggestionAsync.when(
      data: (suggestions) => ListView.separated(
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => const Divider(indent: 16, endIndent: 16),
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion.value, style: const TextStyle(fontSize: 14)),
            onTap: () => onSuggestionTap(suggestion.value),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            dense: true,
          );
        },
      ),
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _SearchHistorySection extends StatelessWidget {
  const _SearchHistorySection();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: t.search.history,
          padding: const EdgeInsets.only(bottom: 12),
          trailing: Icon(
            Icons.delete_outline_rounded,
            size: 18,
            color: Theme.of(context).textTheme.labelSmall?.color,
          ),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            'Flutter',
            'Riverpod',
            'Bilibili',
            'Cilixili',
          ].map((tag) => _SearchTag(tag: tag)).toList(),
        ),
      ],
    );
  }
}

class _SearchTag extends StatelessWidget {
  final String tag;
  const _SearchTag({required this.tag});

  @override
  Widget build(BuildContext context) {
    return AppTag(
      text: tag,
      fontSize: 13,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      borderRadius: 6,
    );
  }
}

class _HotSearchSection extends ConsumerWidget {
  const _HotSearchSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final trendingAsync = ref.watch(trendingRankingProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: t.search.hot_search,
          padding: const EdgeInsets.only(bottom: 12),
        ),
        trendingAsync.when(
          data: (data) {
            if (data == null) {
              return SizedBox(
                height: 120,
                child: Center(
                  child: Text(
                    t.common.no_content,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              );
            }
            if (data.list.isEmpty) {
              return SizedBox(
                height: 120,
                child: Center(
                  child: Text(
                    t.common.no_content,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              );
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 40,
                crossAxisSpacing: 12,
                mainAxisSpacing: 8,
              ),
              itemCount: data.list.length,
              itemBuilder: (context, index) {
                final item = data.list[index];
                return _HotSearchItem(
                  position: item.position,
                  keyword: item.showName,
                  onTap: () {},
                );
              },
            );
          },
          loading: () => SizedBox(
            height: 300,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 12),
                  Text(t.common.loading, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ),
          error: (error, stack) => SizedBox(
            height: 120,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(t.common.error, style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.labelSmall?.color,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HotSearchItem extends StatelessWidget {
  final int position;
  final String keyword;
  final VoidCallback onTap;

  const _HotSearchItem({
    required this.position,
    required this.keyword,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '$position',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                color: position < 4
                    ? AppColors.primary
                    : theme.textTheme.labelSmall?.color?.withOpacity(0.5),
                fontFamily: 'PingFang SC',
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              keyword,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 14,
                fontWeight: position < 4 ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
