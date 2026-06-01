import 'dart:async';

import 'package:dio/dio.dart';
import 'package:culcul/features/search/application/search_query.dart';
import 'package:culcul/features/search/application/search_result.dart';
import 'package:culcul/features/search/data/search_repository_impl.dart';
import 'package:culcul/features/search/presentation/widgets/search_result_list.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_skeleton.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/layout/app_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _searchTypeConfigs = <SearchType>[
  SearchType.all,
  SearchType.video,
  SearchType.mediaBangumi,
  SearchType.biliUser,
  SearchType.article,
];

final _searchResultProvider = AsyncNotifierProvider.autoDispose
    .family<_SearchResult, SearchResultPage?, SearchQuery>(_SearchResult.new);

class _SearchResult extends AsyncNotifier<SearchResultPage?> {
  _SearchResult(this.query);

  final SearchQuery query;
  CancelToken? _activeCancelToken;

  @override
  Future<SearchResultPage?> build() async {
    ref.onDispose(() {
      _activeCancelToken?.cancel('search_result_disposed');
    });
    if (query.keyword.isEmpty) return null;
    _activeCancelToken?.cancel('search_result_rebuilt');
    final cancelToken = CancelToken();
    _activeCancelToken = cancelToken;
    final result = await ref
        .watch(searchRepositoryProvider)
        .search(query: query, cancelToken: cancelToken);
    return result.dataOrNull;
  }

  Future<void> fetchMore() async {
    final oldState = state.value;
    if (oldState == null || state.isLoading || oldState.page >= oldState.numPages) {
      return;
    }

    state = const AsyncLoading<SearchResultPage?>().copyWithPrevious(state);
    _activeCancelToken?.cancel('search_result_load_more_replaced');
    final cancelToken = CancelToken();
    _activeCancelToken = cancelToken;
    state = await AsyncValue.guard(() async {
      final nextQuery = SearchQuery(
        keyword: query.keyword,
        type: query.type,
        order: query.order,
        duration: query.duration,
        page: oldState.page + 1,
      );
      final result = await ref
          .read(searchRepositoryProvider)
          .search(query: nextQuery, cancelToken: cancelToken);
      return result.when(
        success: (newData) => SearchResultPage(
          page: newData.page,
          numPages: newData.numPages,
          items: [...oldState.items, ...newData.items],
        ),
        failure: (_) => oldState,
      );
    });
  }
}

class SearchResultView extends HookConsumerWidget {
  final String keyword;
  final ValueChanged<String> onOpenVideo;
  final ValueChanged<int> onOpenUser;
  final void Function(int topicId, String topicName) onOpenTopic;

