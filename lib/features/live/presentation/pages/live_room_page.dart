import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/live/state/live_room_view_model.dart';
import 'package:culcul/features/live/presentation/widgets/live_header.dart';
import 'package:culcul/features/live/presentation/widgets/live_input_sheet.dart';
import 'package:culcul/features/live/presentation/widgets/live_player_view.dart';
import 'package:culcul/features/live/presentation/widgets/live_room_content.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveRoomPage extends HookConsumerWidget {
  final int roomId;
  final VoidCallback onLogin;

  const LiveRoomPage({super.key, required this.roomId, required this.onLogin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final provider = liveRoomControllerProvider(roomId);
    final headerData = ref.watch(
      provider.select(
        (state) => (
          roomInfo: state.roomInfo,
          anchorInfo: state.anchorInfo,
          anchorLevel: state.anchorLevel,
          guardList: state.guardList,
          goldRank: state.goldRank,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: colorScheme.scrim,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Column(
            children: [
              LiveHeader(
                roomInfo: headerData.roomInfo,
                anchorInfo: headerData.anchorInfo,
                anchorLevel: headerData.anchorLevel,
                guardList: headerData.guardList,
                goldRank: headerData.goldRank,
                onLogin: onLogin,
                onFollow: () async {
                  final session = ref.read(currentUserProvider);
                  if (session?.isLoggedIn != true) {
                    onLogin();
                    return;
                  }

                  await ref
                      .read(liveRoomControllerProvider(roomId).notifier)
                      .toggleFollow();
                },
              ),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ColoredBox(
                  color: colorScheme.scrim,
                  child: LivePlayerView(roomId: roomId),
                ),
              ),
              Expanded(child: LiveRoomContent(roomId: roomId)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: colorScheme.scrim,
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.onPrimary.withValues(alpha: 0.04),
                      width: 0.8,
                    ),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            final colorScheme = Theme.of(context).colorScheme;
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: colorScheme.surfaceContainerHighest,
                              builder: (context) => LiveInputSheet(roomId: roomId),
                            );
                          },
                          child: Container(
                            height: 34,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              color: colorScheme.onPrimary.withValues(alpha: 0.09),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    t.live.danmaku.support_hint,
                                    style: TextStyle(
                                      color: colorScheme.onPrimary.withValues(
                                        alpha: 0.42,
                                      ),
                                      fontSize: 13,
                                      height: 1.1,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
