import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/application/dynamic_comment_controller.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation_scope.dart';
import 'package:culcul/ui/widgets/comments/comment_item.dart';
import 'package:culcul/ui/widgets/comments/comment_reply_sheet.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicCommentsSliver extends ConsumerWidget {
  final DynamicItem post;

  const DynamicCommentsSliver({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamicCommentControllerProvider(post));
    final controller = ref.read(dynamicCommentControllerProvider(post).notifier);
    final paging = state.paging;

    if (paging.isInitialLoading && paging.items.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (paging.error != null && paging.items.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: AppErrorWidget(error: paging.error!, onRetry: controller.refresh),
        ),
      );
    }

    if (paging.items.isEmpty) {
      final t = Translations.of(context);

      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: GestureDetector(
            onTap: controller.refresh,
            behavior: HitTestBehavior.opaque,
            child: Center(child: Text(t.moments.no_comments)),
          ),
        ),
      );
    }

    final comments = paging.items;

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final comment = comments[index];
        return KeyedSubtree(
          key: ValueKey('dynamic_comment_${comment.rpid}_$index'),
          child: CommentItemWidget(
            item: comment,
            onTapUser: (mid) {
              DynamicNavigationScope.of(context).onOpenUser(mid);
            },
            onLike: () => controller.toggleLike(comment.rpid, comment.action == 1),
            onReply: () => CommentReplySheet.show(
              context,
              comment: comment,
              onSend: (text) => controller.addReply(comment.rpid, comment.root, text),
            ),
          ),
        );
      }, childCount: comments.length),
    );
  }
}
