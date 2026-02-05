import 'package:culcul/core/router/router.dart';
import 'package:culcul/providers/live/live_provider.dart';
import 'package:culcul/ui/pages/home/live/widgets/live_card_skeleton.dart';
import 'package:culcul/ui/pages/home/live/widgets/live_room_card.dart';
import 'package:culcul/ui/pages/live/live_room_page.dart';
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
    final refreshController = useMemoized(() => EasyRefreshController());

    // Common grid delegate for consistency
    const gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 0.88,
    );

    return SmartPagingView(
      provider: liveRecommendProvider,
      asyncValue: liveAsync,
      controller: refreshController,
      onRefresh: () => ref.read(liveRecommendProvider.notifier).refresh(),
      skeleton: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: gridDelegate,
              delegate: SliverChildBuilderDelegate(
                (context, index) => const LiveCardSkeleton(),
                childCount: 6, // Show 6 skeleton items
              ),
            ),
          ),
        ],
      ),
      builder: (context, items) => CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
            sliver: SliverGrid(
              gridDelegate: gridDelegate,
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final room = items[index];
                  return LiveRoomCard(
                    room: room,
                    onTap: () {
                      LiveRoomRoute(roomId: room.roomId).push(context);
                    },
                  );
                },
                childCount: items.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
