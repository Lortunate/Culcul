import 'dart:async';

import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/features/video/presentation/view_models/comment_reply_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/comments/comment_reply_sheet.dart';
import 'package:culcul/shared/pagination/pagination_load_gate.dart';
import 'package:culcul/shared/pagination/scroll_load_trigger.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef PresentCommentReplySheet =
    void Function({
      required CommentItem comment,
      required Future<void> Function(String text) onSend,
    });

class CommentReplyPageCommands {
  CommentReplyPageCommands({
    required this.loadGate,
    required this.presentReplySheet,
    required this.addReply,
    required this.hasMoreReplies,
    required this.isLoadingMoreReplies,
    required this.loadMoreRepliesFromController,
    required this.currentReplyCount,
    this.loadMoreSource = 'video.comment_reply',
  });

  factory CommentReplyPageCommands.fromPage({
    required BuildContext context,
    required WidgetRef ref,
    required int oid,
    required int rootId,
    required PaginationLoadGate loadGate,
  }) {
    final provider = commentReplyControllerProvider(oid, rootId);
    final controller = ref.read(provider.notifier);

    return CommentReplyPageCommands(
      loadGate: loadGate,
      presentReplySheet: ({required comment, required onSend}) {
        CommentReplySheet.show(
          context,
          comment: comment,
          onSend: (text) {
            unawaited(onSend(text));
          },
        );
      },
      addReply: controller.addReply,
      hasMoreReplies: () => ref.read(provider).paging.hasMore,
      isLoadingMoreReplies: () => ref.read(provider).paging.isLoadingMore,
      loadMoreRepliesFromController: controller.loadMore,
      currentReplyCount: () => ref.read(provider).paging.items.length,
    );
  }

  final PaginationLoadGate loadGate;
  final PresentCommentReplySheet presentReplySheet;
  final Future<void> Function(int oid, int root, int parent, String text) addReply;
  final bool Function() hasMoreReplies;
  final bool Function() isLoadingMoreReplies;
  final Future<void> Function() loadMoreRepliesFromController;
  final int Function() currentReplyCount;
  final String loadMoreSource;

  void showReplySheet(CommentItem item) {
    presentReplySheet(
      comment: item,
      onSend: (text) async {
        await addReply(item.oid, item.root == 0 ? item.rpid : item.root, item.rpid, text);
      },
    );
  }

  Future<void> loadMoreReplies() {
    return ScrollLoadTrigger.runWithNotifier(
      gate: loadGate,
      hasMore: hasMoreReplies,
      isLoadingMore: isLoadingMoreReplies,
      loadMore: loadMoreRepliesFromController,
      itemCount: currentReplyCount,
      source: loadMoreSource,
    );
  }
}
