import 'package:culcul/providers/bangumi/bangumi_provider.dart';
import 'package:culcul/ui/pages/home/logic/home_scroll_manager.dart';
import 'package:culcul/ui/pages/home/widgets/bangumi_card.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BangumiView extends HookConsumerWidget {
  const BangumiView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final timelineAsync = ref.watch(bangumiTimelineProvider());
    final scrollController = useScrollController();
    final refreshController = useMemoized(() => EasyRefreshController(), []);

    useHomeScrollManager(ref, scrollController, refreshController, 3);

    return SmartPagingView(
      provider: bangumiTimelineProvider(),
      asyncValue: timelineAsync,
      controller: refreshController,
      onRefresh: () => ref.refresh(bangumiTimelineProvider().future),
      skeleton: const CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
      builder: (context, timeline) => CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = timeline[index];
                  return BangumiCard(item: item);
                },
                childCount: timeline.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
