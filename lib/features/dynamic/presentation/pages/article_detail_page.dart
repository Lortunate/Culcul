import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/shared/utils/format_utils.dart';
import 'package:culcul/shared/utils/share_utils.dart';
import 'package:culcul/features/dynamic/presentation/view_models/article_detail_view_model.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_comment_composer.dart';
import 'package:culcul/features/video/video.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/shared/pagination/pagination_load_gate.dart';
import 'package:culcul/shared/pagination/scroll_load_trigger.dart';
import 'package:culcul/shared/widgets/app_empty_state_widget.dart';
import 'package:culcul/shared/widgets/app_error_widget.dart';
import 'package:culcul/shared/widgets/app_image_preview.dart';
import 'package:culcul/shared/widgets/app_network_image.dart';
import 'package:culcul/shared/widgets/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

part 'article_detail_page_block_renderers.paragraph.dart';
part 'article_detail_page_block_renderers.cards.dart';
part 'article_detail_page_blocks.dart';
part 'article_detail_page_comment_bar.dart';
part 'article_detail_page_shell.dart';
part 'article_detail_page_sections.dart';
part 'article_detail_page_scaffold.dart';

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
    final commentsLoadGate = useMemoized(PaginationLoadGate.new, [url]);
    final commentController = useTextEditingController();

    if (state.isLoading && state.detail == null) {
      return buildArticleLoadingScaffold(context: context, title: title);
    }

    if (state.error != null && state.detail == null) {
      return buildArticleErrorScaffold(
        context: context,
        title: title,
        error: state.error!,
        onRetry: notifier.refreshAll,
      );
    }

    final data = state.detail;
    if (data == null) {
      return buildArticleEmptyScaffold(
        context: context,
        title: title,
        onRetry: notifier.refreshAll,
      );
    }

    final commentsEnabled = state.commentsEnabled;
    final canLoadMore = commentsEnabled && state.commentsHasMore;

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

    Future<IndicatorResult> loadMoreComments() {
      return ScrollLoadTrigger.runWithNotifier(
        gate: commentsLoadGate,
        hasMore: () {
          final latest = ref.read(provider);
          return latest.commentsEnabled && latest.commentsHasMore;
        },
        isLoadingMore: () => ref.read(provider).commentsLoading,
        loadMore: notifier.loadComments,
        itemCount: () => ref.read(provider).comments.length,
        source: 'dynamic.article_comments',
      );
    }

    return buildArticleDetailScaffold(
      context: context,
      t: t,
      data: data,
      title: title,
      state: state,
      notifier: notifier,
      canLoadMore: canLoadMore,
      onRefresh: notifier.refreshAll,
      onLoadMore: canLoadMore ? loadMoreComments : null,
      commentsEnabled: commentsEnabled,
      commentController: commentController,
      onSubmitComment: submitComment,
      onSubmitReply: submitReply,
      onToggleCommentLike: toggleCommentLike,
    );
  }
}
