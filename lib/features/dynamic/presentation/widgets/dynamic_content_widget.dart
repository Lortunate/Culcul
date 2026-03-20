import 'package:culcul/data/models/dynamic/dynamic_extension.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/data/models/dynamic/dynamic_view_models.dart';
import 'package:culcul/features/dynamic/presentation/topic_detail_page.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_common_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_goods_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_images_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_link_card_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_reserve_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_ugc_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_video_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_vote_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_forward_widget.dart';
import 'package:culcul/ui/widgets/bilibili_emoji_text.dart';
import 'package:flutter/material.dart';

class DynamicContentWidget extends StatelessWidget {
  final DynamicItem post;

  const DynamicContentWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.description != null && post.description!.isNotEmpty) ...[
          BilibiliEmojiText(
            text: post.description!,
            emojiMap: const {},
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.5, fontSize: 15),
            selectable: true,
          ),
          const SizedBox(height: 8),
        ],
        if (post.images != null && post.images!.isNotEmpty)
          DynamicImagesWidget(images: post.images!),
        if (post.videoContent != null)
          DynamicVideoWidget(video: post.videoContent!),
        if (post.linkCard != null)
          DynamicLinkCardWidget(card: post.linkCard!),
        if (post.additional != null)
          _buildAdditional(context, post.additional!),
        if (post.orig != null) DynamicForwardWidget(post: post.orig!),
        if (post.topicName != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                if (post.topicId != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TopicDetailPage(
                        topicId: post.topicId!,
                        topicName: post.topicName!,
                      ),
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_fire_department_rounded,
                      size: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      post.topicName!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAdditional(BuildContext context, DynamicAdditional additional) {
    if (additional.type == 'ADDITIONAL_TYPE_VOTE') {
      return DynamicVoteWidget(additional: additional);
    } else if (additional.type == 'ADDITIONAL_TYPE_GOODS') {
      return DynamicGoodsWidget(additional: additional);
    } else if (additional.type == 'ADDITIONAL_TYPE_RESERVE') {
      return DynamicReserveWidget(additional: additional);
    } else if (additional.type == 'ADDITIONAL_TYPE_UGC') {
      return DynamicUgcWidget(additional: additional);
    } else if (additional.type == 'ADDITIONAL_TYPE_COMMON') {
      return DynamicCommonWidget(additional: additional);
    }
    return const SizedBox.shrink();
  }
}
