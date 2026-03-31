import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/live/presentation/view_models/live_recommend_view_model.dart';
import 'package:culcul/core/contracts/live_room_summary_contract.dart';
import 'package:culcul/features/home/presentation/widgets/live/live_card_skeleton.dart';
import 'package:culcul/features/home/presentation/widgets/live/live_room_card.dart';
import 'package:culcul/features/home/presentation/widgets/hooks/use_home_scroll_sync.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _livePadding = EdgeInsets.all(8);
const _liveGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  mainAxisSpacing: 6,
  crossAxisSpacing: 6,
  childAspectRatio: 1.1,
);

class LiveView extends HookConsumerWidget {
  const LiveView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final liveAsync = ref.watch(liveRecommendProvider);
    final scrollController = useScrollController();
    final refreshController = useMemoized(() => EasyRefreshController());

    useHomeScrollSync(ref, scrollController, refreshController, 0);

    return SmartPagingView(
      provider: liveRecommendProvider,
      asyncValue: liveAsync,
      controller: refreshController,
      onRefresh: ref.read(liveRecommendProvider.notifier).refresh,
      onLoadMore: ref.read(liveRecommendProvider.notifier).loadMore,
      skeleton: _LiveGridSkeleton(scrollController: scrollController),
      builder: (context, items) =>
          _LiveGrid(items: items, scrollController: scrollController),
    );
  }
}

class _LiveGridSkeleton extends StatelessWidget {
  const _LiveGridSkeleton({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPadding(
          padding: _livePadding,
          sliver: SliverGrid.builder(
            gridDelegate: _liveGridDelegate,
            itemCount: 6,
            itemBuilder: (_, _) => const LiveCardSkeleton(),
          ),
        ),
      ],
    );
  }
}

class _LiveGrid extends StatelessWidget {
  const _LiveGrid({required this.items, required this.scrollController});

  final List<LiveRoomSummary> items;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPadding(
          padding: _livePadding,
          sliver: SliverGrid.builder(
            gridDelegate: _liveGridDelegate,
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



