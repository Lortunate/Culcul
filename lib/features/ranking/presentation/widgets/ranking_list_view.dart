import 'package:flutter/material.dart';
import 'package:culcul/features/ranking/data/models/ranking_category.dart';
import 'package:culcul/features/ranking/domain/entities/ranking_video.dart';
import 'package:culcul/features/ranking/presentation/view_models/category_ranking_view_model.dart';
import 'package:culcul/features/ranking/presentation/widgets/ranking_item_card.dart';
import 'package:culcul/features/ranking/presentation/widgets/ranking_skeleton_item.dart';
import 'package:culcul/ui/widgets/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:culcul/i18n/strings.g.dart';

class RankingListView extends ConsumerStatefulWidget {
  final RankingCategory category;

  const RankingListView({required this.category, super.key});

  @override
  ConsumerState<RankingListView> createState() => _RankingListViewState();
}

class _RankingListViewState extends ConsumerState<RankingListView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final t = Translations.of(context);
    final provider = categoryRankingListProvider(rid: widget.category.rid);
    final rankingListAsync = ref.watch(provider);

    return EasyRefresh(
      header: const AppRefreshHeader(),
      onRefresh: () async {
        ref.invalidate(provider);
        return IndicatorResult.success;
      },
      child: switch (rankingListAsync) {
        AsyncData(:final value) when value.isEmpty => _RankingEmptyView(
          message: t.common.no_content,
        ),
        AsyncData(:final value) => _RankingItemsList(items: value),
        AsyncError(:final error) => _RankingErrorView(
          error: error,
          retryLabel: t.common.retry,
          loadFailedLabel: t.common.load_failed,
          onRetry: () => ref.invalidate(provider),
        ),
        _ => const _RankingSkeletonList(),
      },
    );
  }
}

class _RankingItemsList extends StatelessWidget {
  final List<RankingVideo> items;

  const _RankingItemsList({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(4),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 2),
      itemBuilder: (context, index) =>
          RankingItemCard(video: items[index], rank: index + 1),
    );
  }
}

class _RankingSkeletonList extends StatelessWidget {
  const _RankingSkeletonList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      itemCount: 10,
      separatorBuilder: (_, _) => const SizedBox(height: 18),
      itemBuilder: (_, _) => const RankingSkeletonItem(),
    );
  }
}

class _RankingEmptyView extends StatelessWidget {
  final String message;

  const _RankingEmptyView({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: colorScheme.outline),
          const SizedBox(height: 16),
          Text(
            message,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _RankingErrorView extends StatelessWidget {
  final Object error;
  final String retryLabel;
  final String loadFailedLabel;
  final VoidCallback onRetry;

  const _RankingErrorView({
    required this.error,
    required this.retryLabel,
    required this.loadFailedLabel,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: colorScheme.error),
          const SizedBox(height: 16),
          Text(
            loadFailedLabel,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString().split(':').first,
            style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.outline),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(retryLabel),
          ),
        ],
      ),
    );
  }
}
