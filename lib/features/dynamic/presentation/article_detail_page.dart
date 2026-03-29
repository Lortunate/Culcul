import 'dart:math' as math;

import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/utils/share_utils.dart';
import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:culcul/features/dynamic/data/article_detail_data.dart';
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

final articleDetailProvider = FutureProvider.autoDispose
    .family<ArticleDetailData, String>((ref, url) async {
      return ref.read(dynamicRepositoryProvider).getArticleDetail(url);
    });

class ArticleDetailPage extends HookConsumerWidget {
  final String url;
  final String? title;

  const ArticleDetailPage({super.key, required this.url, this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final provider = articleDetailProvider(url);
    final state = ref.watch(provider);
    final commentController = useTextEditingController();
    final comments = useState<List<CommentItem>>(<CommentItem>[]);
    final commentsLoading = useState(false);
    final commentsError = useState<String?>(null);
    final commentsNext = useState<int?>(null);
    final commentsHasMore = useState(true);
    final sendingComment = useState(false);

    if (state.isLoading && !state.hasValue) {
      return Scaffold(
        appBar: AppBar(title: Text(title ?? t.moments.detail_title)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (state.hasError && !state.hasValue) {
      return Scaffold(
        appBar: AppBar(title: Text(title ?? t.moments.detail_title)),
        body: Center(
          child: AppErrorWidget(
            error: state.error!,
            onRetry: () => ref.refresh(provider.future),
          ),
        ),
      );
    }

    final data = state.value;
    if (data == null) {
      return Scaffold(
        appBar: AppBar(title: Text(title ?? t.moments.detail_title)),
        body: Center(child: AppErrorWidget(message: t.common.no_content)),
      );
    }

    final commentsEnabled = data.commentOid.isNotEmpty;

    void showSnack(String message) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }

    Future<void> loadComments(ArticleDetailData detail, {bool refresh = false}) async {
      if (!commentsEnabled) {
        commentsLoading.value = false;
        commentsError.value = null;
        commentsHasMore.value = false;
        return;
      }
      if (commentsLoading.value && !refresh) return;

      final previousComments = List<CommentItem>.from(comments.value);
      final previousNext = commentsNext.value;
      final previousHasMore = commentsHasMore.value;
      commentsLoading.value = true;
      commentsError.value = null;
      if (refresh) {
        commentsNext.value = null;
        commentsHasMore.value = true;
      }

      try {
        final response = await ref
            .read(dynamicRepositoryProvider)
            .getArticleCommentList(
              oid: detail.commentOid,
              next: refresh ? null : commentsNext.value,
              referer: detail.url,
            );
        final nextComments = refresh
            ? response.replies
            : _appendUniqueComments(previousComments, response.replies);
        comments.value = nextComments;
        commentsNext.value = response.cursor?.next;
        commentsHasMore.value = _resolveHasMore(response);
      } catch (error) {
        commentsError.value = error.toString();
        if (refresh) {
          comments.value = previousComments;
          commentsNext.value = previousNext;
          commentsHasMore.value = previousHasMore;
        }
      } finally {
        commentsLoading.value = false;
      }
    }

    Future<void> refreshAll() async {
      final refreshed = await ref.refresh(provider.future);
      if (context.mounted) {
        await loadComments(refreshed, refresh: true);
      }
    }

    Future<void> submitComment() async {
      final detail = state.value;
      if (detail == null) return;
      if (!commentsEnabled) {
        showSnack(t.video.comment.empty);
        return;
      }
      final message = commentController.text.trim();
      if (message.isEmpty || sendingComment.value) return;

      sendingComment.value = true;
      var sent = false;
      try {
        await ref
            .read(dynamicRepositoryProvider)
            .addCommentReply(
              oid: detail.commentOid,
              type: detail.commentType,
              root: 0,
              parent: 0,
              message: message,
              referer: detail.url,
            );
        sent = true;
      } catch (e) {
        showSnack(e.toString());
      } finally {
        sendingComment.value = false;
      }

      if (!sent) return;
      if (context.mounted) {
        commentController.clear();
        FocusScope.of(context).unfocus();
      }
      await loadComments(detail, refresh: true);
    }

    Future<void> submitReply(CommentItem item, String message) async {
      final detail = state.value;
      if (detail == null) return;
      if (!commentsEnabled) {
        showSnack(t.video.comment.empty);
        return;
      }
      try {
        await ref
            .read(dynamicRepositoryProvider)
            .addCommentReply(
              oid: detail.commentOid,
              type: detail.commentType,
              root: item.root == 0 ? item.rpid : item.root,
              parent: item.rpid,
              message: message,
              referer: detail.url,
            );
        await loadComments(detail, refresh: true);
      } catch (e) {
        showSnack(e.toString());
      }
    }

    Future<void> toggleCommentLike(CommentItem item) async {
      final detail = state.value;
      if (detail == null) return;
      final isLiked = item.action == 1;
      final previous = comments.value;

      final updated = previous.map((comment) {
        if (comment.rpid == item.rpid) {
          return comment.copyWith(
            action: isLiked ? 0 : 1,
            like: isLiked ? math.max(0, comment.like - 1) : comment.like + 1,
          );
        }
        return comment;
      }).toList();
      comments.value = updated;

      try {
        await ref
            .read(dynamicRepositoryProvider)
            .likeCommentByTarget(
              oid: detail.commentOid,
              type: detail.commentType,
              rpid: item.rpid,
              isLiked: !isLiked,
              referer: detail.url,
            );
      } catch (_) {
        comments.value = previous;
      }
    }

    useEffect(() {
      if (commentsEnabled && comments.value.isEmpty && !commentsLoading.value) {
        Future.microtask(() => loadComments(data, refresh: true));
      }
      return null;
    }, [data.commentOid, commentsEnabled]);

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
        onRefresh: refreshAll,
        onLoad: commentsEnabled && commentsHasMore.value
            ? () async {
                if (!commentsLoading.value) {
                  await loadComments(data);
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
            if (comments.value.isEmpty && commentsLoading.value)
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
                    onRetry: () => loadComments(data, refresh: true),
                  ),
                ),
              )
            else if (comments.value.isEmpty && commentsError.value != null)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: AppErrorWidget(
                    message: commentsError.value!,
                    onRetry: () => loadComments(data, refresh: true),
                  ),
                ),
              )
            else if (comments.value.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: AppErrorWidget(
                    message: t.video.comment.empty,
                    onRetry: () => loadComments(data, refresh: true),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = comments.value[index];
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
                      if (index < comments.value.length - 1)
                        Divider(
                          height: 1,
                          thickness: 0.5,
                          indent: 16,
                          endIndent: 16,
                          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
                        ),
                    ],
                  );
                }, childCount: comments.value.length),
              ),
            if (commentsLoading.value)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                ),
              ),
            if (commentsError.value != null && comments.value.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: AppErrorWidget(
                    message: commentsError.value!,
                    onRetry: () => loadComments(data, refresh: true),
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
              isSending: sendingComment.value,
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
        textAlign: widget.block.align ?? TextAlign.start,
      ),
    );
  }

  Alignment _alignToAlignment(TextAlign? align) {
    switch (align) {
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.right:
      case TextAlign.end:
        return Alignment.centerRight;
      case TextAlign.justify:
      case TextAlign.left:
      case TextAlign.start:
      case null:
        return Alignment.centerLeft;
    }
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

bool _resolveHasMore(CommentResponse data) {
  return !(data.cursor?.isEnd ?? true);
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

List<CommentItem> _appendUniqueComments(
  List<CommentItem> current,
  List<CommentItem> incoming,
) {
  if (incoming.isEmpty) return current;
  final merged = <int, CommentItem>{for (final item in current) item.rpid: item};
  for (final item in incoming) {
    merged[item.rpid] = item;
  }
  return merged.values.toList();
}
