import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/features/ranking/data/ranking_repository_impl.dart';
import 'package:culcul/ui/widgets/layout/app_tab_bar.dart';
import 'package:culcul/features/ranking/presentation/widgets/ranking_item_card.dart';
import 'package:culcul/ui/widgets/feedback/app_empty_state_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:culcul/ui/widgets/layout/refresh_header_footer.dart';
import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:culcul/ui/responsive/app_responsive.dart';
import 'package:culcul/ui/responsive/responsive_container.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _categoryRankingListProvider = FutureProvider.autoDispose
    .family<List<VideoModel>, int?>((ref, rid) async {
      final result = await ref.watch(rankingRepositoryProvider).getRanking(rid: rid);
      return result.when(
        success: (data) => data,
        failure: (error) {
          DevLogger.log('feature', 'ranking.category.load_error', <String, Object?>{
            'rid': rid,
            'error': error,
          });
          return const <VideoModel>[];
        },
      );
    });

class _RankingCategory {
  final String name;
  final int? rid;

  const _RankingCategory({required this.name, this.rid});

  String label(Translations t) => switch (name) {
    'all' => t.ranking.categories.all,
    'animation' => t.ranking.categories.animation,
    'bangumi' => t.ranking.categories.bangumi,
    'guochuang' => t.ranking.categories.guochuang,
    'music' => t.ranking.categories.music,
    'dance' => t.ranking.categories.dance,
    'game' => t.ranking.categories.game,
    'knowledge' => t.ranking.categories.knowledge,
    'technology' => t.ranking.categories.technology,
    'sports' => t.ranking.categories.sports,
    'car' => t.ranking.categories.car,
    'life' => t.ranking.categories.life,
    'food' => t.ranking.categories.food,
    'animal' => t.ranking.categories.animal,
    'kichiku' => t.ranking.categories.kichiku,
    'fashion' => t.ranking.categories.fashion,
    'information' => t.ranking.categories.information,
    'entertainment' => t.ranking.categories.entertainment,
    'film' => t.ranking.categories.film,
    'documentary' => t.ranking.categories.documentary,
    'movie' => t.ranking.categories.movie,
    'tv' => t.ranking.categories.tv,
    'tech_digital' => t.ranking.categories.tech_digital,
    'short_play' => t.ranking.categories.short_play,
    'fashion_beauty' => t.ranking.categories.fashion_beauty,
    'sports_fitness' => t.ranking.categories.sports_fitness,
    'vlog' => t.ranking.categories.vlog,
    'painting' => t.ranking.categories.painting,
    'ai' => t.ranking.categories.ai,
    'home' => t.ranking.categories.home,
    'outdoor' => t.ranking.categories.outdoor,
    'fitness' => t.ranking.categories.fitness,
    'craft' => t.ranking.categories.craft,
    'travel' => t.ranking.categories.travel,
    'three_rural' => t.ranking.categories.three_rural,
    'parenting' => t.ranking.categories.parenting,
    'health' => t.ranking.categories.health,
    'emotion' => t.ranking.categories.emotion,
    'life_interest' => t.ranking.categories.life_interest,
    'life_experience' => t.ranking.categories.life_experience,
    _ => name,
  };
}

