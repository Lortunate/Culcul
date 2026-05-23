import 'package:culcul/features/profile/application/profile_read_port.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_read_application_providers.g.dart';

@riverpod
ProfileReadPort profileReadPort(Ref ref) {
  return ref.watch(profileRepositoryProvider);
}
