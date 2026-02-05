import 'package:culcul/data/models/index.dart';
import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:culcul/ui/widgets/app_tag.dart';
import 'package:culcul/ui/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoCard extends HookConsumerWidget {
  final VideoModel video;
  final VoidCallback? onTap;

  const VideoCard({super.key, required this.video, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VideoCardContainer(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _VideoThumbnail(video: video),
          _VideoContent(video: video),
        ],
      ),
    );
  }
}

class VideoCardContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double borderRadius;

  const VideoCardContainer({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: theme.brightness == Brightness.dark ? 0.2 : 0.05,
              ),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: AppClickable(
          onTap: onTap,
          haptic: true,
          borderRadius: BorderRadius.circular(borderRadius),
          child: child,
        ),
      ),
    );
  }
}

class _VideoThumbnail extends StatelessWidget {
  final VideoModel video;

  const _VideoThumbnail({required this.video});

  @override
  Widget build(BuildContext context) {
    final cacheWidth =
        (MediaQuery.sizeOf(context).width /
                2 *
                MediaQuery.devicePixelRatioOf(context))
            .toInt();

    return VideoThumbnail(
      url: video.pic,
      duration: video.duration,
      viewCount: video.stat.view,
      danmakuCount: video.stat.danmaku,
      borderRadius: 12,
      memCacheWidth: cacheWidth,
    );
  }
}

class _VideoContent extends StatelessWidget {
  final VideoModel video;

  const _VideoContent({required this.video});

  @override
  Widget build(BuildContext context) {
    return VideoCardContent(
      title: video.title,
      author: video.owner.name,
      reason: video.rcmd_reason,
    );
  }
}

class VideoCardContent extends StatelessWidget {
  final String title;
  final String author;
  final String? reason;
  final List<Widget>? extra;

  const VideoCardContent({
    super.key,
    required this.title,
    required this.author,
    this.reason,
    this.extra,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.25,
                fontSize: 13,
                color: colorScheme.onSurface,
              ),
            ),
            if (reason != null && reason!.isNotEmpty) ...[
              const SizedBox(height: 6),
              AppTag(
                text: reason!,
                color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                textColor: colorScheme.primary,
                fontSize: 10,
              ),
            ],
            if (extra != null) ...extra!,
            const Spacer(),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Text(
                    author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                ),
                Icon(
                  Icons.more_vert_rounded,
                  size: 14,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
