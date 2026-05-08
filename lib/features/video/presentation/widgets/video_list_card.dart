import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/ui/widgets/cards/app_card_container.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/ui/widgets/text/icon_text.dart';
import 'package:culcul/features/video/presentation/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';

part 'video_list_card/body.dart';
part 'video_list_card/content.dart';
part 'video_list_card/media.dart';

class VideoListCard extends StatelessWidget {
  final String coverUrl;
  final String title;
  final int? duration;
  final int? viewCount;
  final int? danmakuCount;
  final Widget? author;
  final Widget? badge;
  final List<Widget>? stats;
  final VoidCallback? onTap;
  final double thumbnailWidth;
  final double aspectRatio;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Widget? overlay;
  final Widget? middleContent;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onLongPress;
  final bool showDefaultStats;
  final bool flat;

  const VideoListCard({
    super.key,
    required this.coverUrl,
    required this.title,
    this.duration,
    this.viewCount,
    this.danmakuCount,
    this.author,
    this.badge,
    this.stats,
    this.onTap,
    this.thumbnailWidth = 160,
    this.aspectRatio = 16 / 10,
    this.height = 100,
    this.padding = const EdgeInsets.all(12),
    this.overlay,
    this.middleContent,
    this.leading,
    this.trailing,
    this.onLongPress,
    this.showDefaultStats = false,
    this.flat = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = _VideoListCardBody(
      coverUrl: coverUrl,
      title: title,
      duration: duration,
      viewCount: viewCount,
      danmakuCount: danmakuCount,
      author: author,
      badge: badge,
      stats: stats,
      thumbnailWidth: thumbnailWidth,
      aspectRatio: aspectRatio,
      height: height,
      padding: padding,
      overlay: overlay,
      middleContent: middleContent,
      leading: leading,
      trailing: trailing,
      showDefaultStats: showDefaultStats,
    );

    if (flat) {
      return AppClickable(onTap: onTap, onLongPress: onLongPress, child: content);
    }

    return AppCardContainer(onTap: onTap, onLongPress: onLongPress, child: content);
  }
}
