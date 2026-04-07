part of 'article_detail_page.dart';

Widget buildArticleLoadingScaffold({
  required BuildContext context,
  required String? title,
}) {
  return Scaffold(
    appBar: AppBar(title: Text(title ?? Translations.of(context).moments.detail_title)),
    body: const Center(child: CircularProgressIndicator()),
  );
}

Widget buildArticleErrorScaffold({
  required BuildContext context,
  required String? title,
  required Object error,
  required VoidCallback onRetry,
}) {
  return Scaffold(
    appBar: AppBar(title: Text(title ?? Translations.of(context).moments.detail_title)),
    body: Center(
      child: AppErrorWidget(error: error, onRetry: onRetry),
    ),
  );
}

Widget buildArticleEmptyScaffold({
  required BuildContext context,
  required String? title,
  required VoidCallback onRetry,
}) {
  final t = Translations.of(context);
  return Scaffold(
    appBar: AppBar(title: Text(title ?? t.moments.detail_title)),
    body: Center(
      child: AppEmptyStateWidget(
        message: t.common.no_content,
        onAction: onRetry,
        actionLabel: t.common.retry,
      ),
    ),
  );
}

List<PopupMenuEntry<String>> buildArticleActionsMenuItems(BuildContext context) {
  final t = Translations.of(context);
  return [
    PopupMenuItem<String>(
      value: 'copy',
      child: ListTile(
        leading: const Icon(Icons.copy_all_rounded),
        title: Text(t.moments.copy_link),
        contentPadding: EdgeInsets.zero,
      ),
    ),
    PopupMenuItem<String>(
      value: 'share',
      child: ListTile(
        leading: const Icon(Icons.share_outlined),
        title: Text(t.actions.share),
        contentPadding: EdgeInsets.zero,
      ),
    ),
    PopupMenuItem<String>(
      value: 'open',
      child: ListTile(
        leading: const Icon(Icons.open_in_browser_rounded),
        title: Text(t.moments.open_in_browser),
        contentPadding: EdgeInsets.zero,
      ),
    ),
  ];
}
