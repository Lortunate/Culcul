part of 'video_comments_view.dart';

class _VideoCommentsPagingBody extends StatelessWidget {
  final List<CommentItem> comments;
  final bool hasMore;
  final Future<void> Function() onRefresh;
  final Future<void> Function()? onLoad;
  final Widget Function(BuildContext context, CommentItem comment, int index) itemBuilder;

  const _VideoCommentsPagingBody({
    required this.comments,
    required this.hasMore,
    required this.onRefresh,
    required this.onLoad,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      onRefresh: onRefresh,
      onLoad: onLoad,
      header: const AppRefreshHeader(),
      footer: hasMore ? const AppLoadFooter() : null,
      child: _VideoCommentsList(comments: comments, itemBuilder: itemBuilder),
    );
  }
}

class _VideoCommentsList extends StatelessWidget {
  final List<CommentItem> comments;
  final Widget Function(BuildContext context, CommentItem comment, int index) itemBuilder;

  const _VideoCommentsList({required this.comments, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      cacheExtent: 520,
      padding: const EdgeInsets.symmetric(vertical: CulculSpacing.xxs),
      itemCount: comments.length,
      separatorBuilder: (context, index) {
        return Divider(
          height: 1,
          thickness: 0.5,
          indent: 16,
          endIndent: 16,
          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
        );
      },
      itemBuilder: (context, index) {
        return itemBuilder(context, comments[index], index);
      },
    );
  }
}

class _VideoCommentListItem extends StatelessWidget {
  final int? aid;
  final int? upperMid;
  final CommentItem comment;
  final VideoCommentsController notifier;
  final ValueChanged<int> onOpenUser;
  final OpenVideoCommentReplies onOpenCommentReplies;

  const _VideoCommentListItem({
    super.key,
    required this.aid,
    required this.upperMid,
    required this.comment,
    required this.notifier,
    required this.onOpenUser,
    required this.onOpenCommentReplies,
  });

  @override
  Widget build(BuildContext context) {
    return CommentItemWidget(
      item: comment,
      upperMid: upperMid,
      onTapUser: onOpenUser,
      onLike: () {
        notifier.toggleCommentLike(comment.oid, comment.rpid, comment.action == 1);
      },
      onDislike: () {
        notifier.toggleCommentDislike(comment.oid, comment.rpid);
      },
      onReply: () {
        CommentReplySheet.show(
          context,
          comment: comment,
          onSend: (text) {
            notifier.addReply(
              comment.oid,
              comment.root == 0 ? comment.rpid : comment.root,
              comment.rpid,
              text,
            );
          },
        );
      },
      onTapReplies: () {
        if (aid != null) {
          onOpenCommentReplies(
            oid: aid!,
            rootId: comment.rpid,
            comment: comment,
            upperMid: upperMid,
          );
        }
      },
    );
  }
}
