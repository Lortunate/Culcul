import 'package:cilixili/data/models/video/comment_model.dart';
import 'package:cilixili/features/video/reply/comment_reply_controller.dart';
import 'package:cilixili/features/video/widgets/bottom_input_bar.dart';
import 'package:cilixili/features/video/widgets/comment_item.dart';
import 'package:cilixili/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommentReplyPage extends ConsumerWidget {
  final int oid;
  final int rootId;
  final CommentItem rootComment;

  const CommentReplyPage({
    super.key,
    required this.oid,
    required this.rootId,
    required this.rootComment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commentReplyControllerProvider(oid, rootId));
    final controller = ref.read(
      commentReplyControllerProvider(oid, rootId).notifier,
    );
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.video.comment_detail,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFE3E5E7),
            height: 0.5,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (!state.isLoading &&
                    state.hasMore &&
                    notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent - 200) {
                  controller.loadMore();
                }
                return false;
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        CommentItemWidget(
                          item: rootComment,
                          showRepliesPreview: false,
                        ),
                        Container(
                          height: 10,
                          color: isDark
                              ? const Color(0xFF18191C)
                              : const Color(0xFFF1F2F3),
                        ),
                        if (state.replies.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                            child: Row(
                              children: [
                                Text(
                                  t.video.related_replies,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (state.replies.isEmpty && state.isLoading)
                    const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return CommentItemWidget(
                          item: state.replies[index],
                          showRepliesPreview: false,
                        );
                      }, childCount: state.replies.length),
                    ),
                  if (state.isLoading && state.replies.isNotEmpty)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),

                  // Padding for bottom bar
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                ],
              ),
            ),
          ),
          const BottomInputBar(),
        ],
      ),
    );
  }
}
