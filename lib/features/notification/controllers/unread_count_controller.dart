import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/models/notification/unread_count_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unread_count_controller.g.dart';

@riverpod
class UnreadCount extends _$UnreadCount {
  @override
  FutureOr<UnreadCountModel> build() async {
    return ref.read(notificationRepositoryProvider).getUnreadCount();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await build());
  }
}

