import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/video/presentation/video_route_entry.dart';
import 'package:culcul/features/video/presentation/view_models/video_comments_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/comments/comment_item.dart';
import 'package:culcul/features/video/presentation/widgets/comments/comment_reply_sheet.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoCommentsView extends ConsumerWidget {
  final String bvid;

  const VideoCommentsView({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(videoDetailControllerProvider(bvid));
    final state = ref.watch(videoCommentsControllerProvider(bvid));
    final notifier = ref.read(videoCommentsControllerProvider(bvid).notifier);

    if (state.isInitialLoading && state.comments.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.comments.isEmpty && !state.isInitialLoading) {
      return _buildEmptyState(context, notifier);
    }

    final upperMid = detailState.videoDetail?.owner.mid;

    return EasyRefresh(
      onRefresh: notifier.refresh,
      onLoad: state.hasMore ? notifier.loadMore : null,
      header: AppRefreshHeader(),
      footer: AppLoadFooter(),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemCount: state.comments.length,
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
            thickness: 0.5,
            indent: 16,
            endIndent: 16,
            color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
          );
        },
        itemBuilder: (context, index) {
          final comment = state.comments[index];
          return CommentItemWidget(
            item: comment,
            upperMid: upperMid,
            onLike: () {
              notifier.toggleCommentLike(comment.oid, comment.rpid, comment.action == 1);
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
              if (detailState.videoDetail?.aid != null) {
                CommentReplyRoute(
                  bvid: bvid,
                  oid: detailState.videoDetail!.aid,
                  rootId: comment.rpid,
                  $extra: CommentReplyRouteInput(comment: comment, upperMid: upperMid),
                ).push(context);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, dynamic notifier) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Center(
      child: GestureDetector(
        onTap: notifier.refreshComments,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.video.comment.empty,
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
}
