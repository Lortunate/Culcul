part of 'notification_repository_impl.dart';

class _NotificationSyncService {
  _NotificationSyncService(this.repo)
      : _sessionSync = _NotificationSessionSync(repo),
        _messageSync = _NotificationMessageSync(repo),
        _feedSync = _NotificationFeedSync(repo);

  final NotificationRepositoryImpl repo;
  final _NotificationSessionSync _sessionSync;
  final _NotificationMessageSync _messageSync;
  final _NotificationFeedSync _feedSync;

  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
  }) {
    return _sessionSync.syncUnreadCount(ownerUid: ownerUid, force: force);
  }

  Future<Result<void, AppError>> syncSessions({
    required int ownerUid,
    bool force = false,
  }) {
    return _sessionSync.syncSessions(ownerUid: ownerUid, force: force);
  }

  Future<Result<void, AppError>> syncSessionsOlder({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int endTs,
  }) {
    return _sessionSync.syncSessionsOlder(
      ownerUid: ownerUid,
      sessionType: sessionType,
      endTs: endTs,
    );
  }

  Future<Result<void, AppError>> syncMessagesHead({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
  }) {
    return _messageSync.syncMessagesHead(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
    );
  }

  Future<Result<void, AppError>> syncMessagesOlder({
    required int ownerUid,
    required int talkerId,
    required PrivateSessionType sessionType,
    required int endSeqno,
  }) {
    return _messageSync.syncMessagesOlder(
      ownerUid: ownerUid,
      talkerId: talkerId,
      sessionType: sessionType,
      endSeqno: endSeqno,
    );
  }

  Future<Result<void, AppError>> syncFeedHead({
    required int ownerUid,
    required NotificationFeedType type,
  }) {
    return _feedSync.syncFeedHead(ownerUid: ownerUid, type: type);
  }

  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required int cursorId,
    required int cursorTime,
  }) {
    return _feedSync.syncFeedOlder(
      ownerUid: ownerUid,
      type: type,
      cursorId: cursorId,
      cursorTime: cursorTime,
    );
  }
}
