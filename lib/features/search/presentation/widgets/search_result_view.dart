import 'dart:async';

import 'package:dio/dio.dart';
import 'package:culcul/features/search/application/search_query.dart';
import 'package:culcul/features/search/application/search_result.dart';
import 'package:culcul/features/search/data/search_repository_impl.dart';
import 'package:culcul/features/search/presentation/widgets/search_result_list.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/cards/video_list_skeleton.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/layout/app_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    final searchTabConfigs = [
      (label: t.search.tabs.all, type: SearchType.all),
      (label: t.search.tabs.video, type: SearchType.video),
      (label: t.search.tabs.anime, type: SearchType.mediaBangumi),
      (label: t.search.tabs.user, type: SearchType.biliUser),
      (label: t.search.tabs.article, type: SearchType.article),
    ];

    return DefaultTabController(
      length: searchTabConfigs.length,
      child: Column(
        children: [
          AppTabBar(tabs: searchTabConfigs.map((config) => config.label).toList()),
          Expanded(
            child: TabBarView(
              children: [
                for (final config in searchTabConfigs)
                  _SearchResultTab(
                    keyword: keyword,
                    searchType: config.type,
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
    final provider = _searchResultProvider(query);
    final searchResultAsync = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    Widget? filterBar;
    if (showFilter) {
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;
      final t = Translations.of(context);
      final orderFilters = <({String label, SearchOrder order})>[
        (label: t.search.filter.sort_default, order: SearchOrder.totalrank),
        (label: t.search.filter.sort_newest, order: SearchOrder.pubdate),
        (label: t.search.filter.sort_click, order: SearchOrder.click),
        (label: t.search.filter.sort_danmaku, order: SearchOrder.dm),
        (label: t.search.filter.sort_favorite, order: SearchOrder.stow),
      ];
      final durationFilters = <({String label, SearchDuration duration})>[
        (label: t.search.filter.duration_all, duration: SearchDuration.all),
        (label: t.search.filter.duration_short, duration: SearchDuration.short),
        (label: t.search.filter.duration_medium, duration: SearchDuration.medium),
        (label: t.search.filter.duration_long, duration: SearchDuration.long),
        (label: t.search.filter.duration_extra_long, duration: SearchDuration.extraLong),
      ];

      filterBar = Container(
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
                  for (var index = 0; index < orderFilters.length; index++)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(orderFilters[index].label),
                        selected: order.value == orderFilters[index].order,
                        onSelected: (_) => order.value = orderFilters[index].order,
                        labelStyle: theme.textTheme.labelSmall?.copyWith(
                          color: order.value == orderFilters[index].order
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                          fontSize: 12,
                          fontWeight: order.value == orderFilters[index].order
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        backgroundColor: Colors.transparent,
                        selectedColor: colorScheme.primaryContainer.withValues(
                          alpha: 0.4,
                        ),
                        side: BorderSide.none,
                        showCheckmark: false,
                      ),
                    ),
                ],
              ),
            ),
            if (searchType == SearchType.video) ...[
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var index = 0; index < durationFilters.length; index++)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(durationFilters[index].label),
                          selected: duration.value == durationFilters[index].duration,
                          onSelected: (_) =>
                              duration.value = durationFilters[index].duration,
                          labelStyle: theme.textTheme.labelSmall?.copyWith(
                            color: duration.value == durationFilters[index].duration
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant,
                            fontSize: 12,
                            fontWeight: duration.value == durationFilters[index].duration
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: const VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          backgroundColor: Colors.transparent,
                          selectedColor: colorScheme.primaryContainer.withValues(
                            alpha: 0.4,
                          ),
                          side: BorderSide.none,
                          showCheckmark: false,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    }

    return Column(
      children: [
        ...(filterBar == null ? const <Widget>[] : [filterBar]),
        Expanded(
          child: searchResultAsync.when(
            data: (data) {
              final items = data?.items ?? [];
              final hasMore = data != null && data.page < data.numPages;

              return SearchResultList(
                items: items,
                hasMore: hasMore,
                isLoadingMore:
                    searchResultAsync.isLoading && !searchResultAsync.isRefreshing,
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
          ),
        ),
      ],
    );
  }
}
