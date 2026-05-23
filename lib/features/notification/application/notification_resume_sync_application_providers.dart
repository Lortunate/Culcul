import 'package:culcul/core/data/network/network_concurrency_executor.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/application/notification_feed_application_providers.dart';
import 'package:culcul/features/notification/application/notification_feed_port.dart';
import 'package:culcul/features/notification/application/notification_private_session_application_providers.dart';
import 'package:culcul/features/notification/application/notification_private_session_port.dart';
import 'package:culcul/features/notification/application/notification_resume_sync_port.dart';
import 'package:culcul/features/notification/application/notification_unread_count_application_providers.dart';
import 'package:culcul/features/notification/application/notification_unread_count_port.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_resume_sync_application_providers.g.dart';

@riverpod
NotificationResumeSyncPort notificationResumeSyncPort(Ref ref) {
  return NotificationResumeSyncService(
    unreadCountPort: ref.watch(notificationUnreadCountPortProvider),
    privateSessionPort: ref.watch(notificationPrivateSessionPortProvider),
    feedPort: ref.watch(notificationFeedPortProvider),
  );
}

final class NotificationResumeSyncService implements NotificationResumeSyncPort {
  const NotificationResumeSyncService({
    required NotificationUnreadCountPort unreadCountPort,
    required NotificationPrivateSessionPort privateSessionPort,
    required NotificationFeedPort feedPort,
    NetworkConcurrencyExecutor concurrencyExecutor = const NetworkConcurrencyExecutor(),
  }) : _unreadCountPort = unreadCountPort,
       _privateSessionPort = privateSessionPort,
       _feedPort = feedPort,
       _concurrencyExecutor = concurrencyExecutor;

  final NotificationUnreadCountPort _unreadCountPort;
  final NotificationPrivateSessionPort _privateSessionPort;
  final NotificationFeedPort _feedPort;
  final NetworkConcurrencyExecutor _concurrencyExecutor;

  @override
  Future<void> syncOnResume({required int ownerUid}) async {
    await _concurrencyExecutor.runConcurrent(
      tasks: <ConcurrentTask<dynamic>>[
        ConcurrentTask<Object?>(
          label: 'unread',
          critical: false,
          fallback: _ignoreSyncFailure,
          task: () async {
            await _runSyncTask(_unreadCountPort.syncUnreadCount(ownerUid: ownerUid));
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'sessions',
          critical: false,
          fallback: _ignoreSyncFailure,
          task: () async {
            await _runSyncTask(_privateSessionPort.syncSessions(ownerUid: ownerUid));
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'feed_reply',
          critical: false,
          fallback: _ignoreSyncFailure,
          task: () async {
            await _runSyncTask(
              _feedPort.syncFeedHead(
                ownerUid: ownerUid,
                type: NotificationFeedType.reply,
              ),
            );
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'feed_at',
          critical: false,
          fallback: _ignoreSyncFailure,
          task: () async {
            await _runSyncTask(
              _feedPort.syncFeedHead(ownerUid: ownerUid, type: NotificationFeedType.at),
            );
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'feed_like',
          critical: false,
          fallback: _ignoreSyncFailure,
          task: () async {
            await _runSyncTask(
              _feedPort.syncFeedHead(
                ownerUid: ownerUid,
                type: NotificationFeedType.like,
              ),
            );
            return null;
          },
        ),
      ],
      profile: NetworkConcurrencyProfile.backgroundSync,
      scope: 'notification_resume_sync',
    );
  }

  Future<void> _runSyncTask(Future<Result<void, AppError>> future) async {
    final result = await future;
    if (result.errorOrNull case final error?) {
      DevLogger.log(
        'feature',
        'notification.lifecycle_sync.ignored_error',
        <String, Object?>{'error': error.message},
      );
    }
  }

  Object? _ignoreSyncFailure(Object _) {
    return null;
  }
}
