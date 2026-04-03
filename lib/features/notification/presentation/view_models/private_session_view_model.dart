import 'dart:async';

import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/notification.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'private_session_view_model.g.dart';

@riverpod
class PrivateSessionList extends _$PrivateSessionList
    with CursorPagedAsyncNotifier<PrivateSession, int> {
  @override
  FutureOr<List<PrivateSession>> build() async {
    final firstPage = await buildFirstPage();
    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid != null) {
      unawaited(_syncHeadAndRefresh(ownerUid));
    }
    return firstPage;
  }

  @override
  Future<CursorPage<PrivateSession, int>> fetchPage(
    int? currentCursor, {
    bool refresh = false,
  }) async {
    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid == null) {
      return const CursorPage(items: [], nextCursor: null, hasMore: false);
    }

    final repository = ref.read(notificationRepositoryProvider);
    if (refresh || currentCursor == null) {
      await repository.syncSessions(ownerUid: ownerUid, force: true);
    } else {
      await repository.syncSessionsOlder(
        ownerUid: ownerUid,
        sessionType: PrivateSessionType.user,
        endTs: currentCursor,
      );
    }

    final sessions = await repository.pageSessionsFromLocal(
      ownerUid: ownerUid,
      sessionType: PrivateSessionType.user,
      endTs: currentCursor,
    );

    return CursorPage(
      items: sessions,
      nextCursor: sessions.isEmpty ? currentCursor : sessions.last.sessionTs,
      hasMore: sessions.length >= 20,
    );
  }

  @override
  Object itemId(PrivateSession item) => item.talkerId;

  Future<void> loadMore() {
    return loadNextPage();
  }

  Future<void> _syncHeadAndRefresh(int ownerUid) async {
    try {
      await ref.read(notificationRepositoryProvider).syncSessions(ownerUid: ownerUid);
      await refreshPage();
    } catch (_) {}
  }
}
