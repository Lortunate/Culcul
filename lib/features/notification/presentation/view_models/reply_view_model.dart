import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reply_view_model.g.dart';

@riverpod
class ReplyList extends _$ReplyList {
  @override
  FutureOr<List<NotificationEntry>> build() async {
    return ref.read(notificationRepositoryProvider).getReplyList();
  }

  Future<void> loadMore() async {
    final currentList = state.value ?? [];
    if (currentList.isEmpty) return;

    final lastItem = currentList.last;
    try {
      final data = await ref
          .read(notificationRepositoryProvider)
          .getReplyList(id: lastItem.id, replyTime: lastItem.replyTime);
      state = AsyncData([...currentList, ...data]);
    } catch (_) {
      // Keep current state on pagination failure.
    }
  }
}
