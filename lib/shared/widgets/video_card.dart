import 'package:cilixili/core/theme/app_colors.dart';
import 'package:cilixili/core/utils/format_utils.dart';
import 'package:cilixili/data/models/home/index.dart';
import 'package:cilixili/shared/widgets/video_thumbnail.dart';
import 'package:cilixili/shared/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoCard extends HookConsumerWidget {
  final VideoModel video;
  final VoidCallback? onTap;

  const VideoCard({super.key, required this.video, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkCardBackground
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withOpacity(0.2) : AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _VideoThumbnail(video: video),
            _VideoContent(video: video),
          ],
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
    return Stack(
      children: [
        VideoThumbnail(
          url: video.pic,
          duration: video.duration,
          borderRadius: 10,
        ),
        _ThumbnailStats(video: video),
      ],
    );
  }
}

class _ThumbnailStats extends StatelessWidget {
  final VideoModel video;
  const _ThumbnailStats({required this.video});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      color: Colors.white,
      fontSize: 11,
      fontWeight: FontWeight.w400,
    );

    return Positioned(
      left: 8,
      bottom: 6,
      right: 50,
      child: Row(
        children: [
          const Icon(Icons.play_circle_outline, size: 13, color: Colors.white),
          const SizedBox(width: 4),
          Text(FormatUtils.formatNumber(video.stat.view), style: style),
          const SizedBox(width: 12),
          const Icon(Icons.list_alt_outlined, size: 13, color: Colors.white),
          const SizedBox(width: 4),
          Text(FormatUtils.formatNumber(video.stat.danmaku), style: style),
        ],
      ),
    );
  }
}

class _VideoContent extends StatelessWidget {
  final VideoModel video;
  const _VideoContent({required this.video});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              height: 1.4,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              if (video.rcmd_reason.isNotEmpty) ...[
                AppTag(
                  text: video.rcmd_reason,
                  color: AppColors.reasonBg,
                  textColor: AppColors.reasonText,
                  fontSize: 9,
                ),
                const SizedBox(width: 6),
              ],
              Expanded(
                child: Text(
                  video.owner.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelSmall,
                ),
              ),
              Icon(
                Icons.more_vert_rounded,
                size: 14,
                color: theme.iconTheme.color?.withOpacity(0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
