import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/notification.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unread_count_view_model.g.dart';

@riverpod
class UnreadCount extends _$UnreadCount {
  @override
  FutureOr<NotificationSummary> build() async {
    final result = await ref.read(notificationRepositoryProvider).getUnreadCount();
    return result.when(
      success: (summary) => summary,
      failure: (error) => throw error.toException(),
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await build());
  }
}
