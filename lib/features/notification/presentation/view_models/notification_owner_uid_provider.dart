import 'package:culcul/features/auth/feature_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_owner_uid_provider.g.dart';

@riverpod
int? notificationOwnerUid(Ref ref) {
  final session = ref.watch(currentUserProvider);
  if (session == null) return null;
  return int.tryParse(session.uid);
}
