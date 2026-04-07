part of 'article_detail_page.dart';

List<Widget> buildArticleCommentSlivers({
  required BuildContext context,
  required ArticleDetailUiState state,
  required ArticleDetailViewModel notifier,
  required ArticleDetailData data,
  required Future<void> Function(CommentItem item) onToggleCommentLike,
  required Future<void> Function(CommentItem item, String message) onSubmitReply,
}) {
  final t = Translations.of(context);
  final slivers = <Widget>[];

  if (state.comments.isEmpty && state.commentsLoading) {
    slivers.add(
      const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  } else if (!state.commentsEnabled) {
    slivers.add(
      SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: AppEmptyStateWidget(
            message: t.video.comment.empty,
            onAction: () => notifier.loadComments(refresh: true),
            actionLabel: t.common.retry,
          ),
        ),
      ),
    );
  } else if (state.comments.isEmpty && state.commentsError != null) {
    slivers.add(
      SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: AppErrorWidget(
            error: Exception(state.commentsError!),
            onRetry: () => notifier.loadComments(refresh: true),
          ),
        ),
      ),
    );
  } else if (state.comments.isEmpty) {
    slivers.add(
      SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: AppEmptyStateWidget(
            message: t.video.comment.empty,
            onAction: () => notifier.loadComments(refresh: true),
            actionLabel: t.common.retry,
          ),
        ),
      ),
    );
  } else {
    slivers.add(
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final item = state.comments[index];
          return Column(
            children: [
              CommentItemWidget(
                item: item,
                upperMid: data.authorMid,
                onLike: () => onToggleCommentLike(item),
                onDislike: null,
                onReply: () => CommentReplySheet.show(
                  context,
                  comment: item,
                  onSend: (text) => onSubmitReply(item, text),
                ),
                onTapReplies: item.replies.isNotEmpty
                    ? () => CommentReplySheet.show(
                        context,
                        comment: item,
                        onSend: (text) => onSubmitReply(item, text),
                      )
                    : null,
              ),
              if (index < state.comments.length - 1)
                Divider(
                  height: 1,
                  thickness: 0.5,
                  indent: 16,
                  endIndent: 16,
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
                ),
            ],
          );
        }, childCount: state.comments.length),
      ),
    );
  }

  if (state.commentsLoading) {
    slivers.add(
      const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 16, bottom: 8),
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
      ),
    );
  }

  if (state.commentsError != null && state.comments.isNotEmpty) {
    slivers.add(
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: AppErrorWidget(
            error: Exception(state.commentsError!),
            onRetry: () => notifier.loadComments(refresh: true),
            variant: AppErrorWidgetVariant.compact,
          ),
        ),
      ),
    );
  }

  slivers.add(const SliverToBoxAdapter(child: SizedBox(height: 16)));
  return slivers;
}

class _ArticleCommentBar extends StatelessWidget {
  final TextEditingController controller;
  final bool isSending;
  final VoidCallback onSend;

  const _ArticleCommentBar({
    required this.controller,
    required this.isSending,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 8 + MediaQuery.of(context).padding.bottom,
      ),
      child: DynamicCommentComposer(
        controller: controller,
        isSending: isSending,
        onSend: onSend,
        hintText: t.video.comment.hint,
      ),
    );
  }
}
