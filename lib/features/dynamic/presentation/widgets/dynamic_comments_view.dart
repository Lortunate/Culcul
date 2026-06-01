import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/features/dynamic/application/dynamic_comment_controller.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation_scope.dart';
import 'package:culcul/ui/assemblies/comments/comment_item.dart';
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
      return _DynamicCommentsEmptyState(onRefresh: controller.refresh);
    }

    return _DynamicCommentsList(
      comments: paging.items,
      onTapUser: (context, mid) => DynamicNavigationScope.of(context).onOpenUser(mid),
      onLike: controller.toggleLike,
      onReply: (context, comment) => _showReplySheet(context, ref, comment),
    );
  }

  void _showReplySheet(BuildContext context, WidgetRef ref, CommentItem comment) {
    final theme = Theme.of(context);
    final notifier = ref.read(dynamicCommentControllerProvider(post).notifier);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return _ReplySheetContent(
          comment: comment,
          theme: theme,
          t: t,
          onSubmit: (text) {
            notifier.addReply(comment.rpid, comment.root, text);
          },
        );
      },
    );
  }
}

class _DynamicCommentsEmptyState extends StatelessWidget {
  final VoidCallback onRefresh;

  const _DynamicCommentsEmptyState({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: GestureDetector(
          onTap: onRefresh,
          behavior: HitTestBehavior.opaque,
          child: Center(child: Text(t.moments.no_comments)),
        ),
      ),
    );
  }
}

class _DynamicCommentsList extends StatelessWidget {
  final List<CommentItem> comments;
  final void Function(BuildContext context, int mid) onTapUser;
  final void Function(int rpid, bool isLiked) onLike;
  final void Function(BuildContext context, CommentItem comment) onReply;

  const _DynamicCommentsList({
    required this.comments,
    required this.onTapUser,
    required this.onLike,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final comment = comments[index];
        return KeyedSubtree(
          key: ValueKey('dynamic_comment_${comment.rpid}_$index'),
          child: CommentItemWidget(
            item: comment,
            onTapUser: (mid) => onTapUser(context, mid),
            onLike: () => onLike(comment.rpid, comment.action == 1),
            onReply: () => onReply(context, comment),
          ),
        );
      }, childCount: comments.length),
    );
  }
}

class _ReplySheetContent extends StatefulWidget {
  final CommentItem comment;
  final ThemeData theme;
  final Translations t;
  final ValueChanged<String> onSubmit;

  const _ReplySheetContent({
    required this.comment,
    required this.theme,
    required this.t,
    required this.onSubmit,
  });

  @override
  State<_ReplySheetContent> createState() => _ReplySheetContentState();
}

class _ReplySheetContentState extends State<_ReplySheetContent> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                widget.t.video.reply_to(name: widget.comment.member.uname),
                style: widget.theme.textTheme.titleMedium,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: widget.t.moments.comment_hint,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            maxLines: 3,
            minLines: 1,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: () {
                final text = _controller.text.trim();
                if (text.isNotEmpty) {
                  widget.onSubmit(text);
                  Navigator.pop(context);
                }
              },
              child: Text(widget.t.moments.publish),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
