import 'package:culcul/features/auth/domain/repositories/auth_repository.dart';
import 'package:culcul/features/auth/application/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_facade.g.dart';

@riverpod
AuthFacade authFacade(Ref ref) {
  return AuthFacade(ref.watch(authRepositoryEntryProvider));
}

class AuthFacade {
  AuthFacade(AuthRepository repository) : _repository = repository;

  // ignore: unused_field
  final AuthRepository _repository;
}
