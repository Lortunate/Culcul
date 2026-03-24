import 'package:culcul/data/models/video/video_model.dart';
import 'package:culcul/features/home/presentation/widgets/video_more_bottom_sheet.dart';
import 'package:culcul/ui/widgets/app_card_container.dart';
import 'package:culcul/ui/widgets/app_tag.dart';
import 'package:culcul/ui/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';

part 'video_card/content.dart';
part 'video_card/footer.dart';
part 'video_card/thumbnail.dart';

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

  Future<void> _showMoreSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => VideoMoreBottomSheet(video: video),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      onTap: onTap,
      onLongPress: () => _showMoreSheet(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _VideoCardThumbnail(video: video),
          _VideoCardContent(
            title: video.title,
            author: video.owner.name,
            reason: video.rcmdReason,
            description: showDescription ? video.desc : null,
            showAuthor: showAuthor,
            extra: null,
          ),
        ],
      ),
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
    return _VideoCardContent(
      title: title,
      author: author,
      reason: reason,
      description: description,
      showAuthor: showAuthor,
      extra: extra,
    );
  }
}
