import 'package:culcul/features/auth/application/auth_qr_login_port.dart';
import 'package:culcul/features/auth/data/auth_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_qr_login_providers.g.dart';

@riverpod
AuthQrLoginPort authQrLoginPort(Ref ref) {
  return ref.watch(authRepositoryProvider);
}
