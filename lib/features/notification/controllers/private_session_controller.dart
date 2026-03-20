import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/models/notification/private_message_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'private_session_controller.g.dart';

@riverpod
class PrivateSessionList extends _$PrivateSessionList {
  int? _endTs;
  bool _hasMore = true;

  @override
  FutureOr<List<PrivateMessageSession>> build() async {
    _endTs = null;
    _hasMore = true;
    final result = await ref.read(notificationRepositoryProvider).getPrivateSessions();

    return switch (result) {
      Success(value: final data) => () {
        if (data.sessionList != null && data.sessionList!.isNotEmpty) {
          _endTs = data.sessionList!.last.sessionTs;
        }
        _hasMore = data.hasMore == 1;
        // Filter out system messages (session_type != 1) if needed,
        // but API returns them mixed. The UI handles specific system types.
        // Assuming we want to show all sessions.
        return data.sessionList ?? [];
      }(),
      Failure(exception: final e) => throw e,
    };
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    final currentState = state.value;
    if (currentState == null) return;

    final result = await ref.read(notificationRepositoryProvider).getPrivateSessions(
      endTs: _endTs,
    );

    switch (result) {
      case Success(value: final data):
        if (data.sessionList != null && data.sessionList!.isNotEmpty) {
          _endTs = data.sessionList!.last.sessionTs;
          state = AsyncData([...currentState, ...data.sessionList!]);
        }
        _hasMore = data.hasMore == 1;
      case Failure(exception: final e):
        state = AsyncError(e, StackTrace.current);
    }
  }
}
