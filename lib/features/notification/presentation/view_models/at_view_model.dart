import 'package:culcul/features/notification/application/notification_workflows.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'at_view_model.g.dart';

@riverpod
class AtList extends _$AtList {
  @override
  FutureOr<List<NotificationEntry>> build() async {
    final result = await ref.read(notificationWorkflowsProvider).getAtList();
    return result.when(success: (data) => data, failure: (error) => throw error);
  }

  Future<void> loadMore() async {
    final currentList = state.value ?? [];
    if (currentList.isEmpty) return;

    final lastItem = currentList.last;
    final result = await ref
        .read(notificationWorkflowsProvider)
        .getAtList(id: lastItem.id, atTime: lastItem.replyTime ?? 0);
    result.when(
      success: (data) => state = AsyncData([...currentList, ...data]),
      failure: (_) {},
    );
  }
}
