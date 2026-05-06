import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/core/pagination/pagination_load_gate.dart';
import 'package:culcul/core/pagination/scroll_load_trigger.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_article_item.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_bangumi_item.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_topic_item.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_user_item.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_video_item.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/shared/widgets/app_empty_state_widget.dart';
import 'package:culcul/shared/widgets/app_error_widget.dart';
import 'package:culcul/shared/widgets/app_network_image_prefetcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchResultList extends HookWidget {
  final List<SearchResultEntry> items;
  final bool hasMore;
  final bool isLoadingMore;
  final Future<void> Function() onLoadMore;
  final VoidCallback onRetry;
  final Object? error;
  final StackTrace? stackTrace;

  const SearchResultList({
    super.key,
    required this.items,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    required this.onRetry,
    this.error,
    this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    final loadGate = useMemoized(PaginationLoadGate.new, const []);
    useEffect(() {
      loadGate.reset();
      return null;
    }, [onLoadMore]);
    useEffect(() {
      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      final specs = <NetworkImagePrefetchSpec>[];

      for (final item in items.take(8)) {
        switch (item) {
          case SearchVideoEntry():
            specs.add(
              NetworkImagePrefetchSpec(
                url: item.coverUrl,
                memCacheWidth: (160 * pixelRatio).round(),
                memCacheHeight: (90 * pixelRatio).round(),
              ),
            );
          case SearchUserEntry():
            specs.add(
              NetworkImagePrefetchSpec(
                url: item.avatarUrl,
                memCacheWidth: (60 * pixelRatio).round(),
                memCacheHeight: (60 * pixelRatio).round(),
              ),
            );
          case SearchBangumiEntry():
            specs.add(
              NetworkImagePrefetchSpec(
                url: item.coverUrl,
                memCacheWidth: (82.5 * pixelRatio).round(),
                memCacheHeight: (110 * pixelRatio).round(),
              ),
            );
          case SearchArticleEntry():
            for (final url in item.imageUrls.take(3)) {
              specs.add(
                NetworkImagePrefetchSpec(
                  url: url,
                  memCacheWidth: (160 * pixelRatio).round(),
                  memCacheHeight: (90 * pixelRatio).round(),
                ),
              );
            }
          case SearchTopicEntry():
            final coverUrl = item.coverUrl;
            if (coverUrl != null && coverUrl.isNotEmpty) {
              specs.add(
                NetworkImagePrefetchSpec(
                  url: coverUrl,
                  memCacheWidth: (80 * pixelRatio).round(),
                  memCacheHeight: (80 * pixelRatio).round(),
                ),
              );
            }
        }
      }

      AppNetworkImagePrefetcher.prefetch(context, specs: specs, limit: 12);
      return null;
    }, [items]);

    final t = Translations.of(context);

    if (error != null) {
      return Center(
        child: AppErrorWidget(error: error!, stackTrace: stackTrace, onRetry: onRetry),
      );
    }

    if (items.isEmpty) {
      return Center(child: AppEmptyStateWidget(message: t.search.status.empty));
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) =>
          ScrollLoadTrigger.triggerOnScrollNotificationWithGate(
            notification: notification,
            extentAfterThreshold: 420,
            viewportFactor: 1.35,
            maxThreshold: 960,
            gate: loadGate,
            hasMore: hasMore,
            isLoadingMore: isLoadingMore,
            task: onLoadMore,
            itemCount: () => items.length,
            hasMoreAfter: () => hasMore,
            source: 'search.search_result_list',
            onlyOnScrollEnd: false,
          ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        cacheExtent: 640,
        itemCount: items.length + (hasMore ? 1 : 0),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
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
          return switch (item) {
            SearchVideoEntry v => SearchVideoItem(item: v),
            SearchUserEntry u => SearchUserItem(item: u),
            SearchBangumiEntry b => SearchBangumiItem(item: b),
            SearchArticleEntry a => SearchArticleItem(item: a),
            SearchTopicEntry t => SearchTopicItem(item: t),
          };
        },
      ),
    );
  }
}
