part of 'notification_repository_impl.dart';

mixin _NotificationRepositoryFacadeLocal on RequestExecutorBinding
    implements domain.NotificationRepository {
  _NotificationLocalReadStore get _localReadStore;
  _NotificationStreamWatchers get _streamWatchers;

  @override
  Future<NotificationSummary?> getUnreadCountFromLocal({required int ownerUid}) {
    return _localReadStore.getUnreadCountFromLocal(ownerUid: ownerUid);
  }

  @override
  Future<List<SystemNotice>> listSystemNoticesFromLocal({required int ownerUid}) {
    return _localReadStore.listSystemNoticesFromLocal(ownerUid: ownerUid);
  }

  @override
  Future<List<PrivateSession>> pageSessionsFromLocal({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
  }) {
    return _localReadStore.pageSessionsFromLocal(
      ownerUid: ownerUid,
      sessionType: sessionType,
      endTs: endTs,
    );
  }

  @override
  Future<List<PrivateMessage>> pageMessagesFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    int? endSeqno,
  }) {
    return _localReadStore.pageMessagesFromLocal(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
      endSeqno: endSeqno,
    );
  }

  @override
  Future<Map<String, String>> getMessageEmojiMapFromLocal({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) {
    return _localReadStore.getMessageEmojiMapFromLocal(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
    );
  }

  @override
  Future<List<NotificationEntry>> pageFeedFromLocal({
    required int ownerUid,
    required NotificationFeedType type,
    int? cursorId,
    int? cursorTime,
  }) {
    return _localReadStore.pageFeedFromLocal(
      ownerUid: ownerUid,
      type: type,
      cursorId: cursorId,
      cursorTime: cursorTime,
    );
  }

  @override
  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) {
    return _streamWatchers.watchUnreadCount(ownerUid: ownerUid);
  }

  @override
  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid}) {
    return _streamWatchers.watchSystemNotices(ownerUid: ownerUid);
  }
}
