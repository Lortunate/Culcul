import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';

/// Notification private-session application boundary.
abstract interface class NotificationPrivateSessionPort {
  Future<List<PrivateSession>> pageSessionsFromLocal({
    required int ownerUid,
    required PrivateSessionType sessionType,
    int? endTs,
  });

  Future<Result<void, AppError>> syncSessions({
    required int ownerUid,
    bool force = false,
  });

  Future<Result<void, AppError>> syncSessionsOlder({
    required int ownerUid,
    required PrivateSessionType sessionType,
    required int endTs,
  });
}
