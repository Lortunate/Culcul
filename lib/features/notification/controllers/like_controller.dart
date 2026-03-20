import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/models/notification/reply_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'like_controller.g.dart';

@riverpod
class LikeList extends _$LikeList {
  @override
  FutureOr<List<ReplyItem>> build() async {
    final result = await ref.read(notificationRepositoryProvider).getLikeList();
    return switch (result) {
      Success(value: final data) => data.items,
      Failure(exception: final e) => throw e,
    };
  }

  Future<void> loadMore() async {
    final currentList = state.value ?? [];
    if (currentList.isEmpty) return;

    final lastItem = currentList.last;
    final result = await ref.read(notificationRepositoryProvider).getLikeList(
      id: lastItem.id,
      likeTime: lastItem.likeTime,
    );

    switch (result) {
      case Success(value: final data):
        state = AsyncData([...currentList, ...data.items]);
      case Failure(exception: final e):
        state = AsyncError(e, StackTrace.current);
    }
  }
}
