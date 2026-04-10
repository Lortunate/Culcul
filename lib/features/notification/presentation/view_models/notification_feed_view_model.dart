import 'dart:async';

import 'package:culcul/shared/pagination/paged_async_notifier.dart';
import 'package:culcul/features/notification/notification.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_feed_view_model.g.dart';

@riverpod
class NotificationFeedList extends _$NotificationFeedList
    with CursorPagedAsyncNotifier<NotificationEntry, NotificationFeedCursor> {
  @override
  FutureOr<List<NotificationEntry>> build(NotificationFeedType type) async {
    final firstPage = await buildFirstPage();
    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid != null) {
      unawaited(_syncHeadAndRefresh(ownerUid));
    }
    return firstPage;
  }

  @override
  Future<CursorPage<NotificationEntry, NotificationFeedCursor>> fetchPage(
    NotificationFeedCursor? cursor,
  ) async {
    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid == null || type == NotificationFeedType.system) {
      return const CursorPage(items: [], nextCursor: null, hasMore: false);
    }

    final repository = ref.read(notificationRepositoryProvider);
    if (isRefreshing || cursor == null) {
      await repository.syncFeedHead(ownerUid: ownerUid, type: type);
    } else {
      await repository.syncFeedOlder(
        ownerUid: ownerUid,
        type: type,
        cursor: cursor,
      );
    }

    final data = await repository.pageFeedFromLocal(
      ownerUid: ownerUid,
      type: type,
      cursor: cursor,
    );

    return CursorPage(
      items: data,
      nextCursor: data.isEmpty
          ? null
          : NotificationFeedCursor(id: data.last.id, time: data.last.eventTime),
      hasMore: data.length >= 20,
    );
  }

  @override
  Object itemId(NotificationEntry item) => item.id;

  Future<void> loadMore() => loadNextPage();

  Future<void> refresh() => refreshPage();

  Future<void> _syncHeadAndRefresh(int ownerUid) async {
    if (type == NotificationFeedType.system) return;
    try {
      await ref
          .read(notificationRepositoryProvider)
          .syncFeedHead(ownerUid: ownerUid, type: type);
      await refreshPage();
    } catch (_) {}
  }
}
