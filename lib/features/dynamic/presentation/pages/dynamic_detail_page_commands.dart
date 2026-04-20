import 'dart:async';

import 'package:culcul/features/dynamic/presentation/view_models/dynamic_comment_view_model.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_detail_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/shared/pagination/pagination_load_gate.dart';
import 'package:culcul/shared/pagination/scroll_load_trigger.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicDetailPageCommands {
  DynamicDetailPageCommands({
    required this.loadGate,
    required this.commentController,
    required this.hasPost,
    required this.addReplyFromCurrentPost,
    required this.toggleLike,
    required this.loadDetail,
    required this.refreshCommentsForLatestPost,
    required this.hasMoreComments,
    required this.isLoadingMoreComments,
    required this.loadMoreCommentsForLatestPost,
    required this.currentCommentCount,
    required this.showOperationFailed,
    required this.unfocus,
    this.loadMoreSource = 'dynamic.dynamic_detail_comments',
  });

  factory DynamicDetailPageCommands.fromPage({
    required BuildContext context,
    required WidgetRef ref,
    required String dynamicId,
    required TextEditingController commentController,
    required PaginationLoadGate loadGate,
  }) {
    final provider = dynamicDetailViewModelProvider(dynamicId);
    final t = Translations.of(context);

    return DynamicDetailPageCommands(
      loadGate: loadGate,
      commentController: commentController,
      hasPost: () => ref.read(provider).post != null,
      addReplyFromCurrentPost: (text) async {
        final latestPost = ref.read(provider).post;
        if (latestPost == null) {
          return;
        }
        await ref
            .read(dynamicCommentControllerProvider(latestPost).notifier)
            .addReply(0, 0, text);
      },
      toggleLike: ref.read(provider.notifier).toggleLike,
      loadDetail: ref.read(provider.notifier).loadDetail,
      refreshCommentsForLatestPost: () async {
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
      loadMoreCommentsForLatestPost: () async {
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
      showOperationFailed: (message) {
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.moments.operation_failed(message: message))),
        );
      },
      unfocus: () => FocusScope.of(context).unfocus(),
    );
  }

  final PaginationLoadGate loadGate;
  final TextEditingController commentController;
  final bool Function() hasPost;
  final Future<void> Function(String text) addReplyFromCurrentPost;
  final Future<String?> Function() toggleLike;
  final Future<void> Function() loadDetail;
  final Future<void> Function() refreshCommentsForLatestPost;
  final bool Function() hasMoreComments;
  final bool Function() isLoadingMoreComments;
  final Future<void> Function() loadMoreCommentsForLatestPost;
  final int Function() currentCommentCount;
  final void Function(String message) showOperationFailed;
  final VoidCallback unfocus;
  final String loadMoreSource;

  void submitComment() {
    if (!hasPost()) {
      return;
    }

    final text = commentController.text.trim();
    if (text.isEmpty) {
      return;
    }

    unawaited(addReplyFromCurrentPost(text));
    commentController.clear();
    unfocus();
  }

  Future<void> handleLike() async {
    final message = await toggleLike();
    if (message != null) {
      showOperationFailed(message);
    }
  }

  Future<void> refreshDetailAndComments() async {
    await loadDetail();
    await refreshCommentsForLatestPost();
  }

  Future<void> loadMoreComments() {
    return ScrollLoadTrigger.runWithNotifier(
      gate: loadGate,
      hasMore: hasMoreComments,
      isLoadingMore: isLoadingMoreComments,
      loadMore: loadMoreCommentsForLatestPost,
      itemCount: currentCommentCount,
      source: loadMoreSource,
    );
  }
}
