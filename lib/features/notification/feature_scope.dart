import 'package:culcul/features/notification/application/notification_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/notification/application/notification_facade.dart' show notificationFacadeProvider;

// The facade provider is generated in notification_facade.dart as notificationFacadeProvider.
// We can re-expose it here if we want a stable name in feature_scope.
final notificationFacadeEntryProvider = Provider<NotificationFacade>(
  (ref) => ref.watch(notificationFacadeProvider),
);
