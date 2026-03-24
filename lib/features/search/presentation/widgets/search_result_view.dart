import 'package:culcul/features/search/controllers/search_controller.dart';
import 'package:culcul/features/search/presentation/widgets/search_filter_bar.dart';
import 'package:culcul/features/search/presentation/widgets/search_result_list.dart';
import 'package:culcul/features/search/presentation/widgets/search_result_skeleton.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/app_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _searchTabs = ['综合', '视频', '番剧', '用户', '专栏'];
const _searchTypeConfigs = ['all', 'video', 'media_bangumi', 'bili_user', 'article'];

class SearchResultView extends HookConsumerWidget {
  final String keyword;

  const SearchResultView({super.key, required this.keyword});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: _searchTabs.length,
      child: Column(
        children: [
          const AppTabBar(tabs: _searchTabs),
          Expanded(
            child: TabBarView(
              children: [
                for (final searchType in _searchTypeConfigs)
                  SearchResultTab(keyword: keyword, searchType: searchType),
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

  const SearchResultTab({super.key, required this.keyword, this.searchType = 'all'});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    final order = useState('totalrank');
    final duration = useState(0);
    final showFilter = searchType == 'video' || searchType == 'article';

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
        if (showFilter)
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
                isLoadingMore:
                    searchResultAsync.isLoading && !searchResultAsync.isRefreshing,
                onLoadMore: notifier.fetchMore,
                onRetry: () => ref.refresh(provider),
              );
            },
            loading: () => const SearchResultSkeleton(),
            error: (error, stack) {
              debugPrint('SearchResultView Error: $error\n$stack');
              return AppErrorWidget(
                error: error,
                stackTrace: stack,
                onRetry: () => ref.refresh(provider),
              );
            },
          ),
        ),
      ],
    );
  }
}
