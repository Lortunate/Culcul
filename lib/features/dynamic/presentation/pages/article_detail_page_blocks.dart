part of 'article_detail_page.dart';

List<Widget> buildArticleBlocks(BuildContext context, List<ArticleBlock> blocks) {
  final contentWidgets = <Widget>[];

  void addWithSpacing(Widget widget) {
    if (contentWidgets.isNotEmpty) {
      contentWidgets.add(const SizedBox(height: 12));
    }
    contentWidgets.add(widget);
  }

  for (final block in blocks) {
    switch (block) {
      case ArticleBlockParagraph():
        final hasText = block.nodes.any((node) => _hasVisibleText(node.text));
        if (!hasText) break;
        addWithSpacing(_ParagraphBlockView(block: block));
      case ArticleBlockImage():
        addWithSpacing(
          _ImageBlockView(
            block: block,
            onTap: (index) => AppImagePreview.open(
              context,
              imageUrls: block.imageUrls,
              initialIndex: index,
            ),
          ),
        );
      case ArticleBlockLinkCard():
        addWithSpacing(
          _LinkCardView(
            block: block,
            onTap: block.linkUrl == null
                ? null
                : () => DynamicNavigation.open(context, url: block.linkUrl!),
          ),
        );
      case ArticleBlockQuote():
        addWithSpacing(_QuoteBlockView(block: block));
      case ArticleBlockDivider():
        addWithSpacing(const Divider(height: 18));
    }
  }

  return contentWidgets;
}

Future<void> handleArticleMenuAction(
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
      await shareUri(Uri.parse(data.url));
    case 'open':
      await launchUrl(Uri.parse(data.url), mode: LaunchMode.externalApplication);
  }
}
