part of 'article_detail_page.dart';

Widget buildArticleDetailScaffold({
  required BuildContext context,
  required Translations t,
  required ArticleDetailData data,
  required String? title,
  required ArticleDetailUiState state,
  required ArticleDetailViewModel notifier,
  required bool canLoadMore,
  required Future<void> Function() onRefresh,
  required Future<IndicatorResult> Function()? onLoadMore,
  required bool commentsEnabled,
  required TextEditingController commentController,
  required Future<void> Function() onSubmitComment,
  required Future<void> Function(CommentItem item, String message) onSubmitReply,
  required Future<void> Function(CommentItem item) onToggleCommentLike,
}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        data.title.isNotEmpty ? data.title : (title ?? t.moments.detail_title),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert_rounded),
          onSelected: (action) => handleArticleMenuAction(context, action, data),
          itemBuilder: buildArticleActionsMenuItems,
        ),
      ],
    ),
    body: EasyRefresh(
      header: const AppRefreshHeader(),
      footer: canLoadMore ? const AppLoadFooter() : null,
      onRefresh: onRefresh,
      onLoad: onLoadMore,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (data.bannerUrl != null && data.bannerUrl!.isNotEmpty) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AppNetworkImage(url: data.bannerUrl!, height: 180),
                  ),
                  const SizedBox(height: 14),
                ],
                Text(
                  data.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 24,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                _AuthorHeader(data: data),
                if (data.blocks.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  ...buildArticleBlocks(context, data.blocks),
                ],
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: _StatsRow(data: data),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
              child: Row(
                children: [
                  Text(
                    t.video.comment.detail,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    FormatUtils.formatAnyNumber(data.stats.reply),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...buildArticleCommentSlivers(
            context: context,
            state: state,
            notifier: notifier,
            data: data,
            onToggleCommentLike: onToggleCommentLike,
            onSubmitReply: onSubmitReply,
          ),
        ],
      ),
    ),
    bottomNavigationBar: commentsEnabled
        ? _ArticleCommentBar(
            controller: commentController,
            isSending: state.isSendingComment,
            onSend: onSubmitComment,
          )
        : null,
  );
}
