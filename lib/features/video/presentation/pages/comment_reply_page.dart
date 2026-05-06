import 'dart:async';

import 'package:culcul/features/video/application/comment_reply_commands.dart';
import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/features/video/presentation/view_models/comment_reply_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/comments/comment_reply_sheet.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/video/presentation/widgets/comments/bottom_input_bar.dart';
import 'package:culcul/features/video/presentation/widgets/comments/comment_item.dart';
import 'package:culcul/core/pagination/pagination_load_gate.dart';
import 'package:culcul/ui/widgets/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef PresentCommentReplySheet =
    void Function({
      required CommentItem comment,
      required Future<void> Function(String text) onSend,
    });

class CommentReplyPageSheetActions {
  CommentReplyPageSheetActions({
    required this.presentReplySheet,
    required this.createOnSend,
  });

  final PresentCommentReplySheet presentReplySheet;
  final Future<void> Function(String text) Function(CommentItem item) createOnSend;

  void showReplySheet(CommentItem item) {
    presentReplySheet(comment: item, onSend: createOnSend(item));
  }
}

CommentReplyCommands _buildCommentReplyCommands({
  required PaginationLoadGate loadGate,
  required Future<void> Function(int oid, int root, int parent, String text) addReply,
  required bool Function() hasMoreReplies,
  required bool Function() isLoadingMoreReplies,
  required Future<void> Function() loadMoreRepliesFromController,
  required int Function() currentReplyCount,
}) {
  return CommentReplyCommands(
    loadGate: loadGate,
    addReply: addReply,
    hasMoreReplies: hasMoreReplies,
    isLoadingMoreReplies: isLoadingMoreReplies,
    loadMoreRepliesFromController: loadMoreRepliesFromController,
    currentReplyCount: currentReplyCount,
  );
}

CommentReplyPageSheetActions _buildCommentReplySheetActions(
  BuildContext context,
  CommentReplyCommands commands,
) {
  return CommentReplyPageSheetActions(
    createOnSend: (item) => (text) => commands.submitReply(item, text),
    presentReplySheet: ({required comment, required onSend}) {
      CommentReplySheet.show(
        context,
        comment: comment,
        onSend: (text) {
          unawaited(onSend(text));
        },
      );
    },
  );
}

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
    final provider = commentReplyControllerProvider(oid, rootId);
    final paging = ref.watch(provider.select((state) => state.paging));
    final watchedRootComment = ref.watch(provider.select((state) => state.rootComment));
    final controller = ref.read(provider.notifier);
    final hasMore = paging.hasMore;
    final loadGate = useMemoized(PaginationLoadGate.new, [oid, rootId]);
    final commands = useMemoized(
      () => _buildCommentReplyCommands(
        loadGate: loadGate,
        addReply: controller.addReply,
        hasMoreReplies: () => ref.read(provider).paging.hasMore,
        isLoadingMoreReplies: () => ref.read(provider).paging.isLoadingMore,
        loadMoreRepliesFromController: controller.loadMore,
        currentReplyCount: () => ref.read(provider).paging.items.length,
      ),
      [ref, provider, controller, loadGate],
    );
    final sheetActions = useMemoized(
      () => _buildCommentReplySheetActions(context, commands),
      [context, commands],
    );
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
              onLoad: !hasMore ? null : commands.loadMoreReplies,
              header: AppRefreshHeader(),
              footer: hasMore ? AppLoadFooter() : null,
              child: CustomScrollView(
                cacheExtent: 520,
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
                          onReply: () => sheetActions.showReplySheet(rootComment),
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
                          onLike: () => controller.toggleCommentLike(
                            reply.oid,
                            reply.rpid,
                            reply.action == 1,
                          ),
                          onDislike: () =>
                              controller.toggleCommentDislike(reply.oid, reply.rpid),
                          onReply: () => sheetActions.showReplySheet(reply),
                        );
                      }, childCount: paging.items.length),
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
