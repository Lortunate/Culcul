import 'package:culcul/features/auth/application/auth_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/auth/application/auth_facade.dart' show authFacadeProvider;

final authFacadeEntryProvider = Provider<AuthFacade>(
  (ref) => ref.watch(authFacadeProvider),
);
