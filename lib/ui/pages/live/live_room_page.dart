import 'package:culcul/providers/live/live_room_controller.dart';
import 'package:culcul/ui/pages/live/widgets/live_danmaku_view.dart';
import 'package:culcul/ui/pages/live/widgets/live_info_view.dart';
import 'package:culcul/ui/pages/live/widgets/live_player_view.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveRoomPage extends HookConsumerWidget {
  final int roomId;

  const LiveRoomPage({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(liveRoomControllerProvider(roomId));

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: LivePlayerView(roomId: roomId),
            ),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.error != null
                      ? Center(
                          child: AppErrorWidget(
                            error: state.error,
                            onRetry: () => ref
                                .read(liveRoomControllerProvider(roomId).notifier)
                                .refresh(),
                          ),
                        )
                      : Column(
                          children: [
                            if (state.roomInfo != null)
                              LiveInfoView(
                                info: state.roomInfo!,
                                anchor: state.anchorInfo,
                                onFollow: () => ref
                                    .read(liveRoomControllerProvider(roomId).notifier)
                                    .toggleFollow(),
                              ),
                            const Divider(height: 1),
                            Expanded(
                              child: LiveDanmakuView(
                                history: state.danmakuHistory,
                              ),
                            ),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
