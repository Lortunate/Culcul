import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/core/responsive/responsive.dart';
import 'package:culcul/features/live/live.dart';
import 'package:culcul/core/contracts/live_room_summary_contract.dart';
import 'package:culcul/features/home/presentation/widgets/live_card_skeleton.dart';
import 'package:culcul/features/home/presentation/widgets/home_layout_spec.dart';
import 'package:culcul/features/home/presentation/widgets/live_room_card.dart';
import 'package:culcul/features/home/presentation/hooks/use_home_scroll_sync.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveView extends HookConsumerWidget {
  const LiveView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final layout = HomeGridLayoutSpec.live(context);
    final liveAsync = ref.watch(liveRecommendProvider);
    final scrollController = useScrollController();
    final refreshController = useManagedEasyRefreshController();

    useHomeScrollSync(ref, scrollController, refreshController, 0);

    return ResponsiveContentContainer(
      maxWidth: AppBreakpoints.homeFeedMaxWidth,
      child: SmartPagingView(
        asyncValue: liveAsync,
        controller: refreshController,
        onRefresh: ref.read(liveRecommendProvider.notifier).refresh,
        onLoadMore: ref.read(liveRecommendProvider.notifier).loadMore,
        itemCount: () => ref.read(liveRecommendProvider).value?.length ?? 0,
        skeleton: _LiveGridSkeleton(scrollController: scrollController, layout: layout),
        builder: (context, items) =>
            _LiveGrid(items: items, scrollController: scrollController, layout: layout),
      ),
    );
  }
}

class _LiveGridSkeleton extends StatelessWidget {
  const _LiveGridSkeleton({required this.scrollController, required this.layout});

  final ScrollController scrollController;
  final HomeGridLayoutSpec layout;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPadding(
          padding: layout.padding,
          sliver: SliverGrid.builder(
            gridDelegate: layout.gridDelegate,
            itemCount: layout.skeletonCount,
            itemBuilder: (_, _) => const LiveCardSkeleton(),
          ),
        ),
      ],
    );
  }
}

class _LiveGrid extends StatelessWidget {
  const _LiveGrid({
    required this.items,
    required this.scrollController,
    required this.layout,
  });

  final List<LiveRoomSummary> items;
  final ScrollController scrollController;
  final HomeGridLayoutSpec layout;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPadding(
          padding: layout.padding,
          sliver: SliverGrid.builder(
            gridDelegate: layout.gridDelegate,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final room = items[index];
              return LiveRoomCard(
                room: room,
                onTap: () => LiveRoomRoute(roomId: room.roomId).push(context),
              );
            },
          ),
        ),
      ],
    );
  }
}
