import 'package:culcul/providers/live/live_room_controller.dart';
import 'package:culcul/providers/live/live_room_state.dart';
import 'package:culcul/ui/pages/live/widgets/live_danmaku_view.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveRoomContent extends ConsumerWidget {
  final int roomId;
  final LiveRoomState state;

  const LiveRoomContent({super.key, required this.roomId, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: AppErrorWidget(
          error: state.error,
          onRetry:
              () =>
                  ref
                      .read(liveRoomControllerProvider(roomId).notifier)
                      .refresh(),
        ),
      );
    }

    return Column(
      children: [
        // Room Title
        if (state.roomInfo != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              state.roomInfo!.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19, // Larger title
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

        // Danmaku List
        Expanded(
          child: Stack(
            children: [
              LiveDanmakuView(history: state.danmakuHistory),
              // Gradient Overlay
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 32,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.black.withValues(alpha: 0)],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
