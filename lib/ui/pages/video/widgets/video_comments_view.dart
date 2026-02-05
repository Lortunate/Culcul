import 'package:culcul/core/router/router.dart';
import 'package:culcul/providers/video/video_detail_controller.dart';
import 'package:culcul/providers/video/video_detail_state.dart';
import 'package:culcul/ui/pages/video/widgets/comment_item.dart';
import 'package:culcul/data/models/index.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class VideoCommentsView extends StatelessWidget {
  final String bvid;
  final VideoDetailState state;
  final VideoDetailController notifier;

  const VideoCommentsView({
    super.key,
    required this.bvid,
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final upperMid = state.videoDetail?.owner.mid;

    if (state.isCommentLoading && state.comments.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.comments.isEmpty && !state.isCommentLoading) {
      return Center(
        child: GestureDetector(
          onTap: notifier.refreshComments,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.video.comment_empty,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 8),
              Icon(
                Icons.refresh,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
      );
    }

    return EasyRefresh(
      onRefresh: notifier.refreshComments,
      onLoad: state.hasMoreComments ? notifier.loadMoreComments : null,
      header: const ClassicHeader(
        dragText: '下拉刷新',
        armedText: '释放刷新',
        readyText: '正在刷新...',
        processingText: '正在刷新...',
        processedText: '刷新完成',
        noMoreText: '没有更多了',
        failedText: '刷新失败',
        messageText: '最后更新于 %T',
      ),
      footer: const ClassicFooter(
        dragText: '上拉加载',
        armedText: '释放加载',
        readyText: '正在加载...',
        processingText: '正在加载...',
        processedText: '加载完成',
        noMoreText: '没有更多了',
        failedText: '加载失败',
        messageText: '最后更新于 %T',
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemCount: state.comments.length,
        itemBuilder: (context, index) {
          final comment = state.comments[index];
          return CommentItemWidget(
            item: comment,
            upperMid: upperMid,
            onLike: () {
              notifier.toggleCommentLike(
                comment.oid,
                comment.rpid,
                comment.action == 1,
              );
            },
            onDislike: () {
              notifier.toggleCommentDislike(comment.oid, comment.rpid);
            },
            onReply: () {
              _showReplySheet(context, comment, notifier);
            },
            onTapReplies: () {
              CommentReplyRoute(
                bvid: bvid,
                oid: state.videoDetail!.aid,
                rootId: comment.rpid,
                $extra: {
                  'comment': comment,
                  'upperMid': upperMid,
                },
              ).push(context);
            },
          );
        },
      ),
    );
  }

  void _showReplySheet(
    BuildContext context,
    CommentItem comment,
    VideoDetailController notifier,
  ) {
    final theme = Theme.of(context);
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    '回复 @${comment.member.uname}',
                    style: theme.textTheme.titleMedium,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      final text = controller.text.trim();
                      if (text.isNotEmpty) {
                        notifier.addReply(
                          comment.oid,
                          comment.root == 0 ? comment.rpid : comment.root,
                          comment.rpid,
                          text,
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
              TextField(
                controller: controller,
                autofocus: true,
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: '发一条友善的评论',
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
