import 'package:culcul/features/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_owner_uid_provider.g.dart';

@riverpod
int? notificationOwnerUid(Ref ref) {
  final user = ref.watch(authProvider).user;
  if (user == null) return null;
  return int.tryParse(user.id);
}

