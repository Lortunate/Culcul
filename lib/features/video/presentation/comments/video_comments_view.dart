import 'dart:async';

import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/features/video/route_entry.dart';
import 'package:culcul/features/video/presentation/comments/video_comments_view_model.dart';
import 'package:culcul/ui/assemblies/comments/comment_item.dart';
import 'package:culcul/ui/assemblies/comments/comment_reply_sheet.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/ui/widgets/layout/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'video_comments_view.list.dart';

class VideoCommentsView extends HookConsumerWidget {
  final String bvid;

  const VideoCommentsView({super.key, required this.bvid});

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

      for (final comment in paging.items.take(6)) {
        for (final picture in comment.content.pictures.take(3)) {
          final logicalWidth = picture.imgWidth > 0
              ? picture.imgWidth.clamp(100, 200).toDouble()
              : 120.0;
          final logicalHeight = picture.imgHeight > 0
              ? picture.imgHeight.clamp(100, 200).toDouble()
              : 120.0;
          specs.add(
            NetworkImagePrefetchSpec(
              url: picture.imgSrc,
              memCacheWidth: (logicalWidth * pixelRatio).round(),
              memCacheHeight: (logicalHeight * pixelRatio).round(),
            ),
          );
        }
      }

      AppNetworkImagePrefetcher.prefetch(context, specs: specs, limit: 8);
      return null;
    }, [paging.items]);

    if (paging.isInitialLoading && paging.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (paging.items.isEmpty && !paging.isInitialLoading) {
      return VideoCommentsEmptyState(onRefresh: notifier.refresh);
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

    return _VideoCommentsPagingBody(
      comments: paging.items,
      hasMore: hasMore,
      onRefresh: notifier.refresh,
      onLoad: onLoad,
      itemBuilder: (context, comment, index) {
        return _VideoCommentListItem(
          key: ValueKey('video_comment_${comment.rpid}_$index'),
          bvid: bvid,
          aid: aid,
          upperMid: upperMid,
          comment: comment,
          notifier: notifier,
        );
      },
    );
  }
}

class VideoCommentsEmptyState extends StatelessWidget {
  final VoidCallback onRefresh;

  const VideoCommentsEmptyState({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Center(
      child: GestureDetector(
        onTap: onRefresh,
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
