// ignore_for_file: invalid_use_of_internal_member
import 'package:culcul/data/models/notification/private_message_model.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/repositories/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'private_session_provider.g.dart';

@riverpod
class PrivateSessionList extends _$PrivateSessionList {
  bool _hasMore = true;

  @override
  Future<List<PrivateMessageSession>> build({int sessionType = 1}) async {
    _hasMore = true;
    final response = await ref
        .read(notificationRepositoryProvider)
        .getPrivateSessions(sessionType: sessionType);
    _hasMore = response.hasMore == 1;
    return response.sessionList ?? [];
  }

  Future<void> loadMore() async {
    final oldState = state;
    if (oldState is! AsyncData || oldState.isLoading || !_hasMore) return;

    state = AsyncLoading<List<PrivateMessageSession>>().copyWithPrevious(
      oldState,
    );

    try {
      final lastTs = oldState.value?.lastOrNull?.sessionTs;

      final response = await ref
          .read(notificationRepositoryProvider)
          .getPrivateSessions(sessionType: sessionType, endTs: lastTs);

      _hasMore = response.hasMore == 1;

      final newItems = response.sessionList ?? [];

      state = AsyncData([...oldState.value!, ...newItems]);
    } catch (e, st) {
      state = AsyncError<List<PrivateMessageSession>>(
        e,
        st,
      ).copyWithPrevious(oldState);
    }
  }
}
