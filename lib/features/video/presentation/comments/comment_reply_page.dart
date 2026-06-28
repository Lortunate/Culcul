import 'dart:async';

import 'package:culcul/core/models/comment_contract.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/features/video/presentation/comments/comment_reply_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/comments/comment_item.dart';
import 'package:culcul/ui/widgets/comments/comment_reply_sheet.dart';
import 'package:culcul/ui/widgets/layout/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const double _commentReplyListCacheExtent = 520;

class CommentReplyPage extends HookConsumerWidget {
  final int oid;
  final int rootId;
  final CommentItem comment;
  final int? upperMid;
  final ValueChanged<int> onOpenUser;

  const CommentReplyPage({
    super.key,
    required this.oid,
    required this.rootId,
    required this.comment,
    required this.onOpenUser,
    this.upperMid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = commentReplyControllerProvider(oid, rootId);
    final paging = ref.watch(provider.select((state) => state.paging));
    final watchedRootComment = ref.watch(provider.select((state) => state.rootComment));
    final controller = ref.read(provider.notifier);
    final hasMore = paging.hasMore;
    final loadGate = useMemoized(PaginationLoadGate.new, [oid, rootId]);
    Future<void> loadMoreReplies() {
      return ScrollLoadTrigger.runWithNotifier(
        gate: loadGate,
        hasMore: () => ref.read(provider).paging.hasMore,
        isLoadingMore: () => ref.read(provider).paging.isLoadingMore,
        loadMore: controller.loadMore,
        itemCount: () => ref.read(provider).paging.items.length,
        source: 'video.comment_reply',
      );
    }

    void showReplySheet(CommentItem item) {
      final root = item.root == 0 ? item.rpid : item.root;
      CommentReplySheet.show(
        context,
        comment: item,
        onSend: (text) {
          unawaited(controller.addReply(item.oid, root, item.rpid, text));
        },
      );
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    useEffect(() {
      if (watchedRootComment == null) {
        controller.setRootComment(comment);
      }
      return null;
    }, [comment, watchedRootComment]);

    final rootComment = watchedRootComment ?? comment;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.video.comment.detail,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => context.pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 0.5,
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: EasyRefresh(
              onRefresh: controller.refresh,
              onLoad: !hasMore ? null : loadMoreReplies,
              header: const AppRefreshHeader(),
              footer: hasMore ? const AppLoadFooter() : null,
              child: CustomScrollView(
                cacheExtent: _commentReplyListCacheExtent,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        CommentItemWidget(
                          item: rootComment,
                          showRepliesPreview: false,
                          upperMid: upperMid,
                          onTapUser: onOpenUser,
                          onLike: () => controller.toggleCommentLike(
                            rootComment.oid,
                            rootComment.rpid,
                            rootComment.action == 1,
                          ),
                          onDislike: () => controller.toggleCommentDislike(
                            rootComment.oid,
                            rootComment.rpid,
                          ),
                          onReply: () => showReplySheet(rootComment),
                        ),
                        Divider(
                          height: 1,
                          thickness: 8,
                          color: colorScheme.surfaceContainerHighest.withValues(
                            alpha: 0.2,
                          ),
                        ),
                        if (paging.items.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                            child: Row(
                              children: [
                                Text(
                                  t.video.comment.related_replies,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (paging.items.isEmpty && paging.isInitialLoading)
                    const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final reply = paging.items[index];
                        return CommentItemWidget(
                          item: reply,
                          showRepliesPreview: false,
                          upperMid: upperMid,
                          onTapUser: onOpenUser,
                          onLike: () => controller.toggleCommentLike(
                            reply.oid,
                            reply.rpid,
                            reply.action == 1,
                          ),
                          onDislike: () =>
                              controller.toggleCommentDislike(reply.oid, reply.rpid),
                          onReply: () => showReplySheet(reply),
                        );
                      }, childCount: paging.items.length),
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
