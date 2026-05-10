import 'package:culcul/features/notification/application/notification_facade.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/domain/repositories/notification_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final notificationRepositoryFacadeProvider = Provider<NotificationRepository>(
  (ref) => ref.watch(notificationRepositoryProvider),
);

// The facade provider is generated in notification_facade.dart as notificationFacadeProvider.
// We can re-expose it here if we want a stable name in feature_scope.
final notificationFacadeEntryProvider = Provider<NotificationFacade>(
  (ref) => ref.watch(notificationFacadeProvider),
);
