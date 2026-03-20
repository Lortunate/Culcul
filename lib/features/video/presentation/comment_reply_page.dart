import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:culcul/features/video/logic/comment_reply_controller.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/pages/video/widgets/comments/bottom_input_bar.dart';
import 'package:culcul/ui/pages/video/widgets/comments/comment_item.dart';
import 'package:culcul/ui/pages/video/widgets/comments/comment_reply_sheet.dart';
import 'package:culcul/ui/widgets/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommentReplyPage extends HookConsumerWidget {
  final int oid;
  final int rootId;
  final CommentItem comment;
  final int? upperMid;

  const CommentReplyPage({
    super.key,
    required this.oid,
    required this.rootId,
    required this.comment,
    this.upperMid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commentReplyControllerProvider(oid, rootId));
    final controller = ref.read(
      commentReplyControllerProvider(oid, rootId).notifier,
    );
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    useEffect(() {
      if (state.rootComment == null) {
        Future.microtask(() => controller.setRootComment(comment));
      }
      return null;
    }, [comment]);

    final rootComment = state.rootComment ?? comment;

    void showReplySheet(CommentItem item) {
      CommentReplySheet.show(
        context,
        comment: item,
        onSend: (text) {
          controller.addReply(
            item.oid,
            item.root == 0 ? item.rpid : item.root,
            item.rpid,
            text,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.video.comment_detail,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
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
              onLoad: state.hasMore ? controller.loadMore : null,
              header: AppRefreshHeader(),
              footer: AppLoadFooter(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        CommentItemWidget(
                          item: rootComment,
                          showRepliesPreview: false,
                          upperMid: upperMid,
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
                        if (state.replies.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                            child: Row(
                              children: [
                                Text(
                                  t.video.related_replies,
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
                  if (state.replies.isEmpty && state.isLoading)
                    const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final reply = state.replies[index];
                        return CommentItemWidget(
                          item: reply,
                          showRepliesPreview: false,
                          upperMid: upperMid,
                          onLike: () => controller.toggleCommentLike(
                            reply.oid,
                            reply.rpid,
                            reply.action == 1,
                          ),
                          onDislike: () => controller.toggleCommentDislike(
                            reply.oid,
                            reply.rpid,
                          ),
                          onReply: () => showReplySheet(reply),
                        );
                      }, childCount: state.replies.length),
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                ],
              ),
            ),
          ),
          const BottomInputBar(simpleMode: true),
        ],
      ),
    );
  }
}
