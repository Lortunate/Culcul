import 'package:culcul/features/search/logic/search_provider.dart';
import 'package:culcul/features/search/presentation/widgets/search_filter_bar.dart';
import 'package:culcul/features/search/presentation/widgets/search_result_list.dart';
import 'package:culcul/features/search/presentation/widgets/search_result_skeleton.dart';
import 'package:culcul/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchResultView extends HookConsumerWidget {
  final String keyword;

  const SearchResultView({super.key, required this.keyword});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 5,
      child: Column(
        children: [
          const AppTabBar(tabs: ['综合', '视频', '番剧', '用户', '专栏']),
          Expanded(
            child: TabBarView(
              children: [
                SearchResultTab(keyword: keyword, searchType: 'all'),
                SearchResultTab(keyword: keyword, searchType: 'video'),
                SearchResultTab(keyword: keyword, searchType: 'media_bangumi'),
                SearchResultTab(keyword: keyword, searchType: 'bili_user'),
                SearchResultTab(keyword: keyword, searchType: 'article'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchResultTab extends HookConsumerWidget {
  final String keyword;
  final String searchType;

  const SearchResultTab({
    super.key,
    required this.keyword,
    this.searchType = 'all',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    final order = useState('totalrank');
    final duration = useState(0);

    final provider = searchResultProvider(
      keyword,
      searchType: searchType,
      order: order.value,
      duration: duration.value,
    );
    final searchResultAsync = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    return Column(
      children: [
        if (searchType == 'video' || searchType == 'article')
          SearchFilterBar(
            order: order.value,
            duration: duration.value,
            onOrderChanged: (v) => order.value = v,
            onDurationChanged: (v) => duration.value = v,
            showDuration: searchType == 'video',
          ),
        Expanded(
          child: searchResultAsync.when(
            data: (data) {
              final items = data?.result ?? [];
              final hasMore = data != null && data.page < data.numPages;

              return SearchResultList(
                items: items,
                hasMore: hasMore,
                isLoadingMore: searchResultAsync.isLoading &&
                    !searchResultAsync.isRefreshing,
                onLoadMore: notifier.fetchMore,
                onRetry: () => ref.refresh(provider),
              );
            },
            loading: () {
              // If we have previous data, show it (handled by when data case if properly set up)
              // But AsyncValue.when usually distinguishes data/loading/error strictly unless using .hasValue check.
              // However, since we use copyWithPrevious in provider, loading state will also have data.
              // So 'loading' callback here is only called for INITIAL loading.
              return const SearchResultSkeleton();
            },
            error: (error, stack) {
              // Similarly, if we have previous data, we might want to show it?
              // But here let's show error widget.
              debugPrint('SearchResultView Error: $error\n$stack');
              return AppErrorWidget(
                error: error,
                stackTrace: stack,
                onRetry: () => ref.refresh(provider),
              );
            },
            // skipLoadingOnReload: true, // This makes it not go to loading state on refresh if data exists
            // But we handled state transition in provider manually with copyWithPrevious.
          ),
        ),
      ],
    );
  }
}
