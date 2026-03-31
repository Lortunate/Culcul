import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'private_session_view_model.g.dart';

@riverpod
class PrivateSessionList extends _$PrivateSessionList
    with CursorPagedAsyncNotifier<PrivateSession, int> {
  @override
  FutureOr<List<PrivateSession>> build() async {
    return buildFirstPage();
  }

  @override
  Future<CursorPage<PrivateSession, int>> fetchPage(
    int? currentCursor, {
    bool refresh = false,
  }) async {
    final data = await ref
        .read(notificationRepositoryProvider)
        .getPrivateSessions(endTs: currentCursor);
    final sessions = data.sessions;
    return CursorPage(
      items: sessions,
      nextCursor: sessions.isEmpty ? currentCursor : sessions.last.sessionTs,
      hasMore: data.hasMore,
    );
  }

  @override
  Object itemId(PrivateSession item) => item.talkerId;

  Future<void> loadMore() {
    return loadNextPage();
  }
}
