import 'package:culcul/data/models/notification/reply_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/notification/data/notification_repository.dart';

part 'at_view_model.g.dart';

@riverpod
class AtList extends _$AtList {
  @override
  FutureOr<List<ReplyItem>> build() async {
    final data = await ref.read(notificationRepositoryProvider).getAtList();
    return data.items;
  }

  Future<void> loadMore() async {
    final currentList = state.value ?? [];
    if (currentList.isEmpty) return;

    final lastItem = currentList.last;
    final data = await ref
        .read(notificationRepositoryProvider)
        .getAtList(id: lastItem.id, atTime: lastItem.replyTime ?? 0);
    state = AsyncData([...currentList, ...data.items]);
  }
}
