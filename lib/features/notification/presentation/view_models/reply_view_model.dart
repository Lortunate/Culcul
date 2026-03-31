import 'package:culcul/features/notification/application/notification_workflows.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reply_view_model.g.dart';

@riverpod
class ReplyList extends _$ReplyList {
  @override
  FutureOr<List<NotificationEntry>> build() async {
    final result = await ref.read(notificationWorkflowsProvider).getReplyList();
    return result.when(success: (data) => data, failure: (error) => throw error);
  }

  Future<void> loadMore() async {
    final currentList = state.value ?? [];
    if (currentList.isEmpty) return;

    final lastItem = currentList.last;
    final result = await ref
        .read(notificationWorkflowsProvider)
        .getReplyList(id: lastItem.id, replyTime: lastItem.replyTime);
    result.when(
      success: (data) => state = AsyncData([...currentList, ...data]),
      failure: (_) {},
    );
  }
}
