import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/data/models/live/live_room_model.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class LiveRoomCard extends StatelessWidget {
  final LiveRoomModel room;
  final VoidCallback? onTap;

  const LiveRoomCard({
    super.key,
    required this.room,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: colorScheme.surfaceContainerLow, // Added subtle background
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Slightly more rounded
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image Area
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: AppNetworkImage(
                    url: room.cover,
                    fit: BoxFit.cover,
                  ),
                ),
                
                // Gradient Overlay
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 48,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                        ],
                        stops: const [0.0, 0.9],
                      ),
                    ),
                  ),
                ),

                // Top Right Area Tag
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      room.areaName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                  ),
                ),

                // Bottom Left: Online Count
                Positioned(
                  left: 8,
                  bottom: 6,
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF6699), // Bilibili Pinkish
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        FormatUtils.formatNumber(room.online),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 2,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Title
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4), // Increased padding
              child: Text(
                room.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  height: 1.25,
                  fontSize: 14, // Increased font size slightly
                  color: colorScheme.onSurface,
                ),
              ),
            ),

            // User Info Row
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 10), // Increased padding
              child: Row(
                children: [
                  AppAvatar(
                    url: room.face,
                    size: 20, // Slightly smaller to balance with text
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      room.uname,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
