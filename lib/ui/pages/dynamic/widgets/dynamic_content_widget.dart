import 'package:culcul/domain/entities/dynamic_post.dart';
import 'package:culcul/ui/pages/dynamic/topic_detail_page.dart';
import 'package:culcul/ui/pages/dynamic/widgets/dynamic_forward_widget.dart';
import 'package:culcul/ui/widgets/bilibili_emoji_text.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class DynamicContentWidget extends StatelessWidget {
  final DynamicPost post;

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
          _buildImages(context, post.images!),
        if (post.video != null) _buildVideo(context, post.video!),
        if (post.linkCard != null) _buildLinkCard(context, post.linkCard!),
        if (post.additional != null) _buildAdditional(context, post.additional!),
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_fire_department_rounded, 
                      size: 14, 
                      color: Theme.of(context).colorScheme.primary
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
      return _buildVote(context, additional);
    } else if (additional.type == 'ADDITIONAL_TYPE_GOODS') {
      return _buildGoods(context, additional);
    } else if (additional.type == 'ADDITIONAL_TYPE_RESERVE') {
      return _buildReserve(context, additional);
    } else if (additional.type == 'ADDITIONAL_TYPE_UGC') {
      return _buildUgc(context, additional);
    } else if (additional.type == 'ADDITIONAL_TYPE_COMMON') {
      return _buildCommon(context, additional);
    }
    return const SizedBox.shrink();
  }

  Widget _buildVote(BuildContext context, DynamicAdditional additional) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            additional.title ?? '投票',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text('${additional.voteJoinNum}人参与 · ${additional.voteChoiceCnt}个选项'),
          // Render choices if available, but we only have summary now
        ],
      ),
    );
  }

  Widget _buildGoods(BuildContext context, DynamicAdditional additional) {
    if (additional.goodsItems == null || additional.goodsItems!.isEmpty) return const SizedBox.shrink();
    
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
         color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
         borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (additional.headText != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(additional.headText!, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
           ...additional.goodsItems!.map((item) => ListTile(
             leading: AppNetworkImage(url: item.cover, width: 50, height: 50, fit: BoxFit.cover),
             title: Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis),
             subtitle: Text(item.price, style: const TextStyle(color: Colors.red)),
           )),
        ],
      ),
    );
  }

  Widget _buildReserve(BuildContext context, DynamicAdditional additional) {
     return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(additional.title ?? '预约', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                 const SizedBox(height: 4),
                 Text(
                   '${additional.desc1 ?? ''}  ${additional.desc2 ?? ''}',
                   style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                 ),
               ],
             ),
           ),
           ElevatedButton(
             onPressed: () {},
             style: ElevatedButton.styleFrom(
               backgroundColor: Theme.of(context).colorScheme.primary,
               foregroundColor: Colors.white,
             ),
             child: Text(additional.state == 1 ? '已预约' : '预约'),
           ),
        ],
      ),
    );
  }

  Widget _buildUgc(BuildContext context, DynamicAdditional additional) {
     return Container(
      margin: const EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      ),
      child: Row(
        children: [
           ClipRRect(
             borderRadius: const BorderRadius.only(
               topLeft: Radius.circular(6),
               bottomLeft: Radius.circular(6),
             ),
             child: AppNetworkImage(
               url: additional.cover ?? '',
               width: 140,
               height: 88,
               fit: BoxFit.cover,
             ),
           ),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.all(10.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     additional.title ?? '',
                     maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                     style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                   ),
                   const SizedBox(height: 16),
                   Text(
                     additional.desc2 ?? '',
                     style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
                   ),
                 ],
               ),
             ),
           ),
        ],
      ),
    );
  }

  Widget _buildCommon(BuildContext context, DynamicAdditional additional) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      ),
      child: Row(
        children: [
           ClipRRect(
             borderRadius: const BorderRadius.only(
               topLeft: Radius.circular(6),
               bottomLeft: Radius.circular(6),
             ),
             child: AppNetworkImage(
               url: additional.cover ?? '',
               width: 88,
               height: 88,
               fit: BoxFit.cover,
             ),
           ),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.all(10.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     additional.title ?? '',
                     maxLines: 1,
                     overflow: TextOverflow.ellipsis,
                     style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                   ),
                   const SizedBox(height: 4),
                   Text(
                     additional.desc1 ?? '',
                     maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                   ),
                 ],
               ),
             ),
           ),
        ],
      ),
    );
  }

  Widget _buildImages(BuildContext context, List<String> images) {
    if (images.length == 1) {
      return Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 240,
              maxWidth: 240,
            ),
            child: AppNetworkImage(
              url: images.first,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
    
    final size = (MediaQuery.of(context).size.width - 32 - 8) / 3;
    
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 1.0,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: AppNetworkImage(
              url: images[index], 
              fit: BoxFit.cover,
              width: size,
              height: size,
            ),
          );
        },
      ),
    );
  }

  Widget _buildVideo(BuildContext context, DynamicVideoContent video) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () {},
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        video.duration,
                        style: const TextStyle(color: Colors.white, fontSize: 10),
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
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
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
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            video.playCount,
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.list_alt,
                            size: 14,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            video.danmakuCount,
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
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
        ),
      ),
    );
  }

  Widget _buildLinkCard(BuildContext context, DynamicLinkCard card) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () {
            // TODO: Open URL
          },
          child: Row(
            children: [
               ClipRRect(
                 borderRadius: const BorderRadius.only(
                   topLeft: Radius.circular(6),
                   bottomLeft: Radius.circular(6),
                 ),
                 child: AppNetworkImage(
                   url: card.cover,
                   width: 88,
                   height: 88,
                   fit: BoxFit.cover,
                 ),
               ),
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         card.title,
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                         style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                       ),
                       if (card.desc != null && card.desc!.isNotEmpty) ...[
                         const SizedBox(height: 4),
                         Text(
                           card.desc!,
                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                         ),
                       ],
                     ],
                   ),
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
