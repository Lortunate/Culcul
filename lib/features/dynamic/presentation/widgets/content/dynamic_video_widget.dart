import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/features/dynamic/presentation/widgets/utils/dynamic_navigation.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_content_surface.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class DynamicVideoWidget extends StatelessWidget {
  final DynamicVideoContent video;

  const DynamicVideoWidget({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DynamicContentSurface(
      borderRadius: BorderRadius.circular(6),
      onTap: () => DynamicNavigation.open(
        context,
        fallbackBvid: video.bvid,
        fallbackAid: video.aid,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                ),
                child: AppNetworkImage(
                  url: video.cover,
                  width: 140,
                  height: 88,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: colorScheme.scrim.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    video.duration,
                    style: TextStyle(color: colorScheme.onPrimary, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    video.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.play_circle_outline,
                        size: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        video.playCount,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 11,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.list_alt, size: 14, color: colorScheme.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Text(
                        video.danmakuCount,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 11,
                          color: colorScheme.onSurfaceVariant,
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
