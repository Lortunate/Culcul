import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/data/models/notification/unread_count_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unread_count_controller.g.dart';

@riverpod
class UnreadCount extends _$UnreadCount {
  @override
  FutureOr<UnreadCountModel> build() async {
    final result = await ref.read(notificationRepositoryProvider).getUnreadCount();
    return switch (result) {
      Success(value: final data) => data,
      Failure(exception: final e) => throw e,
    };
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await build());
  }
}

