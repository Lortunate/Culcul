import 'dart:async';

import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/video/video.dart';
import 'package:culcul/features/video/presentation/view_models/video_comments_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/pagination/pagination_load_gate.dart';
import 'package:culcul/core/pagination/scroll_load_trigger.dart';
import 'package:culcul/ui/widgets/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoCommentsView extends HookConsumerWidget {
  final String bvid;

  const VideoCommentsView({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(videoDetailControllerProvider(bvid));
    final state = ref.watch(videoCommentsControllerProvider(bvid));
    final notifier = ref.read(videoCommentsControllerProvider(bvid).notifier);
    final paging = state.paging;
    final hasMore = paging.hasMore;
    final loadGate = useMemoized(PaginationLoadGate.new, [bvid]);

    useEffect(() {
      unawaited(notifier.ensureLoaded());
      return null;
    }, [notifier]);

    if (paging.isInitialLoading && paging.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (paging.items.isEmpty && !paging.isInitialLoading) {
      return _buildEmptyState(context, notifier);
    }

    final upperMid = detailState.videoDetail?.owner.mid;

    return EasyRefresh(
      onRefresh: notifier.refresh,
      onLoad: !hasMore
          ? null
          : () => ScrollLoadTrigger.runWithNotifier(
              gate: loadGate,
              hasMore: () =>
                  ref.read(videoCommentsControllerProvider(bvid)).paging.hasMore,
              isLoadingMore: () =>
                  ref.read(videoCommentsControllerProvider(bvid)).paging.isLoadingMore,
              loadMore: notifier.loadMore,
              itemCount: () =>
                  ref.read(videoCommentsControllerProvider(bvid)).paging.items.length,
              source: 'video.video_comments',
            ),
      header: AppRefreshHeader(),
      footer: hasMore ? AppLoadFooter() : null,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemCount: paging.items.length,
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
          final comment = paging.items[index];
          return KeyedSubtree(
            key: ValueKey('video_comment_${comment.rpid}_$index'),
            child: CommentItemWidget(
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
                if (detailState.videoDetail?.aid != null) {
                  CommentReplyRoute(
                    bvid: bvid,
                    oid: detailState.videoDetail!.aid,
                    rootId: comment.rpid,
                    $extra: CommentReplyRouteInput(comment: comment, upperMid: upperMid),
                  ).push(context);
                }
              },
            ),
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
        onTap: notifier.refresh,
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
