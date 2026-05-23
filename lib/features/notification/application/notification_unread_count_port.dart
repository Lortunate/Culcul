import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';

/// Notification unread-count application boundary.
abstract interface class NotificationUnreadCountPort {
  Stream<NotificationSummary> watchUnreadCount({required int ownerUid});

  Future<Result<void, AppError>> syncUnreadCount({
    required int ownerUid,
    bool force = false,
  });
}
