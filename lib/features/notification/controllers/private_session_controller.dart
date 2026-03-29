import 'package:culcul/data/models/notification/private_message_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/notification/data/notification_repository.dart';

part 'private_session_controller.g.dart';

@riverpod
class PrivateSessionList extends _$PrivateSessionList {
  int? _endTs;
  bool _hasMore = true;

  @override
  FutureOr<List<PrivateMessageSession>> build() async {
    _endTs = null;
    _hasMore = true;
    final data = await ref.read(notificationRepositoryProvider).getPrivateSessions();
    if (data.sessionList != null && data.sessionList!.isNotEmpty) {
      _endTs = data.sessionList!.last.sessionTs;
    }
    _hasMore = data.hasMore == 1;
    return data.sessionList ?? [];
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    final currentState = state.value;
    if (currentState == null) return;

    final data = await ref
        .read(notificationRepositoryProvider)
        .getPrivateSessions(endTs: _endTs);
    if (data.sessionList != null && data.sessionList!.isNotEmpty) {
      _endTs = data.sessionList!.last.sessionTs;
      state = AsyncData([...currentState, ...data.sessionList!]);
    }
    _hasMore = data.hasMore == 1;
  }
}
