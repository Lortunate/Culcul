import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/utils/share_utils.dart';
import 'package:culcul/features/dynamic/presentation/view_models/article_detail_view_model.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_comment_composer.dart';
import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/ui/widgets/comments/comment_item.dart';
import 'package:culcul/ui/widgets/comments/comment_reply_sheet.dart';
import 'package:culcul/ui/widgets/feedback/app_empty_state_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/media/app_image_preview.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:culcul/ui/widgets/layout/refresh_header_footer.dart';
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
      final result = await notifier.submitComment(commentController.text);
      final errorMessage = result.commentsDisabled
          ? t.video.comment.empty
          : result.errorMessage;
      if (errorMessage != null) {
        showSnack(errorMessage);
        return;
      }
      if (result.clearComposer && context.mounted) {
        commentController.clear();
      }
      if (result.unfocusComposer && context.mounted) {
        FocusScope.of(context).unfocus();
      }
    }

    Future<void> submitReply(CommentItem item, String message) async {
      final result = await notifier.submitReply(item, message);
      final errorMessage = result.commentsDisabled
          ? t.video.comment.empty
          : result.errorMessage;
      if (errorMessage != null) {
        showSnack(errorMessage);
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
