import 'package:culcul/data/models/video/video_model.dart';
import 'package:culcul/features/home/presentation/widgets/video_more_bottom_sheet.dart';
import 'package:culcul/ui/widgets/app_card_container.dart';
import 'package:culcul/ui/widgets/app_tag.dart';
import 'package:culcul/ui/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final VideoModel video;
  final VoidCallback? onTap;
  final bool showAuthor;
  final bool showDescription;

  const VideoCard({
    super.key,
    required this.video,
    this.onTap,
    this.showAuthor = true,
    this.showDescription = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      onTap: onTap,
      onLongPress: () => showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => VideoMoreBottomSheet(video: video),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _VideoThumbnail(video: video),
          VideoCardContent(
            title: video.title,
            author: video.owner.name,
            reason: video.rcmdReason,
            description: showDescription ? video.desc : null,
            showAuthor: showAuthor,
          ),
        ],
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
        (MediaQuery.sizeOf(context).width / 2 * MediaQuery.devicePixelRatioOf(context))
            .toInt();

    return VideoThumbnail(
      url: video.pic,
      duration: video.duration,
      viewCount: video.stat.view,
      danmakuCount: video.stat.danmaku,
      borderRadius: 0,
      memCacheWidth: cacheWidth,
    );
  }
}

class VideoCardContent extends StatelessWidget {
  final String title;
  final String author;
  final String? reason;
  final String? description;
  final bool showAuthor;
  final List<Widget>? extra;

  const VideoCardContent({
    super.key,
    required this.title,
    required this.author,
    this.reason,
    this.description,
    this.showAuthor = true,
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
            if (reason?.isNotEmpty == true) ...[
              const SizedBox(height: 6),
              AppTag(
                text: reason!,
                color: colorScheme.primaryContainer.withValues(alpha: 0.188),
                textColor: colorScheme.primary,
                fontSize: 10,
              ),
            ],
            if (description?.isNotEmpty == true) ...[
              const SizedBox(height: 4),
              Text(
                description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 11,
                ),
              ),
            ],
            if (extra != null) ...extra!,

            const Spacer(),
            if (showAuthor) ...[
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
          ],
        ),
      ),
    );
  }
}
