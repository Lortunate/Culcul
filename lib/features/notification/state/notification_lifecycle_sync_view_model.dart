import 'dart:async';

import 'package:culcul/core/data/network/network_concurrency_executor.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/models/notification_feed_type.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_lifecycle_sync_view_model.g.dart';

@Riverpod(keepAlive: true)
class NotificationLifecycleSync extends _$NotificationLifecycleSync
    with WidgetsBindingObserver {
  final NetworkConcurrencyExecutor _concurrencyExecutor =
      const NetworkConcurrencyExecutor();
  int _lastResumeSyncAt = 0;

  @override
  bool build() {
    WidgetsBinding.instance.addObserver(this);
    ref.onDispose(() => WidgetsBinding.instance.removeObserver(this));
    return true;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;

    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastResumeSyncAt < 60000) return;
    _lastResumeSyncAt = now;

    final ownerUid = int.tryParse(ref.read(currentUserProvider)?.uid ?? '');
    if (ownerUid == null) return;
    unawaited(_syncOnResume(ownerUid));
  }

  Future<void> _syncOnResume(int ownerUid) async {
    final repository = ref.read(notificationRepositoryProvider);
    await _concurrencyExecutor.runConcurrent(
      tasks: <ConcurrentTask<dynamic>>[
        ConcurrentTask<Object?>(
          label: 'unread',
          critical: false,
          fallback: _ignoreSyncFailure,
          task: () async {
            await _runSyncTask(repository.syncUnreadCount(ownerUid: ownerUid));
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'sessions',
          critical: false,
          fallback: _ignoreSyncFailure,
          task: () async {
            await _runSyncTask(repository.syncSessions(ownerUid: ownerUid));
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'feed_reply',
          critical: false,
          fallback: _ignoreSyncFailure,
          task: () async {
            await _runSyncTask(
              repository.syncFeedHead(
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
              repository.syncFeedHead(ownerUid: ownerUid, type: NotificationFeedType.at),
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
              repository.syncFeedHead(
                ownerUid: ownerUid,
                type: NotificationFeedType.like,
              ),
            );
            return null;
          },
        ),
      ],
      profile: NetworkConcurrencyProfile.backgroundSync,
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
