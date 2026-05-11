import 'package:culcul/features/auth/data/auth_repository_impl.dart' as data;
import 'package:culcul/features/auth/domain/repositories/auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider = data.authRepositoryProvider;

final authRepositoryEntryProvider = Provider<AuthRepository>((ref) {
  return ref.watch(authRepositoryProvider);
});