const _rankingCategories = [
  _RankingCategory(name: 'all'),
  _RankingCategory(name: 'animation', rid: 1005),
  _RankingCategory(name: 'game', rid: 1008),
  _RankingCategory(name: 'kichiku', rid: 1007),
  _RankingCategory(name: 'music', rid: 1003),
  _RankingCategory(name: 'dance', rid: 1004),
  _RankingCategory(name: 'film', rid: 1001),
  _RankingCategory(name: 'entertainment', rid: 1002),
  _RankingCategory(name: 'knowledge', rid: 1010),
  _RankingCategory(name: 'tech_digital', rid: 1012),
  _RankingCategory(name: 'information', rid: 1009),
  _RankingCategory(name: 'food', rid: 1020),
  _RankingCategory(name: 'short_play', rid: 1021),
  _RankingCategory(name: 'car', rid: 1013),
  _RankingCategory(name: 'fashion_beauty', rid: 1014),
  _RankingCategory(name: 'sports_fitness', rid: 1018),
  _RankingCategory(name: 'animal', rid: 1024),
  _RankingCategory(name: 'vlog', rid: 1029),
  _RankingCategory(name: 'painting', rid: 1006),
  _RankingCategory(name: 'ai', rid: 1011),
  _RankingCategory(name: 'home', rid: 1015),
  _RankingCategory(name: 'outdoor', rid: 1016),
  _RankingCategory(name: 'fitness', rid: 1017),
  _RankingCategory(name: 'craft', rid: 1019),
  _RankingCategory(name: 'travel', rid: 1022),
  _RankingCategory(name: 'three_rural', rid: 1023),
  _RankingCategory(name: 'parenting', rid: 1025),
  _RankingCategory(name: 'health', rid: 1026),
  _RankingCategory(name: 'emotion', rid: 1027),
  _RankingCategory(name: 'life_interest', rid: 1030),
  _RankingCategory(name: 'life_experience', rid: 1031),
];

class RankingPage extends StatelessWidget {
  final ValueChanged<String> onOpenVideo;

  const RankingPage({required this.onOpenVideo, super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final tabs = _rankingCategories.map((category) => category.label(t)).toList();

    return DefaultTabController(
      length: _rankingCategories.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Text(
                t.ranking.title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: AppTabBar(tabs: tabs),
            ),
          ],
          body: TabBarView(
            children: _rankingCategories
                .map(
                  (category) =>
                      _RankingListView(category: category, onOpenVideo: onOpenVideo),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _RankingListView extends ConsumerStatefulWidget {
  final _RankingCategory category;
  final ValueChanged<String> onOpenVideo;

  const _RankingListView({required this.category, required this.onOpenVideo});

  @override
  ConsumerState<_RankingListView> createState() => _RankingListViewState();
}

class _RankingListViewState extends ConsumerState<_RankingListView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final t = Translations.of(context);
    final provider = _categoryRankingListProvider(widget.category.rid);
    final rankingListAsync = ref.watch(provider);
    final content = switch (rankingListAsync) {
      AsyncData(:final value) when value.isEmpty => AppEmptyStateWidget(
        message: t.common.no_content,
      ),
      AsyncData(:final value) => ListView.separated(
        padding: EdgeInsets.all(context.isDesktopLayout ? 8 : 4),
        itemCount: value.length,
        separatorBuilder: (_, _) => SizedBox(height: context.isDesktopLayout ? 6 : 2),
        itemBuilder: (context, index) => RankingItemCard(
          video: value[index],
          rank: index + 1,
          onOpenVideo: widget.onOpenVideo,
        ),
      ),
      AsyncError(:final error, :final stackTrace) => AppErrorWidget(
        error: error,
        stackTrace: stackTrace,
        onRetry: () => ref.invalidate(provider),
      ),
      _ => ListView.separated(
        padding: EdgeInsets.fromLTRB(
          context.isDesktopLayout ? 24 : 20,
          context.isDesktopLayout ? 16 : 12,
          context.isDesktopLayout ? 24 : 20,
          context.isDesktopLayout ? 16 : 12,
        ),
        itemCount: 10,
        separatorBuilder: (_, _) => SizedBox(height: context.isDesktopLayout ? 20 : 18),
        itemBuilder: (context, _) => AppShimmer(
          child: SizedBox(
            height: 88,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    const AppShimmerBox(width: 140, height: 88, borderRadius: 6),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.14),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(2),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppShimmerBox(
                            height: 14,
                            width: double.infinity,
                            borderRadius: 2,
                          ),
                          SizedBox(height: 6),
                          AppShimmerBox(height: 14, width: 120, borderRadius: 2),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AppShimmerBox(width: 16, height: 16, borderRadius: 8),
                              SizedBox(width: 6),
                              AppShimmerBox(height: 12, width: 60, borderRadius: 2),
                            ],
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              AppShimmerBox(height: 10, width: 40, borderRadius: 2),
                              SizedBox(width: 12),
                              AppShimmerBox(height: 10, width: 40, borderRadius: 2),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
