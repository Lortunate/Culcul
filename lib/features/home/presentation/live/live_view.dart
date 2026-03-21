import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/live/controllers/live_recommend_controller.dart';
import 'package:culcul/features/home/presentation/live/widgets/live_card_skeleton.dart';
import 'package:culcul/features/home/presentation/live/widgets/live_room_card.dart';
import 'package:culcul/features/home/presentation/logic/home_scroll_manager.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveView extends HookConsumerWidget {
  const LiveView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final liveAsync = ref.watch(liveRecommendProvider);
    final scrollController = useScrollController();
    final refreshController = useMemoized(() => EasyRefreshController());

    useHomeScrollManager(ref, scrollController, refreshController, 0);

    const padding = EdgeInsets.all(8);
    const gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      childAspectRatio: 0.95,
    );

    return SmartPagingView(
      provider: liveRecommendProvider,
      asyncValue: liveAsync,
      controller: refreshController,
      onRefresh: ref.read(liveRecommendProvider.notifier).refresh,
      onLoadMore: ref.read(liveRecommendProvider.notifier).loadMore,
      skeleton: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPadding(
            padding: padding,
            sliver: SliverGrid.builder(
              gridDelegate: gridDelegate,
              itemCount: 6,
              itemBuilder: (context, index) => const LiveCardSkeleton(),
            ),
          ),
        ],
      ),
      builder: (context, items) => CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPadding(
            padding: padding,
            sliver: SliverGrid.builder(
              gridDelegate: gridDelegate,
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
      ),
    );
  }
}
