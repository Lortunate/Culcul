import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';

/// Notification system-notice application boundary.
abstract interface class NotificationSystemNoticePort {
  Stream<List<SystemNotice>> watchSystemNotices({required int ownerUid});

  Future<Result<void, AppError>> syncSystemNotices({required int ownerUid});
}
