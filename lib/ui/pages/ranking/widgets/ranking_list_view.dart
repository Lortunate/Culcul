import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:culcul/domain/entities/ranking_category.dart';
import 'package:culcul/providers/ranking/category_ranking_provider.dart';
import 'package:culcul/ui/pages/ranking/widgets/ranking_item_card.dart';
import 'package:culcul/ui/widgets/skeletons/video_list_skeleton.dart';
import 'package:culcul/i18n/strings.g.dart';

class RankingListView extends ConsumerWidget {
  final RankingCategory category;

  const RankingListView({required this.category, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rankingListAsync = ref.watch(
      categoryRankingListProvider(rid: category.rid),
    );

    return EasyRefresh(
      header: const MaterialHeader(),
      onRefresh: () async {
        final _ = await ref.refresh(categoryRankingListProvider(rid: category.rid).future);
        return IndicatorResult.success;
      },
      child: rankingListAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    t.common.no_content,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(height: 1, indent: 16, endIndent: 16),
            itemBuilder: (context, index) {
              return RankingItemCard(videoItem: items[index], rank: index + 1);
            },
          );
        },
        loading: () => ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: 10,
          separatorBuilder: (context, index) => const Divider(height: 1, indent: 16, endIndent: 16),
          itemBuilder: (context, index) => const VideoListSkeleton(
            thumbnailWidth: 140,
            aspectRatio: 140 / 88,
            height: 88,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
              const SizedBox(height: 16),
              Text(
                t.common.load_failed,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString().split(':')[0],
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => ref.refresh(
                  categoryRankingListProvider(rid: category.rid).future,
                ),
                icon: const Icon(Icons.refresh),
                label: Text(t.common.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
