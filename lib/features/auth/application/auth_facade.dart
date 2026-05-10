import 'package:culcul/features/auth/domain/repositories/auth_repository.dart';
import 'package:culcul/features/auth/data/auth_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_facade.g.dart';

@riverpod
AuthFacade authFacade(Ref ref) {
  return AuthFacade(ref.watch(authRepositoryProvider));
}

class AuthFacade {
  AuthFacade(this.repository);

  final AuthRepository repository;
}
