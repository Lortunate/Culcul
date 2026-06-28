part of 'article_detail_page.dart';

Widget _buildArticleDetailScaffold({
  required BuildContext context,
  required Translations t,
  required ArticleDetailData data,
  required String? title,
  required ArticleDetailUiState state,
  required ArticleDetailViewModel notifier,
  required Future<void> Function() onRefresh,
  required Future<IndicatorResult> Function()? onLoadMore,
  required TextEditingController commentController,
  required Future<void> Function() onSubmitComment,
  required Future<void> Function(CommentItem item, String message) onSubmitReply,
  required Future<void> Function(CommentItem item) onToggleCommentLike,
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

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
          onSelected: (action) => _handleArticleMenuAction(context, action, data),
          itemBuilder: buildArticleActionsMenuItems,
        ),
      ],
    ),
    body: EasyRefresh(
      header: const AppRefreshHeader(),
      footer: onLoadMore != null ? const AppLoadFooter() : null,
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
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      backgroundImage: data.authorAvatar.isNotEmpty
                          ? AppNetworkImage.providerFor(url: data.authorAvatar)
                          : null,
                      child: data.authorAvatar.isEmpty
                          ? Icon(
                              Icons.person_rounded,
                              color: colorScheme.onSurfaceVariant,
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.authorName.isNotEmpty ? data.authorName : 'Bilibili',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            data.publishTime > 0
                                ? FormatUtils.formatTimeAgo(data.publishTime)
                                : Translations.of(context).moments.detail_title,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (data.blocks.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  ..._buildArticleBlocks(context, data.blocks),
                ],
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_border_rounded,
                              size: 22,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              FormatUtils.formatAnyNumber(data.stats.favorite),
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 24,
                      color: colorScheme.outlineVariant.withValues(alpha: 0.35),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.thumb_up_outlined,
                              size: 22,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              FormatUtils.formatAnyNumber(data.stats.like),
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
          ..._buildArticleCommentSlivers(
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
    bottomNavigationBar: state.commentsEnabled
        ? Container(
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
              bottom: 8 + MediaQuery.paddingOf(context).bottom,
            ),
            child: DynamicCommentComposer(
              controller: commentController,
              isSending: state.isSendingComment,
              onSend: onSubmitComment,
              hintText: t.video.comment.hint,
            ),
          )
        : null,
  );
}

List<Widget> _buildArticleBlocks(BuildContext context, List<ArticleBlock> blocks) {
  final contentWidgets = <Widget>[];
  final invisibleTextPattern = RegExp(r'\s+');

  void addWithSpacing(Widget widget) {
    if (contentWidgets.isNotEmpty) {
      contentWidgets.add(const SizedBox(height: 12));
    }
    contentWidgets.add(widget);
  }

  for (final block in blocks) {
    switch (block) {
      case ArticleBlockParagraph():
        final hasText = block.nodes.any(
          (node) => node.text.replaceAll(invisibleTextPattern, '').isNotEmpty,
        );
        if (!hasText) break;
        addWithSpacing(_ParagraphBlockView(block: block));
      case ArticleBlockImage():
        final urls = block.imageUrls.where((e) => e.isNotEmpty).toList();
        if (urls.isEmpty) {
          addWithSpacing(const SizedBox.shrink());
          break;
        }
        addWithSpacing(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < urls.length; i++) ...[
                RepaintBoundary(
                  child: GestureDetector(
                    onTap: () => AppImagePreview.open(
                      context,
                      imageUrls: block.imageUrls,
                      initialIndex: i,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(CulculRadius.lg),
                      child: AppNetworkImage(
                        url: urls[i],
                        borderRadius: BorderRadius.circular(CulculRadius.lg),
                      ),
                    ),
                  ),
                ),
                if (i < urls.length - 1) const SizedBox(height: 10),
              ],
              if (block.caption != null && block.caption!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  block.caption!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        );
      case ArticleBlockLinkCard():
        final linkTheme = Theme.of(context);
        final linkColorScheme = linkTheme.colorScheme;
        addWithSpacing(
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(CulculRadius.lg),
              onTap: block.linkUrl == null
                  ? null
                  : () => DynamicNavigation.open(context, url: block.linkUrl!),
              child: Container(
                padding: const EdgeInsets.all(CulculSpacing.md),
                decoration: BoxDecoration(
                  color: linkColorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(CulculRadius.lg),
                  border: Border.all(
                    color: linkColorScheme.outlineVariant.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: linkColorScheme.primaryContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(CulculRadius.md),
                      ),
                      child: Icon(Icons.link_rounded, color: linkColorScheme.primary),
                    ),
                    const SizedBox(width: CulculSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            block.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: linkTheme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (block.subtitle != null && block.subtitle!.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              block.subtitle!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: linkTheme.textTheme.bodySmall?.copyWith(
                                color: linkColorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: linkColorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      case ArticleBlockQuote():
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        addWithSpacing(
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(CulculSpacing.md),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(CulculRadius.lg),
              border: Border(left: BorderSide(color: colorScheme.primary, width: 3)),
            ),
            child: Text.rich(
              TextSpan(
                children: block.nodes
                    .map(
                      (node) => TextSpan(
                        text: node.text,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.55,
                          color: colorScheme.onSurfaceVariant,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      case ArticleBlockDivider():
        addWithSpacing(const Divider(height: 18));
    }
  }

  return contentWidgets;
}

Future<void> _handleArticleMenuAction(
  BuildContext context,
  String action,
  ArticleDetailData data,
) async {
  switch (action) {
    case 'copy':
      await Clipboard.setData(ClipboardData(text: data.url));
      if (context.mounted) {
        context.showAppFeedback(Translations.of(context).moments.copied_link);
      }
    case 'share':
      await SharePlus.instance.share(ShareParams(uri: Uri.parse(data.url)));
    case 'open':
      await launchUrl(Uri.parse(data.url), mode: LaunchMode.externalApplication);
  }
}
