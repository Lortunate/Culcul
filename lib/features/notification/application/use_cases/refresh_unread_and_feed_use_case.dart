import 'package:culcul/features/notification/data/notification_repository_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/repositories/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refresh_unread_and_feed_use_case.g.dart';

@riverpod
RefreshUnreadAndFeedUseCase refreshUnreadAndFeedUseCase(Ref ref) {
  return RefreshUnreadAndFeedUseCase(ref.watch(notificationRepositoryProvider));
}

class RefreshUnreadAndFeedCommand {
  const RefreshUnreadAndFeedCommand({
    required this.ownerUid,
    required this.feedType,
  });

  final int ownerUid;
  final NotificationFeedType feedType;
}

class RefreshUnreadAndFeedUseCase {
  RefreshUnreadAndFeedUseCase(this._repository);

  final NotificationRepository _repository;

  Future<void> call(RefreshUnreadAndFeedCommand command) async {
    await Future.wait([
      _repository.syncUnreadCount(ownerUid: command.ownerUid, force: true),
      _repository.syncFeedHead(ownerUid: command.ownerUid, type: command.feedType),
    ]);
  }
}