  const SearchResultView({
    super.key,
    required this.keyword,
    required this.onOpenVideo,
    required this.onOpenUser,
    required this.onOpenTopic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final searchTabs = [
      t.search.tabs.all,
      t.search.tabs.video,
      t.search.tabs.anime,
      t.search.tabs.user,
      t.search.tabs.article,
    ];

    return DefaultTabController(
      length: searchTabs.length,
      child: Column(
        children: [
          AppTabBar(tabs: searchTabs),
          Expanded(
            child: TabBarView(
              children: [
                for (final searchType in _searchTypeConfigs)
                  _SearchResultTab(
                    keyword: keyword,
                    searchType: searchType,
                    onOpenVideo: onOpenVideo,
                    onOpenUser: onOpenUser,
                    onOpenTopic: onOpenTopic,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResultTab extends HookConsumerWidget {
  final String keyword;
  final SearchType searchType;
  final ValueChanged<String> onOpenVideo;
  final ValueChanged<int> onOpenUser;
  final void Function(int topicId, String topicName) onOpenTopic;

  const _SearchResultTab({
    required this.keyword,
    required this.onOpenVideo,
    required this.onOpenUser,
    required this.onOpenTopic,
    this.searchType = SearchType.all,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final order = useState(SearchOrder.totalrank);
    final duration = useState(SearchDuration.all);
    final showFilter = searchType == SearchType.video || searchType == SearchType.article;
    final query = SearchQuery(
      keyword: keyword,
      type: searchType,
      order: order.value,
      duration: duration.value,
    );

    return Column(
      children: [
        if (showFilter)
          _SearchFilterBar(
            order: order.value,
            duration: duration.value,
            onOrderChanged: (v) => order.value = v,
            onDurationChanged: (v) => duration.value = v,
            showDuration: searchType.supportsDuration,
          ),
        Expanded(
          child: _SearchResultPane(
            query: query,
            onOpenVideo: onOpenVideo,
            onOpenUser: onOpenUser,
            onOpenTopic: onOpenTopic,
          ),
        ),
      ],
    );
  }
}

class _SearchResultPane extends ConsumerWidget {
  final SearchQuery query;
  final ValueChanged<String> onOpenVideo;
  final ValueChanged<int> onOpenUser;
  final void Function(int topicId, String topicName) onOpenTopic;

  const _SearchResultPane({
    required this.query,
    required this.onOpenVideo,
    required this.onOpenUser,
    required this.onOpenTopic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = _searchResultProvider(query);
    final searchResultAsync = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    return searchResultAsync.when(
      data: (data) {
        final items = data?.items ?? [];
        final hasMore = data != null && data.page < data.numPages;

        return SearchResultList(
          items: items,
          hasMore: hasMore,
          isLoadingMore: searchResultAsync.isLoading && !searchResultAsync.isRefreshing,
          onLoadMore: notifier.fetchMore,
          onOpenVideo: onOpenVideo,
          onOpenUser: onOpenUser,
          onOpenTopic: onOpenTopic,
        );
      },
      loading: () => ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return const VideoListSkeleton(
            padding: EdgeInsets.zero,
            thumbnailWidth: 177,
            aspectRatio: 16 / 9,
          );
        },
      ),
      error: (error, stack) => AppErrorWidget(
        error: error,
        stackTrace: stack,
        onRetry: () => ref.refresh(provider),
      ),
    );
  }
}

class _SearchFilterBar extends StatelessWidget {
  final SearchOrder order;
  final SearchDuration duration;
  final ValueChanged<SearchOrder> onOrderChanged;
  final ValueChanged<SearchDuration> onDurationChanged;
  final bool showDuration;

  const _SearchFilterBar({
    required this.order,
    required this.duration,
    required this.onOrderChanged,
    required this.onDurationChanged,
    this.showDuration = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(
                  label: t.search.filter.sort_default,
                  selected: order == SearchOrder.totalrank,
                  onSelected: (_) => onOrderChanged(SearchOrder.totalrank),
                ),
                _FilterChip(
                  label: t.search.filter.sort_newest,
                  selected: order == SearchOrder.pubdate,
                  onSelected: (_) => onOrderChanged(SearchOrder.pubdate),
                ),
                _FilterChip(
                  label: t.search.filter.sort_click,
                  selected: order == SearchOrder.click,
                  onSelected: (_) => onOrderChanged(SearchOrder.click),
                ),
                _FilterChip(
                  label: t.search.filter.sort_danmaku,
                  selected: order == SearchOrder.dm,
                  onSelected: (_) => onOrderChanged(SearchOrder.dm),
                ),
                _FilterChip(
                  label: t.search.filter.sort_favorite,
                  selected: order == SearchOrder.stow,
                  onSelected: (_) => onOrderChanged(SearchOrder.stow),
                ),
              ],
            ),
          ),
          if (showDuration) ...[
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: t.search.filter.duration_all,
                    selected: duration == SearchDuration.all,
                    onSelected: (_) => onDurationChanged(SearchDuration.all),
                  ),
                  _FilterChip(
                    label: t.search.filter.duration_short,
                    selected: duration == SearchDuration.short,
                    onSelected: (_) => onDurationChanged(SearchDuration.short),
                  ),
                  _FilterChip(
                    label: t.search.filter.duration_medium,
                    selected: duration == SearchDuration.medium,
                    onSelected: (_) => onDurationChanged(SearchDuration.medium),
                  ),
                  _FilterChip(
                    label: t.search.filter.duration_long,
                    selected: duration == SearchDuration.long,
                    onSelected: (_) => onDurationChanged(SearchDuration.long),
                  ),
                  _FilterChip(
                    label: t.search.filter.duration_extra_long,
                    selected: duration == SearchDuration.extraLong,
                    onSelected: (_) => onDurationChanged(SearchDuration.extraLong),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: onSelected,
        labelStyle: theme.textTheme.labelSmall?.copyWith(
          color: selected ? colorScheme.primary : colorScheme.onSurfaceVariant,
          fontSize: 12,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        backgroundColor: Colors.transparent,
        selectedColor: colorScheme.primaryContainer.withValues(alpha: 0.4),
        side: BorderSide.none,
        showCheckmark: false,
      ),
    );
  }
}
