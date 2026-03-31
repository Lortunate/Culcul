import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'at_view_model.g.dart';

@riverpod
class AtList extends _$AtList {
  @override
  FutureOr<List<NotificationEntry>> build() async {
    return ref.read(notificationRepositoryProvider).getAtList();
  }

  Future<void> loadMore() async {
    final currentList = state.value ?? [];
    if (currentList.isEmpty) return;

    final lastItem = currentList.last;
    try {
      final data = await ref
          .read(notificationRepositoryProvider)
          .getAtList(id: lastItem.id, atTime: lastItem.replyTime ?? 0);
      state = AsyncData([...currentList, ...data]);
    } catch (_) {
      // Keep current state on pagination failure.
    }
  }
}
