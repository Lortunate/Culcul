import 'package:easy_refresh/easy_refresh.dart';
import 'package:culcul/data/models/comment_model.dart';
import 'package:culcul/providers/video/comment_reply_controller.dart';
import 'package:culcul/ui/pages/video/widgets/bottom_input_bar.dart';
import 'package:culcul/ui/pages/video/widgets/comment_item.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

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
                          onReply: () => _showReplySheet(context, rootComment, controller),
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
                          onReply: () => _showReplySheet(context, reply, controller),
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

  void _showReplySheet(
    BuildContext context,
    CommentItem comment,
    CommentReplyController notifier,
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
