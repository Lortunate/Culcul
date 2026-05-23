import 'dart:async';

import 'package:culcul/features/notification/application/notification_private_session_application_providers.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'private_session_view_model.g.dart';

@Riverpod(keepAlive: true)
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
  Future<CursorPage<PrivateSession, int>> fetchPage(int? currentCursor) async {
    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid == null) {
      return const CursorPage(items: [], nextCursor: null, hasMore: false);
    }

    final privateSessionPort = ref.read(notificationPrivateSessionPortProvider);
    if (isRefreshing || currentCursor == null) {
      await privateSessionPort.syncSessions(ownerUid: ownerUid, force: true);
    } else {
      await privateSessionPort.syncSessionsOlder(
        ownerUid: ownerUid,
        sessionType: PrivateSessionType.user,
        endTs: currentCursor,
      );
    }

    final sessions = await privateSessionPort.pageSessionsFromLocal(
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
      await ref
          .read(notificationPrivateSessionPortProvider)
          .syncSessions(ownerUid: ownerUid);
      await refreshPage();
    } catch (_) {}
  }
}
