import 'package:culcul/shared/utils/format_utils.dart';
import 'package:culcul/core/contracts/live_room_summary_contract.dart';
import 'package:culcul/shared/widgets/app_avatar.dart';
import 'package:culcul/shared/widgets/app_card_container.dart';
import 'package:culcul/shared/widgets/app_min_lines_text.dart';
import 'package:culcul/shared/widgets/app_network_image.dart';
import 'package:culcul/shared/widgets/app_overlay_tag.dart';
import 'package:flutter/material.dart';

class LiveRoomCard extends StatelessWidget {
  final LiveRoomSummary room;
  final VoidCallback? onTap;

  const LiveRoomCard({super.key, required this.room, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return AppCardContainer(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LiveRoomCover(room: room, colorScheme: colorScheme),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppMinLinesText(
                    room.title,
                    minLines: 2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      fontSize: 12.5,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      AppAvatar(
                        url: room.face,
                        size: 16,
                        border: Border.all(style: BorderStyle.none),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          room.uname,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveRoomCover extends StatelessWidget {
  final LiveRoomSummary room;
  final ColorScheme colorScheme;

  const _LiveRoomCover({required this.room, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: AppNetworkImage(url: room.cover, fit: BoxFit.cover),
        ),
        const Positioned.fill(child: _LiveRoomCoverGradient()),
        Positioned(right: 6, top: 6, child: AppOverlayTag(text: room.areaName)),
        Positioned(
          left: 8,
          bottom: 6,
          child: _LiveRoomOnlineCount(online: room.online, colorScheme: colorScheme),
        ),
      ],
    );
  }
}

class _LiveRoomCoverGradient extends StatelessWidget {
  const _LiveRoomCoverGradient();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, colorScheme.scrim.withValues(alpha: 0.6)],
          stops: const [0.6, 1.0],
        ),
      ),
    );
  }
}

class _LiveRoomOnlineCount extends StatelessWidget {
  final int online;
  final ColorScheme colorScheme;

  const _LiveRoomOnlineCount({required this.online, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: colorScheme.primary.withValues(alpha: 0.5), blurRadius: 4),
            ],
          ),
        ),
        const SizedBox(width: 4),
        Text(
          FormatUtils.formatNumber(online),
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(
                offset: const Offset(0, 1),
                blurRadius: 2,
                color: theme.colorScheme.shadow.withValues(alpha: 0.45),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
