import 'package:flutter/material.dart';
import 'package:culcul/features/ranking/data/models/ranking_category.dart';
import 'package:culcul/features/ranking/providers/category_ranking_provider.dart';
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

    final provider = categoryRankingListProvider(rid: widget.category.rid);
    final rankingListAsync = ref.watch(provider);

    final theme = Theme.of(context);
    const separator = SizedBox(height: 2);
    const listPadding = EdgeInsets.all(4);

    return EasyRefresh(
      header: const AppRefreshHeader(),
      onRefresh: () async {
        await ref.refresh(provider.future);
        return IndicatorResult.success;
      },
      child: rankingListAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return _buildEmptyView(theme);
          }
          return ListView.separated(
            padding: listPadding,
            itemCount: items.length,
            separatorBuilder: (_, __) => separator,
            itemBuilder: (context, index) =>
                RankingItemCard(video: items[index], rank: index + 1),
          );
        },
        loading: () => ListView.separated(
          padding: listPadding,
          itemCount: 10,
          separatorBuilder: (_, __) => separator,
          itemBuilder: (_, __) => const RankingSkeletonItem(),
        ),
        error: (error, _) => _buildErrorView(theme, error, provider),
      ),
    );
  }

  Widget _buildEmptyView(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            t.common.no_content,
            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(ThemeData theme, Object error, dynamic provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text(
            t.common.load_failed,
            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey[700]),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString().split(':')[0],
            style: theme.textTheme.labelSmall?.copyWith(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => ref.refresh(provider.future),
            icon: const Icon(Icons.refresh),
            label: Text(t.common.retry),
          ),
        ],
      ),
    );
  }
}
