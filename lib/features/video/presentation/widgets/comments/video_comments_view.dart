import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/video/controllers/video_detail_controller.dart';
import 'package:culcul/features/video/presentation/widgets/comments/comment_item.dart';
import 'package:culcul/features/video/presentation/widgets/comments/comment_reply_sheet.dart';
import 'package:culcul/ui/widgets/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoCommentsView extends ConsumerWidget {
  final String bvid;

  const VideoCommentsView({
    super.key,
    required this.bvid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoDetailControllerProvider(bvid));
    final notifier = ref.read(videoDetailControllerProvider(bvid).notifier);
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
              Icon(Icons.refresh, color: colorScheme.primary),
            ],
          ),
        ),
      );
    }

    return EasyRefresh(
      onRefresh: notifier.refreshComments,
      onLoad: state.hasMoreComments ? notifier.loadMoreComments : null,
      header: AppRefreshHeader(),
      footer: AppLoadFooter(),
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
              CommentReplySheet.show(
                context,
                comment: comment,
                onSend: (text) {
                  notifier.addReply(
                    comment.oid,
                    comment.root == 0 ? comment.rpid : comment.root,
                    comment.rpid,
                    text,
                  );
                },
              );
            },
            onTapReplies: () {
              CommentReplyRoute(
                bvid: bvid,
                oid: state.videoDetail!.aid,
                rootId: comment.rpid,
                $extra: {'comment': comment, 'upperMid': upperMid},
              ).push(context);
            },
          );
        },
      ),
    );
  }
}
