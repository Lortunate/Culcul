import 'dart:async';

import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/application/presentation_contracts/notification_repository_impl.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/network_concurrency_executor.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:culcul/core/result/result.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_lifecycle_sync_view_model.g.dart';

@Riverpod(keepAlive: true)
class NotificationLifecycleSync extends _$NotificationLifecycleSync
    with WidgetsBindingObserver {
  int _lastResumeSyncAt = 0;
  final NetworkConcurrencyExecutor _concurrencyExecutor =
      const NetworkConcurrencyExecutor();

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

    final ownerUid = ref.read(notificationOwnerUidProvider);
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
      scope: 'notification_resume_sync',
    );
  }

  Future<void> _runSyncTask(Future<Result<void, AppError>> future) async {
    final result = await future;
    if (result.errorOrNull case final error?) {
      debugPrint('NotificationLifecycleSync ignored error: ${error.message}');
    }
  }

  Object? _ignoreSyncFailure(Object _) {
    return null;
  }
}
