import 'dart:async';

import 'package:culcul/features/dynamic/application/dynamic_detail_actions.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_comment_view_model.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_detail_view_model.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_detail_bottom_bar.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_detail_header.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_comments_view.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_content_widget.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/layout/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicDetailPage extends HookConsumerWidget {
  final String dynamicId;

  const DynamicDetailPage({super.key, required this.dynamicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final provider = dynamicDetailViewModelProvider(dynamicId);
    final state = ref.watch(provider);
    final commentController = useTextEditingController();
    final loadGate = useMemoized(PaginationLoadGate.new, [dynamicId]);
    final actions = DynamicDetailActions(
      toggleLike: ref.read(provider.notifier).toggleLike,
      addReply: (root, parent, text) async {
        final latestPost = ref.read(provider).post;
        if (latestPost == null) {
          return;
        }
        await ref
            .read(dynamicCommentControllerProvider(latestPost).notifier)
            .addReply(root, parent, text);
      },
      loadGate: loadGate,
      loadDetail: ref.read(provider.notifier).loadDetail,
      refreshComments: () async {
        final latestPost = ref.read(provider).post;
        if (latestPost == null) {
          return;
        }
        await ref.read(dynamicCommentControllerProvider(latestPost).notifier).refresh();
      },
      hasMoreComments: () {
        final latestPost = ref.read(provider).post;
        if (latestPost == null) {
          return false;
        }
        return ref.read(dynamicCommentControllerProvider(latestPost)).paging.hasMore;
      },
      isLoadingMoreComments: () {
        final latestPost = ref.read(provider).post;
        if (latestPost == null) {
          return false;
        }
        return ref
            .read(dynamicCommentControllerProvider(latestPost))
            .paging
            .isLoadingMore;
      },
      loadMoreCommentsFromSource: () async {
        final latestPost = ref.read(provider).post;
        if (latestPost == null) {
          return;
        }
        await ref.read(dynamicCommentControllerProvider(latestPost).notifier).loadMore();
      },
      currentCommentCount: () {
        final latestPost = ref.read(provider).post;
        if (latestPost == null) {
          return 0;
        }
        return ref.read(dynamicCommentControllerProvider(latestPost)).paging.items.length;
      },
    );

    void showOperationFailed(String message) {
      if (!context.mounted) {
        return;
      }
      context.showAppFeedback(
        t.moments.operation_failed(message: message),
        level: AppFeedbackLevel.error,
      );
    }

    if (state.isLoading && state.post == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.error != null && state.post == null) {
      return Scaffold(
        appBar: AppBar(title: Text(t.moments.detail_title)),
        body: Center(
          child: AppErrorWidget(
            error: state.error!,
            onRetry: actions.refreshDetailAndComments,
          ),
        ),
      );
    }

    final post = state.post;
    if (post == null) return const SizedBox();
    final commentState = ref.watch(dynamicCommentControllerProvider(post));
    final hasMore = commentState.paging.hasMore;

    return Scaffold(
      appBar: AppBar(title: Text(t.moments.detail_title)),
      body: EasyRefresh(
        onRefresh: actions.refreshDetailAndComments,
        onLoad: !hasMore ? null : actions.loadMoreComments,
        header: const AppRefreshHeader(),
        footer: hasMore ? const AppLoadFooter() : null,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: DynamicDetailHeader(post: post)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DynamicContentWidget(post: post, selectableText: true),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const SliverToBoxAdapter(child: Divider(height: 1)),
            DynamicCommentsSliver(post: post),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      bottomNavigationBar: DynamicDetailBottomBar(
        post: post,
        onLike: () {
          unawaited(() async {
            final message = await actions.handleLike();
            if (message != null) {
              showOperationFailed(message);
            }
          }());
        },
        onSubmitComment: () {
          unawaited(() async {
            final latestPost = ref.read(provider).post;
            if (latestPost == null) {
              return;
            }

            final submitted = await actions.submitComment(commentController.text);
            if (!submitted) {
              return;
            }

            commentController.clear();
            if (context.mounted) {
              FocusScope.of(context).unfocus();
            }
          }());
        },
        commentController: commentController,
      ),
    );
  }
}
