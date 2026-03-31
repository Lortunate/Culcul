import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/features/dynamic/models/dynamic_models.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/utils/share_utils.dart';
import 'package:culcul/features/dynamic/presentation/view_models/article_detail_view_model.dart';
import 'package:culcul/features/dynamic/presentation/utils/dynamic_navigation.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_comment_composer.dart';
import 'package:culcul/features/video/presentation/widgets/comments/comment_item.dart';
import 'package:culcul/features/video/presentation/widgets/comments/comment_reply_sheet.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/app_image_preview.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:culcul/ui/widgets/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailPage extends HookConsumerWidget {
  final String url;
  final String? title;

  const ArticleDetailPage({super.key, required this.url, this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final provider = articleDetailViewModelProvider(url);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final commentController = useTextEditingController();

    if (state.isLoading && state.detail == null) {
      return Scaffold(
        appBar: AppBar(title: Text(title ?? t.moments.detail_title)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (state.error != null && state.detail == null) {
      return Scaffold(
        appBar: AppBar(title: Text(title ?? t.moments.detail_title)),
        body: Center(
          child: AppErrorWidget(error: state.error!, onRetry: notifier.refreshAll),
        ),
      );
    }

    final data = state.detail;
    if (data == null) {
      return Scaffold(
        appBar: AppBar(title: Text(title ?? t.moments.detail_title)),
        body: Center(child: AppErrorWidget(message: t.common.no_content)),
      );
    }

    final commentsEnabled = state.commentsEnabled;

    void showSnack(String message) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }

    Future<void> submitComment() async {
      if (!commentsEnabled) {
        showSnack(t.video.comment.empty);
        return;
      }
      final message = commentController.text.trim();
      if (message.isEmpty || state.isSendingComment) return;

      final error = await notifier.submitComment(message);
      if (error != null) {
        showSnack(error == 'Comments disabled' ? t.video.comment.empty : error);
        return;
      }
      if (context.mounted) {
        commentController.clear();
        FocusScope.of(context).unfocus();
      }
    }

    Future<void> submitReply(CommentItem item, String message) async {
      if (!commentsEnabled) {
        showSnack(t.video.comment.empty);
        return;
      }
      final error = await notifier.submitReply(item, message);
      if (error != null) {
        showSnack(error == 'Comments disabled' ? t.video.comment.empty : error);
      }
    }

    Future<void> toggleCommentLike(CommentItem item) async {
      await notifier.toggleCommentLike(item);
    }

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
            onSelected: (action) => _handleMenuAction(context, action, data),
            itemBuilder: (context) => [
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
            ],
          ),
        ],
      ),
      body: EasyRefresh(
        header: AppRefreshHeader(),
        footer: AppLoadFooter(),
        onRefresh: notifier.refreshAll,
        onLoad: commentsEnabled && state.commentsHasMore
            ? () async {
                if (!state.commentsLoading) {
                  await notifier.loadComments();
                }
              }
            : null,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  if (data.bannerUrl != null && data.bannerUrl!.isNotEmpty) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AppNetworkImage(
                        url: data.bannerUrl!,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
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
                    ..._buildBlocks(context, data.blocks),
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
            if (state.comments.isEmpty && state.commentsLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (!commentsEnabled)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: AppErrorWidget(
                    message: t.video.comment.empty,
                    onRetry: () => notifier.loadComments(refresh: true),
                  ),
                ),
              )
            else if (state.comments.isEmpty && state.commentsError != null)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: AppErrorWidget(
                    message: state.commentsError!,
                    onRetry: () => notifier.loadComments(refresh: true),
                  ),
                ),
              )
            else if (state.comments.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: AppErrorWidget(
                    message: t.video.comment.empty,
                    onRetry: () => notifier.loadComments(refresh: true),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = state.comments[index];
                  return Column(
                    children: [
                      CommentItemWidget(
                        item: item,
                        upperMid: data.authorMid,
                        onLike: () => toggleCommentLike(item),
                        onDislike: null,
                        onReply: () => CommentReplySheet.show(
                          context,
                          comment: item,
                          onSend: (text) => submitReply(item, text),
                        ),
                        onTapReplies: item.replies.isNotEmpty
                            ? () => CommentReplySheet.show(
                                context,
                                comment: item,
                                onSend: (text) => submitReply(item, text),
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
            if (state.commentsLoading)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                ),
              ),
            if (state.commentsError != null && state.comments.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: AppErrorWidget(
                    message: state.commentsError!,
                    onRetry: () => notifier.loadComments(refresh: true),
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      ),
      bottomNavigationBar: commentsEnabled
          ? _ArticleCommentBar(
              controller: commentController,
              isSending: state.isSendingComment,
              onSend: submitComment,
            )
          : null,
    );
  }

  List<Widget> _buildBlocks(BuildContext context, List<ArticleBlock> blocks) {
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

  Future<void> _handleMenuAction(
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
}

class _AuthorHeader extends StatelessWidget {
  final ArticleDetailData data;

  const _AuthorHeader({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: colorScheme.surfaceContainerHighest,
          backgroundImage: data.authorAvatar.isNotEmpty
              ? NetworkImage(data.authorAvatar)
              : null,
          child: data.authorAvatar.isEmpty
              ? Icon(Icons.person_rounded, color: colorScheme.onSurfaceVariant)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.authorName.isNotEmpty ? data.authorName : 'Bilibili',
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
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
    );
  }
}

class _StatsRow extends StatelessWidget {
  final ArticleDetailData data;

  const _StatsRow({required this.data});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatChip(
              icon: Icons.star_border_rounded,
              label: FormatUtils.formatAnyNumber(data.stats.favorite),
            ),
          ),
          Container(
            width: 1,
            height: 24,
            color: colorScheme.outlineVariant.withValues(alpha: 0.35),
          ),
          Expanded(
            child: _StatChip(
              icon: Icons.thumb_up_outlined,
              label: FormatUtils.formatAnyNumber(data.stats.like),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ParagraphBlockView extends StatefulWidget {
  final ArticleBlock block;

  const _ParagraphBlockView({required this.block});

  @override
  State<_ParagraphBlockView> createState() => _ParagraphBlockViewState();
}

class _ParagraphBlockViewState extends State<_ParagraphBlockView> {
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();

    final spans = widget.block.nodes.map((node) {
      final style =
          theme.textTheme.bodyMedium?.copyWith(
            height: 1.6,
            fontSize: node.fontSize ?? widget.block.fontSize ?? 16,
            fontWeight: node.bold || widget.block.bold
                ? FontWeight.w600
                : FontWeight.w400,
            fontStyle: node.italic ? FontStyle.italic : FontStyle.normal,
            color: _parseColor(node.color) ?? colorScheme.onSurface,
            decoration: node.linkUrl != null
                ? TextDecoration.underline
                : TextDecoration.none,
          ) ??
          TextStyle(
            height: 1.6,
            fontSize: node.fontSize ?? widget.block.fontSize ?? 16,
            fontWeight: node.bold || widget.block.bold
                ? FontWeight.w600
                : FontWeight.w400,
            fontStyle: node.italic ? FontStyle.italic : FontStyle.normal,
            color: _parseColor(node.color) ?? colorScheme.onSurface,
            decoration: node.linkUrl != null
                ? TextDecoration.underline
                : TextDecoration.none,
          );

      final normalizedText = _normalizeBlockText(node.text);
      if (node.linkUrl == null || node.linkUrl!.isEmpty) {
        return TextSpan(text: normalizedText, style: style);
      }

      final recognizer = TapGestureRecognizer()
        ..onTap = () => DynamicNavigation.open(context, url: node.linkUrl!);
      _recognizers.add(recognizer);
      return TextSpan(text: normalizedText, style: style, recognizer: recognizer);
    }).toList();

    return Align(
      alignment: _alignToAlignment(widget.block.align),
      child: Text.rich(
        TextSpan(children: spans),
        textAlign: _toTextAlign(widget.block.align),
      ),
    );
  }

  Alignment _alignToAlignment(ArticleTextAlign? align) {
    switch (align) {
      case ArticleTextAlign.center:
        return Alignment.center;
      case ArticleTextAlign.end:
        return Alignment.centerRight;
      case ArticleTextAlign.start:
      case null:
        return Alignment.centerLeft;
    }
  }

  TextAlign _toTextAlign(ArticleTextAlign? align) {
    return switch (align) {
      ArticleTextAlign.center => TextAlign.center,
      ArticleTextAlign.end => TextAlign.end,
      ArticleTextAlign.start || null => TextAlign.start,
    };
  }
}

class _ImageBlockView extends StatelessWidget {
  final ArticleBlock block;
  final void Function(int index) onTap;

  const _ImageBlockView({required this.block, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final urls = block.imageUrls.where((e) => e.isNotEmpty).toList();
    if (urls.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < urls.length; i++) ...[
          GestureDetector(
            onTap: () => onTap(i),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: AppNetworkImage(url: urls[i], fit: BoxFit.cover, borderRadius: 14),
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
    );
  }
}

class _LinkCardView extends StatelessWidget {
  final ArticleBlock block;
  final VoidCallback? onTap;

  const _LinkCardView({required this.block, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.35)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.link_rounded, color: colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      block.title ?? '链接卡片',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (block.subtitle != null && block.subtitle!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        block.subtitle!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuoteBlockView extends StatelessWidget {
  final ArticleBlock block;

  const _QuoteBlockView({required this.block});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14),
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
    );
  }
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

bool _hasVisibleText(String value) {
  return value.replaceAll(RegExp(r'\s+'), '').isNotEmpty;
}

String _normalizeBlockText(String value) {
  return value.replaceAll(RegExp(r'\n{3,}'), '\n\n');
}

Color? _parseColor(String? color) {
  if (color == null || color.isEmpty) return null;
  if (color.startsWith('#')) {
    final hex = color.substring(1);
    try {
      if (hex.length == 6) {
        return Color(int.parse('FF$hex', radix: 16));
      }
      if (hex.length == 8) {
        return Color(int.parse(hex, radix: 16));
      }
    } on FormatException {
      return null;
    }
  }
  return null;
}
