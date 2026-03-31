import 'package:culcul/features/video/models/video_model.dart';
import 'package:culcul/features/home/presentation/widgets/video_more_bottom_sheet.dart';
import 'package:culcul/ui/widgets/app_card_container.dart';
import 'package:culcul/ui/widgets/app_overlay_tag.dart';
import 'package:culcul/ui/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';

part 'video_card/content.dart';
part 'video_card/footer.dart';
part 'video_card/thumbnail.dart';

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

  Future<void> _showMoreSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => VideoMoreBottomSheet(
        bvid: bvid ?? video?.bvid,
        coverUrl: coverUrl ?? video?.pic,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = _VideoCardContent(
      title: _title,
      author: _author,
      description: _description,
      showAuthor: showAuthor,
    );

    return AppCardContainer(
      onTap: onTap,
      onLongPress: () => _showMoreSheet(context),
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
    );
  }
}

class VideoCardContent extends StatelessWidget {
  final String title;
  final String author;
  final String? description;
  final bool showAuthor;
  final List<Widget> extra;

  const VideoCardContent({
    super.key,
    required this.title,
    required this.author,
    this.description,
    this.showAuthor = true,
    this.extra = const [],
  });

  @override
  Widget build(BuildContext context) {
    return _VideoCardContent(
      title: title,
      author: author,
      description: description,
      showAuthor: showAuthor,
      extra: extra,
    );
  }
}
