import 'package:culcul/data/models/search_result.dart';
import 'package:culcul/providers/search/search_provider.dart';
import 'package:culcul/ui/pages/search/widgets/items/search_article_item.dart';
import 'package:culcul/ui/pages/search/widgets/items/search_bangumi_item.dart';
import 'package:culcul/ui/pages/search/widgets/items/search_user_item.dart';
import 'package:culcul/ui/pages/search/widgets/items/search_video_item.dart';
import 'package:culcul/ui/pages/search/widgets/search_result_skeleton.dart';
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
                _SearchResultList(keyword: keyword, searchType: 'all'),
                _SearchResultList(keyword: keyword, searchType: 'video'),
                _SearchResultList(
                  keyword: keyword,
                  searchType: 'media_bangumi',
                ),
                _SearchResultList(keyword: keyword, searchType: 'bili_user'),
                _SearchResultList(keyword: keyword, searchType: 'article'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResultList extends HookConsumerWidget {
  final String keyword;
  final String searchType;

  const _SearchResultList({required this.keyword, this.searchType = 'all'});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = useState('totalrank');
    final duration = useState(0);

    final searchResultAsync = ref.watch(
      searchResultProvider(
        keyword,
        searchType: searchType,
        order: order.value,
        duration: duration.value,
      ),
    );

    return Column(
      children: [
        if (searchType == 'video' || searchType == 'article')
          _FilterBar(
            order: order.value,
            duration: duration.value,
            onOrderChanged: (v) => order.value = v,
            onDurationChanged: (v) => duration.value = v,
            showDuration: searchType == 'video',
          ),
        Expanded(
          child: searchResultAsync.when(
            data: (data) {
              final items = data?.result;
              if (data == null || items == null || items.isEmpty) {
                return const Center(
                  child: AppErrorWidget(message: 'No results found'),
                );
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification &&
                      notification.metrics.extentAfter < 500) {
                    ref
                        .read(
                          searchResultProvider(
                            keyword,
                            searchType: searchType,
                            order: order.value,
                            duration: duration.value,
                          ).notifier,
                        )
                        .fetchMore();
                  }
                  return false;
                },
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length + (data.page < data.numPages ? 1 : 0),
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    if (index == items.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      );
                    }

                    final item = items[index];
                    return item.map(
                      video: (v) => SearchVideoItem(item: v),
                      user: (u) => SearchUserItem(item: u),
                      bangumi: (b) => SearchBangumiItem(item: b),
                      article: (a) => SearchArticleItem(item: a),
                    );
                  },
                ),
              );
            },
            loading: () => const SearchResultSkeleton(),
            error: (error, stack) {
              debugPrint('SearchResultView Error: $error\n$stack');
              return AppErrorWidget(
                error: error,
                stackTrace: stack,
                onRetry: () => ref.refresh(
                  searchResultProvider(
                    keyword,
                    searchType: searchType,
                    order: order.value,
                    duration: duration.value,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FilterBar extends StatelessWidget {
  final String order;
  final int duration;
  final ValueChanged<String> onOrderChanged;
  final ValueChanged<int> onDurationChanged;
  final bool showDuration;

  const _FilterBar({
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
                  label: '综合排序',
                  selected: order == 'totalrank',
                  onSelected: (_) => onOrderChanged('totalrank'),
                ),
                _FilterChip(
                  label: '最新发布',
                  selected: order == 'pubdate',
                  onSelected: (_) => onOrderChanged('pubdate'),
                ),
                _FilterChip(
                  label: '最多点击',
                  selected: order == 'click',
                  onSelected: (_) => onOrderChanged('click'),
                ),
                _FilterChip(
                  label: '最多弹幕',
                  selected: order == 'dm',
                  onSelected: (_) => onOrderChanged('dm'),
                ),
                _FilterChip(
                  label: '最多收藏',
                  selected: order == 'stow',
                  onSelected: (_) => onOrderChanged('stow'),
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
                    label: '全部时长',
                    selected: duration == 0,
                    onSelected: (_) => onDurationChanged(0),
                  ),
                  _FilterChip(
                    label: '10分钟以下',
                    selected: duration == 1,
                    onSelected: (_) => onDurationChanged(1),
                  ),
                  _FilterChip(
                    label: '10-30分钟',
                    selected: duration == 2,
                    onSelected: (_) => onDurationChanged(2),
                  ),
                  _FilterChip(
                    label: '30-60分钟',
                    selected: duration == 3,
                    onSelected: (_) => onDurationChanged(3),
                  ),
                  _FilterChip(
                    label: '60分钟以上',
                    selected: duration == 4,
                    onSelected: (_) => onDurationChanged(4),
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
