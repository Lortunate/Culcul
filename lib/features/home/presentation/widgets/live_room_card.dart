import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/models/live_room_summary_contract.dart';
import 'package:culcul/core/theme/culcul_colors.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:culcul/ui/widgets/cards/app_card_container.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:flutter/material.dart';

class LiveRoomCard extends StatelessWidget {
  final LiveRoomSummary room;
  final VoidCallback? onTap;

  const LiveRoomCard({super.key, required this.room, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final semanticColors = context.semanticColors;
    final textTheme = theme.textTheme;
    final titleStyle = textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.w500,
      height: 1.2,
      fontSize: 12.5,
      color: colorScheme.onSurface,
    );

    return RepaintBoundary(
      child: AppCardContainer(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: AppNetworkImage(url: room.cover),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          colorScheme.scrim.withValues(alpha: 0.6),
                        ],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: semanticColors.overlayBackground,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: semanticColors.overlayBorder, width: 0.5),
                    ),
                    child: Text(
                      room.areaName,
                      style: TextStyle(
                        color: semanticColors.overlayForeground,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 6,
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.primary.withValues(alpha: 0.5),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        FormatUtils.formatNumber(room.online),
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          shadows: [
                            Shadow(
                              offset: const Offset(0, 1),
                              blurRadius: 2,
                              color: colorScheme.shadow.withValues(alpha: 0.45),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height:
                          ((titleStyle?.fontSize ?? 12.5) * (titleStyle?.height ?? 1.2)) *
                          2,
                      child: Text(
                        room.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: titleStyle,
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
      ),
    );
  }
}
