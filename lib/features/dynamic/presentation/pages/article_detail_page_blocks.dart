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
    switch (block.type) {
      case ArticleBlockType.paragraph:
        final hasText = block.nodes.any((node) => _hasVisibleText(node.text));
        if (!hasText) break;
        addWithSpacing(_ParagraphBlockView(block: block));
        break;
      case ArticleBlockType.image:
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
        break;
      case ArticleBlockType.linkCard:
        addWithSpacing(
          _LinkCardView(
            block: block,
            onTap: block.linkUrl == null
                ? null
                : () => DynamicNavigation.open(context, url: block.linkUrl!),
          ),
        );
        break;
      case ArticleBlockType.quote:
        addWithSpacing(_QuoteBlockView(block: block));
        break;
      case ArticleBlockType.divider:
        addWithSpacing(const Divider(height: 18));
        break;
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(Translations.of(context).moments.copied_link)),
        );
      }
      break;
    case 'share':
      await ShareUtils.shareUri(Uri.parse(data.url));
      break;
    case 'open':
      await launchUrl(Uri.parse(data.url), mode: LaunchMode.externalApplication);
      break;
  }
}
