import 'package:culcul/data/models/notification/reply_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/notification/data/notification_repository.dart';

part 'reply_view_model.g.dart';

@riverpod
class ReplyList extends _$ReplyList {
  @override
  FutureOr<List<ReplyItem>> build() async {
    final data = await ref.read(notificationRepositoryProvider).getReplyList();
    return data.items;
  }

  Future<void> loadMore() async {
    final currentList = state.value ?? [];
    if (currentList.isEmpty) return;

    final lastItem = currentList.last;
    final data = await ref
        .read(notificationRepositoryProvider)
        .getReplyList(id: lastItem.id, replyTime: lastItem.replyTime);
    state = AsyncData([...currentList, ...data.items]);
  }
}
