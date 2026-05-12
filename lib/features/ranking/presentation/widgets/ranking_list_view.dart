import 'package:flutter/material.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/ranking/presentation/models/ranking_category.dart';
import 'package:culcul/features/ranking/presentation/view_models/category_ranking_view_model.dart';
import 'package:culcul/features/ranking/presentation/widgets/ranking_item_card.dart';
import 'package:culcul/features/ranking/presentation/widgets/ranking_skeleton_item.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_empty_state_widget.dart';
import 'package:culcul/ui/widgets/layout/refresh_header_footer.dart';
import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:culcul/ui/responsive/app_responsive.dart';
import 'package:culcul/ui/responsive/responsive_container.dart';
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
    final content = switch (rankingListAsync) {
      AsyncData(:final value) when value.isEmpty => AppEmptyStateWidget(
        message: t.common.no_content,
      ),
      AsyncData(:final value) => _RankingItemsList(items: value),
      AsyncError(:final error, :final stackTrace) => AppErrorWidget(
        error: error,
        stackTrace: stackTrace,
        onRetry: () => ref.invalidate(provider),
      ),
      _ => const _RankingSkeletonList(),
    };

    return EasyRefresh(
      header: const AppRefreshHeader(),
      onRefresh: () async {
        ref.invalidate(provider);
        return IndicatorResult.success;
      },
      child: ResponsiveContentContainer(
        maxWidth: AppBreakpoints.pageMaxWidth,
        child: content,
      ),
    );
  }
}

class _RankingItemsList extends StatelessWidget {
  final List<VideoModel> items;

  const _RankingItemsList({required this.items});

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktopLayout;
    return ListView.separated(
      padding: EdgeInsets.all(isDesktop ? 8 : 4),
      itemCount: items.length,
      separatorBuilder: (_, _) => SizedBox(height: isDesktop ? 6 : 2),
      itemBuilder: (context, index) =>
          RankingItemCard(video: items[index], rank: index + 1),
    );
  }
}

class _RankingSkeletonList extends StatelessWidget {
  const _RankingSkeletonList();

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktopLayout;
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        isDesktop ? 24 : 20,
        isDesktop ? 16 : 12,
        isDesktop ? 24 : 20,
        isDesktop ? 16 : 12,
      ),
      itemCount: 10,
      separatorBuilder: (_, _) => SizedBox(height: isDesktop ? 20 : 18),
      itemBuilder: (_, _) => const RankingSkeletonItem(),
    );
  }
}
