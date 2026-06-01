import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_thumbnail.dart';
import 'package:culcul/ui/theme/culcul_colors.dart';
import 'package:culcul/ui/widgets/cards/app_card_container.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final VideoModel? video;
  final String? bvid;
  final String? title;
  final String? coverUrl;
  final String? author;
  final String? description;
  final int? duration;
  final int? viewCount;
  final int? danmakuCount;
  final String? reason;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool showAuthor;
  final bool showDescription;

  const VideoCard({
    super.key,
    this.video,
    this.bvid,
    this.title,
    this.coverUrl,
    this.author,
    this.description,
    this.duration,
    this.viewCount,
    this.danmakuCount,
    this.reason,
    this.onTap,
    this.onLongPress,
    this.showAuthor = true,
    this.showDescription = false,
  }) : assert(
         video != null ||
             (title != null &&
                 coverUrl != null &&
                 author != null &&
                 duration != null &&
                 viewCount != null &&
                 danmakuCount != null),
       );

  String get _title => video?.title ?? title!;
  String get _author => video?.owner.name ?? author!;
  String? get _description => showDescription ? (video?.desc ?? description) : null;
  String get _coverUrl => video?.pic ?? coverUrl!;
  int get _duration => video?.duration ?? duration!;
  int get _viewCount => video?.stat.view ?? viewCount!;
  int get _danmakuCount => video?.stat.danmaku ?? danmakuCount!;
  String? get _reason => video?.rcmdReason ?? reason;

  @override
  Widget build(BuildContext context) {
    final content = _VideoCardContent(
      title: _title,
      author: _author,
      description: _description,
      showAuthor: showAuthor,
    );

    return RepaintBoundary(
      child: AppCardContainer(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _VideoCardThumbnail(
              coverUrl: _coverUrl,
              duration: _duration,
              viewCount: _viewCount,
              danmakuCount: _danmakuCount,
              reason: _reason,
            ),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}

class _VideoCardThumbnail extends StatelessWidget {
  final String coverUrl;
  final int duration;
  final int viewCount;
  final int danmakuCount;
  final String? reason;

  const _VideoCardThumbnail({
    required this.coverUrl,
    required this.duration,
    required this.viewCount,
    required this.danmakuCount,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final cacheWidth = (size.width / 2 * dpr).toInt();

    return Stack(
      children: [
        VideoThumbnail(
          url: coverUrl,
          duration: duration,
          viewCount: viewCount,
          danmakuCount: danmakuCount,
          borderRadius: 0,
          memCacheWidth: cacheWidth,
        ),
        if (reason case final reasonText? when reasonText.isNotEmpty)
          Positioned(
            top: 8,
            right: 8,
            child: Builder(
              builder: (context) {
                final semanticColors = context.semanticColors;

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: semanticColors.overlayBackground,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: semanticColors.overlayBorder, width: 0.5),
                  ),
                  child: Text(
                    reasonText,
                    style: TextStyle(
                      color: semanticColors.overlayForeground,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _VideoCardContent extends StatelessWidget {
  final String title;
  final String author;
  final String? description;
  final bool showAuthor;

  const _VideoCardContent({
    required this.title,
    required this.author,
    this.description,
    this.showAuthor = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8),
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
          if (description case final descriptionText?
              when descriptionText.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              descriptionText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 11,
              ),
            ),
          ],
          const Spacer(),
          if (showAuthor)
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
    );
  }
}
