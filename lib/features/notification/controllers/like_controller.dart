import 'package:culcul/data/models/notification/reply_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/notification/data/notification_repository.dart';

part 'like_controller.g.dart';

@riverpod
class LikeList extends _$LikeList {
  @override
  FutureOr<List<ReplyItem>> build() async {
    final data = await ref.read(notificationRepositoryProvider).getLikeList();
    return data.items;
  }

  Future<void> loadMore() async {
    final currentList = state.value ?? [];
    if (currentList.isEmpty) return;

    final lastItem = currentList.last;
    final data = await ref
        .read(notificationRepositoryProvider)
        .getLikeList(id: lastItem.id, likeTime: lastItem.likeTime);
    state = AsyncData([...currentList, ...data.items]);
  }
}
