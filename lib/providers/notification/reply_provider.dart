// ignore_for_file: invalid_use_of_internal_member
import 'package:culcul/data/models/notification/reply_model.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/repositories/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reply_provider.g.dart';

@riverpod
class ReplyList extends _$ReplyList {
  ReplyCursor? _cursor;

  @override
  Future<List<ReplyItem>> build() async {
    _cursor = null;
    final response = await ref
        .read(notificationRepositoryProvider)
        .getReplyList();
    _cursor = response.cursor;
    return response.items;
  }

  Future<void> loadMore() async {
    final oldState = state;
    if (oldState is! AsyncData || oldState.isLoading) return;
    if (_cursor == null || _cursor!.isEnd) return;

    state = AsyncLoading<List<ReplyItem>>().copyWithPrevious(oldState);

    try {
      final response = await ref
          .read(notificationRepositoryProvider)
          .getReplyList(id: _cursor!.id, replyTime: _cursor!.time);
      _cursor = response.cursor;

      state = AsyncData([...oldState.value!, ...response.items]);
    } catch (e, st) {
      state = AsyncError<List<ReplyItem>>(e, st).copyWithPrevious(oldState);
    }
  }
}
