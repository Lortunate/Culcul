import 'package:culcul/features/live/controllers/live_room_controller.dart';
import 'package:culcul/features/live/presentation/widgets/live_bottom_bar.dart';
import 'package:culcul/features/live/presentation/widgets/live_header.dart';
import 'package:culcul/features/live/presentation/widgets/live_input_sheet.dart';
import 'package:culcul/features/live/presentation/widgets/live_player_view.dart';
import 'package:culcul/features/live/presentation/widgets/live_room_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveRoomPage extends HookConsumerWidget {
  final int roomId;

  const LiveRoomPage({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(liveRoomControllerProvider(roomId));

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
              onFollow:
                  () =>
                      ref
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
            Expanded(child: LiveRoomContent(roomId: roomId, state: state)),

            // 4. Bottom Input Bar
            LiveBottomBar(
              onTapInput: () => _showInputSheet(context, roomId),
              onGift: () {},
              onShare: () {},
              onLike: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _showInputSheet(BuildContext context, int roomId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A), // Dark background
      builder: (context) => LiveInputSheet(roomId: roomId),
    );
  }
}
