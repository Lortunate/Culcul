import 'package:culcul/features/notification/application/notification_workflows.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'like_view_model.g.dart';

@riverpod
class LikeList extends _$LikeList {
  @override
  FutureOr<List<NotificationEntry>> build() async {
    final result = await ref.read(notificationWorkflowsProvider).getLikeList();
    return result.when(success: (data) => data, failure: (error) => throw error);
  }

  Future<void> loadMore() async {
    final currentList = state.value ?? [];
    if (currentList.isEmpty) return;

    final lastItem = currentList.last;
    final result = await ref
        .read(notificationWorkflowsProvider)
        .getLikeList(id: lastItem.id, likeTime: lastItem.likeTime);
    result.when(
      success: (data) => state = AsyncData([...currentList, ...data]),
      failure: (_) {},
    );
  }
}
