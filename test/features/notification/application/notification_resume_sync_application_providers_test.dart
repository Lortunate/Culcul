import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/application/notification_feed_port.dart';
import 'package:culcul/features/notification/application/notification_private_session_port.dart';
import 'package:culcul/features/notification/application/notification_resume_sync_application_providers.dart';
import 'package:culcul/features/notification/application/notification_unread_count_port.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_cursor.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('resume sync runs unread sessions and feed heads as non-fatal tasks', () async {
    final ports = _RecordingNotificationPorts(
      feedResults: const {
        NotificationFeedType.reply: Failure(AppError.server('reply failed')),
      },
    );
    final service = NotificationResumeSyncService(
      unreadCountPort: ports,
      privateSessionPort: ports,
      feedPort: ports,
    );

    await service.syncOnResume(ownerUid: 42);

    expect(ports.unreadOwnerUids, [42]);
    expect(ports.sessionOwnerUids, [42]);
    expect(ports.feedHeadOwnerUids, [42, 42, 42]);
    expect(
      ports.feedHeadTypes,
      unorderedEquals([
        NotificationFeedType.reply,
        NotificationFeedType.at,
        NotificationFeedType.like,
      ]),
    );
  });
}

final class _RecordingNotificationPorts
    implements NotificationUnreadCountPort, NotificationPrivateSessionPort, NotificationFeedPort {
  _RecordingNotificationPorts({this.feedResults = const {}});

  final Map<NotificationFeedType, Result<void, AppError>> feedResults;
  final unreadOwnerUids = <int>[];
  final sessionOwnerUids = <int>[];
  final feedHeadOwnerUids = <int>[];
  final feedHeadTypes = <NotificationFeedType>[];

  @override
  Stream<NotificationSummary> watchUnreadCount({required int ownerUid}) {
    return Stream.value(const NotificationSummary());
  }

  @override
  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
  }) async {
    unreadOwnerUids.add(ownerUid);
    return const Success(null);
  }

  @override
  Future<List<PrivateSession>> pageSessionsFromLocal({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
  }) async {
    return const <PrivateSession>[];
  }

  @override
  Future<Result<void, AppError>> syncSessions({
    required int ownerUid,
    bool force = false,
  }) async {
    sessionOwnerUids.add(ownerUid);
    return const Success(null);
  }

  @override
  Future<Result<void, AppError>> syncSessionsOlder({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int endTs,
  }) async {
    return const Success(null);
  }

  @override
  Future<List<NotificationEntry>> pageFeedFromLocal({
    required int ownerUid,
    required NotificationFeedType type,
    NotificationFeedCursor? cursor,
  }) async {
    return const <NotificationEntry>[];
  }

  @override
  Future<Result<void, AppError>> syncFeedHead({
    required int ownerUid,
    required NotificationFeedType type,
  }) async {
    feedHeadOwnerUids.add(ownerUid);
    feedHeadTypes.add(type);
    return feedResults[type] ?? const Success(null);
  }

  @override
  Future<Result<void, AppError>> syncFeedOlder({
    required int ownerUid,
    required NotificationFeedType type,
    required NotificationFeedCursor cursor,
  }) async {
    return const Success(null);
  }
}
