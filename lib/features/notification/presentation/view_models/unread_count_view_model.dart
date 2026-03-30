import 'package:culcul/features/notification/application/use_case/notification_use_cases.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unread_count_view_model.g.dart';

@riverpod
class UnreadCount extends _$UnreadCount {
  @override
  FutureOr<NotificationSummary> build() async {
    final result = await ref.read(notificationUseCasesProvider).getUnreadCount();
    return result.when(success: (value) => value, failure: (error) => throw error);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await build());
  }
}
