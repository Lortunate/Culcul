import 'package:culcul/providers/live/live_room_controller.dart';
import 'package:culcul/providers/live/live_room_state.dart';
import 'package:culcul/ui/pages/live/widgets/live_bottom_bar.dart';
import 'package:culcul/ui/pages/live/widgets/live_danmaku_view.dart';
import 'package:culcul/ui/pages/live/widgets/live_header.dart';
import 'package:culcul/ui/pages/live/widgets/live_player_view.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveRoomPage extends HookConsumerWidget {
  final int roomId;

  const LiveRoomPage({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(liveRoomControllerProvider(roomId));
    final theme = Theme.of(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Header
            LiveHeader(
              roomInfo: state.roomInfo,
              anchorInfo: state.anchorInfo,
              liveAnchorInfo: state.liveAnchorInfo,
              guardList: state.guardList,
              goldRank: state.goldRank,
              onFollow: () => ref
                  .read(liveRoomControllerProvider(roomId).notifier)
                  .toggleFollow(),
            ),

            // 2. Video Player
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black,
                child: LivePlayerView(roomId: roomId),
              ),
            ),

            // 3. Room Info & Danmaku
            Expanded(
              child: _buildRoomContent(context, ref, state),
            ),

            // 4. Bottom Input Bar
            LiveBottomBar(
              onTapInput: () => _showInputSheet(context, theme, ref, roomId),
              onGift: () {},
              onShare: () {},
              onLike: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomContent(
    BuildContext context,
    WidgetRef ref,
    LiveRoomState state,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: AppErrorWidget(
          error: state.error,
          onRetry: () =>
              ref.read(liveRoomControllerProvider(roomId).notifier).refresh(),
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
              LiveDanmakuView(
                history: state.danmakuHistory,
              ),
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
                        colors: [
                          Colors.black,
                          Colors.black.withOpacity(0),
                        ],
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

  void _showInputSheet(
    BuildContext context,
    ThemeData theme,
    WidgetRef ref,
    int roomId,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A), // Dark background
      builder: (context) => _DanmakuInputSheet(roomId: roomId),
    );
  }
}

class _DanmakuInputSheet extends HookConsumerWidget {
  final int roomId;

  const _DanmakuInputSheet({required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 12,
        right: 12,
        top: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Theme.of(context).colorScheme.primary,
                    decoration: InputDecoration(
                      hintText: '发个弹幕呗~',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10, // Center vertically
                      ),
                      isDense: true,
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        ref
                            .read(liveRoomControllerProvider(roomId).notifier)
                            .sendDanmaku(value);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.send_rounded, size: 20, color: Colors.white),
                  onPressed: () {
                    if (controller.text.trim().isNotEmpty) {
                      ref
                          .read(liveRoomControllerProvider(roomId).notifier)
                          .sendDanmaku(controller.text);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
