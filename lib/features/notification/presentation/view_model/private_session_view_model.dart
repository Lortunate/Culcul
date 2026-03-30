import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/data/models/notification/private_message_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/notification/data/notification_repository.dart';

part 'private_session_view_model.g.dart';

@riverpod
class PrivateSessionList extends _$PrivateSessionList
    with CursorPagedAsyncNotifier<PrivateMessageSession, int> {
  @override
  FutureOr<List<PrivateMessageSession>> build() async {
    return buildFirstPage();
  }

  @override
  Future<CursorPage<PrivateMessageSession, int>> fetchPage(
    int? currentCursor, {
    bool refresh = false,
  }) async {
    final data = await ref
        .read(notificationRepositoryProvider)
        .getPrivateSessions(endTs: currentCursor);
    final sessions = data.sessionList ?? const <PrivateMessageSession>[];
    return CursorPage(
      items: sessions,
      nextCursor: sessions.isEmpty ? currentCursor : sessions.last.sessionTs,
      hasMore: data.hasMore == 1,
    );
  }

  @override
  Object itemId(PrivateMessageSession item) => item.talkerId;

  Future<void> loadMore() {
    return loadNextPage();
  }
}
