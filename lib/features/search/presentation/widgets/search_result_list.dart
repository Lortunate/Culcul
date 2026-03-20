import 'package:culcul/data/models/search/search_result.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_article_item.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_bangumi_item.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_topic_item.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_user_item.dart';
import 'package:culcul/features/search/presentation/widgets/items/search_video_item.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';

class SearchResultList extends StatelessWidget {
  final List<SearchResultItem> items;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final VoidCallback? onRetry;
  final Object? error;
  final StackTrace? stackTrace;

  const SearchResultList({
    super.key,
    required this.items,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    this.onRetry,
    this.error,
    this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Center(
        child: AppErrorWidget(
          error: error!,
          stackTrace: stackTrace,
          onRetry: onRetry,
        ),
      );
    }

    if (items.isEmpty) {
      return const Center(child: AppErrorWidget(message: 'No results found'));
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter < 500) {
          onLoadMore();
        }
        return false;
      },
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
          return item.map(
            video: (v) => SearchVideoItem(item: v),
            user: (u) => SearchUserItem(item: u),
            bangumi: (b) => SearchBangumiItem(item: b),
            article: (a) => SearchArticleItem(item: a),
            topic: (t) => SearchTopicItem(item: t),
          );
        },
      ),
    );
  }
}
