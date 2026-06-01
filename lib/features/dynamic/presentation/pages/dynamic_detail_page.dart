import 'dart:async';

import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/dynamic/application/dynamic_comment_controller.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_item_extensions.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_detail_bottom_bar.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_post_header.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_comments_view.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_content_widget.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/layout/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _dynamicDetailProvider =
    NotifierProvider.family<_DynamicDetailController, _DynamicDetailState, String>(
      _DynamicDetailController.new,
    );

class _DynamicDetailState {
  const _DynamicDetailState({this.post, this.isLoading = true, this.error});

  final DynamicItem? post;
  final bool isLoading;
  final AppError? error;

  _DynamicDetailState copyWith({
    DynamicItem? post,
    bool? isLoading,
    AppError? error,
    bool clearError = false,
  }) {
    return _DynamicDetailState(
      post: post ?? this.post,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
    );
  }
}

class _DynamicDetailController extends Notifier<_DynamicDetailState> {
  _DynamicDetailController(this.dynamicId);

  final String dynamicId;

  @override
  _DynamicDetailState build() {
    unawaited(Future<void>.microtask(loadDetail));
    return const _DynamicDetailState();
  }

  Future<void> loadDetail() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await ref.read(dynamicRepositoryProvider).getDetail(dynamicId);
    state = result.when(
      success: (data) => state.copyWith(post: data, isLoading: false, clearError: true),
      failure: (error) => state.copyWith(isLoading: false, error: error),
    );
  }

  Future<String?> toggleLike() async {
    final item = state.post;
    if (item == null) return null;

    final newStatus = !item.isLiked;
    final newLikeCount = item.likeCount + (newStatus ? 1 : -1);
    final newStatLike = item.modules.moduleStat?.like.copyWith(
      count: newLikeCount,
      status: newStatus,
    );

    if (item.modules.moduleStat == null || newStatLike == null) return null;

    final nextItem = item.copyWith(
      modules: item.modules.copyWith(
        moduleStat: item.modules.moduleStat!.copyWith(like: newStatLike),
      ),
    );

    state = state.copyWith(post: nextItem);
    final result = await ref
        .read(dynamicRepositoryProvider)
        .likeDynamic(item.id, newStatus);
    if (result.isFailure) {
      state = state.copyWith(post: item);
      return result.errorOrNull?.message;
    }
    return null;
  }
}

class DynamicDetailPage extends HookConsumerWidget {
  final String dynamicId;

  const DynamicDetailPage({super.key, required this.dynamicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final provider = _dynamicDetailProvider(dynamicId);
    final state = ref.watch(provider);
    final commentController = useTextEditingController();
    final loadGate = useMemoized(PaginationLoadGate.new, [dynamicId]);

    Future<void> refreshDetailAndComments() async {
      await ref.read(provider.notifier).loadDetail();
      final latestPost = ref.read(provider).post;
      if (latestPost == null) {
        return;
      }
      await ref.read(dynamicCommentControllerProvider(latestPost).notifier).refresh();
    }

    Future<void> loadMoreComments() {
      return ScrollLoadTrigger.runWithNotifier(
        gate: loadGate,
        hasMore: () {
          final latestPost = ref.read(provider).post;
          if (latestPost == null) {
            return false;
          }
          return ref.read(dynamicCommentControllerProvider(latestPost)).paging.hasMore;
        },
        isLoadingMore: () {
          final latestPost = ref.read(provider).post;
          if (latestPost == null) {
            return false;
          }
          return ref
              .read(dynamicCommentControllerProvider(latestPost))
              .paging
              .isLoadingMore;
        },
        loadMore: () async {
          final latestPost = ref.read(provider).post;
          if (latestPost == null) {
            return;
          }
          await ref
              .read(dynamicCommentControllerProvider(latestPost).notifier)
              .loadMore();
        },
        itemCount: () {
          final latestPost = ref.read(provider).post;
          if (latestPost == null) {
            return 0;
          }
          return ref
              .read(dynamicCommentControllerProvider(latestPost))
              .paging
              .items
              .length;
        },
        source: 'dynamic.dynamic_detail_comments',
      );
    }

    Future<bool> submitComment(String rawText) async {
      final text = rawText.trim();
      if (text.isEmpty) {
        return false;
      }

      final latestPost = ref.read(provider).post;
      if (latestPost == null) {
        return false;
      }

      await ref
          .read(dynamicCommentControllerProvider(latestPost).notifier)
          .addReply(0, 0, text);
      return true;
    }

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
          child: AppErrorWidget(error: state.error!, onRetry: refreshDetailAndComments),
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
        onRefresh: refreshDetailAndComments,
        onLoad: !hasMore ? null : loadMoreComments,
        header: const AppRefreshHeader(),
        footer: hasMore ? const AppLoadFooter() : null,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                child: DynamicPostHeader(
                  post: post,
                  avatarSize: 42,
                  moreIcon: Icons.more_vert_rounded,
                ),
              ),
            ),
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
            final message = await ref.read(provider.notifier).toggleLike();
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

            final submitted = await submitComment(commentController.text);
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
