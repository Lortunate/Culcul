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
    final colorScheme = Theme.of(context).colorScheme;
    final provider = liveRoomControllerProvider(roomId);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    return Scaffold(
      backgroundColor: colorScheme.scrim,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Column(
            children: [
              LiveHeader(
                roomInfo: state.roomInfo,
                anchorInfo: state.anchorInfo,
                liveAnchorInfo: state.liveAnchorInfo,
                guardList: state.guardList,
                goldRank: state.goldRank,
                onFollow: notifier.toggleFollow,
              ),
              _LivePlayerSection(roomId: roomId),
              Expanded(
                child: LiveRoomContent(roomId: roomId, state: state),
              ),
              LiveBottomBar(
                onTapInput: () => _showInputSheet(context),
                onGift: () {},
                onShare: () {},
                onLike: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInputSheet(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorScheme.surfaceContainerHighest,
      builder: (context) => LiveInputSheet(roomId: roomId),
    );
  }
}

class _LivePlayerSection extends StatelessWidget {
  const _LivePlayerSection({required this.roomId});

  final int roomId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ColoredBox(
        color: colorScheme.scrim,
        child: LivePlayerView(roomId: roomId),
      ),
    );
  }
}
