import 'dart:async';

import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/features/video/presentation/comments/video_comments_view_model.dart';
import 'package:culcul/ui/assemblies/comments/comment_item.dart';
import 'package:culcul/ui/assemblies/comments/comment_reply_sheet.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/ui/widgets/layout/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef OpenVideoCommentReplies =
    void Function({
      required int oid,
      required int rootId,
      required CommentItem comment,
      int? upperMid,
    });

const int _commentPrefetchCommentScanLimit = 6;
const int _commentPrefetchPictureScanLimit = 3;
const int _commentImagePrefetchLimit = 8;
const int _commentPictureMinLogicalSize = 100;
const int _commentPictureMaxLogicalSize = 200;
const double _commentPictureFallbackLogicalSize = 120;
const double _commentListCacheExtent = 520;

class VideoCommentsView extends HookConsumerWidget {
  final String bvid;
  final ValueChanged<int> onOpenUser;
  final OpenVideoCommentReplies onOpenCommentReplies;

  const VideoCommentsView({
    super.key,
    required this.bvid,
    required this.onOpenUser,
    required this.onOpenCommentReplies,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aid = ref.watch(
      videoDetailControllerProvider(bvid).select((state) => state.videoDetail?.aid),
    );
    final upperMid = ref.watch(
      videoDetailControllerProvider(bvid).select((state) => state.videoDetail?.owner.mid),
    );
    final paging = ref.watch(
      videoCommentsControllerProvider(bvid).select((state) => state.paging),
    );
    final notifier = ref.read(videoCommentsControllerProvider(bvid).notifier);
    final hasMore = paging.hasMore;
    final loadGate = useMemoized(PaginationLoadGate.new, [bvid]);

    useEffect(() {
      unawaited(notifier.ensureLoaded());
      return null;
    }, [notifier]);

    useEffect(() {
      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      final specs = <NetworkImagePrefetchSpec>[];

      for (final comment in paging.items.take(_commentPrefetchCommentScanLimit)) {
        for (final picture in comment.content.pictures.take(
          _commentPrefetchPictureScanLimit,
        )) {
          final logicalWidth = picture.imgWidth > 0
              ? picture.imgWidth
                    .clamp(_commentPictureMinLogicalSize, _commentPictureMaxLogicalSize)
                    .toDouble()
              : _commentPictureFallbackLogicalSize;
          final logicalHeight = picture.imgHeight > 0
              ? picture.imgHeight
                    .clamp(_commentPictureMinLogicalSize, _commentPictureMaxLogicalSize)
                    .toDouble()
              : _commentPictureFallbackLogicalSize;
          specs.add(
            NetworkImagePrefetchSpec(
              url: picture.imgSrc,
              memCacheWidth: (logicalWidth * pixelRatio).round(),
              memCacheHeight: (logicalHeight * pixelRatio).round(),
            ),
          );
        }
      }

      AppNetworkImagePrefetcher.prefetch(
        context,
        specs: specs,
        limit: _commentImagePrefetchLimit,
      );
      return null;
    }, [paging.items]);

    if (paging.isInitialLoading && paging.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (paging.items.isEmpty && !paging.isInitialLoading) {
      return Center(
        child: GestureDetector(
          onTap: notifier.refresh,
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.video.comment.empty,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: CulculSpacing.xs),
              Icon(Icons.refresh, color: Theme.of(context).colorScheme.primary),
            ],
          ),
        ),
      );
    }

    final onLoad = !hasMore
        ? null
        : () => ScrollLoadTrigger.runWithNotifier(
            gate: loadGate,
            hasMore: () => ref.read(videoCommentsControllerProvider(bvid)).paging.hasMore,
            isLoadingMore: () =>
                ref.read(videoCommentsControllerProvider(bvid)).paging.isLoadingMore,
            loadMore: notifier.loadMore,
            itemCount: () =>
                ref.read(videoCommentsControllerProvider(bvid)).paging.items.length,
            source: 'video.video_comments',
          );

    return EasyRefresh(
      onRefresh: notifier.refresh,
      onLoad: onLoad,
      header: const AppRefreshHeader(),
      footer: hasMore ? const AppLoadFooter() : null,
      child: ListView.separated(
        cacheExtent: _commentListCacheExtent,
        padding: const EdgeInsets.symmetric(vertical: CulculSpacing.xxs),
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
          return _VideoCommentListItem(
            key: ValueKey('video_comment_${comment.rpid}_$index'),
            aid: aid,
            upperMid: upperMid,
            comment: comment,
            notifier: notifier,
            onOpenUser: onOpenUser,
            onOpenCommentReplies: onOpenCommentReplies,
          );
        },
      ),
    );
  }
}

class _VideoCommentListItem extends StatelessWidget {
  final int? aid;
  final int? upperMid;
  final CommentItem comment;
  final VideoCommentsController notifier;
  final ValueChanged<int> onOpenUser;
  final OpenVideoCommentReplies onOpenCommentReplies;

  const _VideoCommentListItem({
    super.key,
    required this.aid,
    required this.upperMid,
    required this.comment,
    required this.notifier,
    required this.onOpenUser,
    required this.onOpenCommentReplies,
  });

  @override
  Widget build(BuildContext context) {
    return CommentItemWidget(
      item: comment,
      upperMid: upperMid,
      onTapUser: onOpenUser,
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
        if (aid != null) {
          onOpenCommentReplies(
            oid: aid!,
            rootId: comment.rpid,
            comment: comment,
            upperMid: upperMid,
          );
        }
      },
    );
  }
}
