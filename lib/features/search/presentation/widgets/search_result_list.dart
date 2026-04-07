import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/core/pagination/pagination_load_gate.dart';
import 'package:culcul/core/pagination/scroll_load_trigger.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_article_item.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_bangumi_item.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_topic_item.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_user_item.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_video_item.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_empty_state_widget.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
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
            extentAfterThreshold: 500,
            gate: loadGate,
            hasMore: hasMore,
            isLoadingMore: isLoadingMore,
            task: onLoadMore,
            itemCount: () => items.length,
            hasMoreAfter: () => hasMore,
            source: 'search.search_result_list',
          ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
