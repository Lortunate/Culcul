import 'package:culcul/data/models/comment_model.dart';
import 'package:culcul/domain/entities/dynamic_post.dart';
import 'package:culcul/providers/dynamic/dynamic_comment_controller.dart';
import 'package:culcul/ui/pages/video/widgets/comment_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicCommentsSliver extends ConsumerWidget {
  final DynamicPost post;

  const DynamicCommentsSliver({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamicCommentControllerProvider(post));
    final controller = ref.read(dynamicCommentControllerProvider(post).notifier);

    if (state.isLoading && state.comments.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (state.error != null && state.comments.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('加载失败: ${state.error}'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: controller.refresh,
                  child: const Text('重试'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (state.comments.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(child: Text('暂无评论，快来抢沙发吧~')),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final comment = state.comments[index];
          return CommentItemWidget(
            item: comment,
            onLike: () => controller.toggleLike(comment.rpid, comment.action == 1),
            onDislike: () {},
            onReply: () => _showReplySheet(context, ref, comment),
          );
        },
        childCount: state.comments.length,
      ),
    );
  }

  void _showReplySheet(
    BuildContext context,
    WidgetRef ref,
    CommentItem comment,
  ) {
    final theme = Theme.of(context);
    final controller = TextEditingController();
    final notifier = ref.read(dynamicCommentControllerProvider(post).notifier);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
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
                    '回复 @${comment.member.uname}',
                    style: theme.textTheme.titleMedium,
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
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: '友善评论，文明发言',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                maxLines: 3,
                minLines: 1,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () {
                    final text = controller.text.trim();
                    if (text.isNotEmpty) {
                      notifier.addReply(comment.rpid, comment.root, text);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('发布'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
