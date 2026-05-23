import 'package:culcul/features/profile/application/user_space_port.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_application_providers.g.dart';

@riverpod
UserSpacePort userSpacePort(Ref ref) {
  return ref.watch(profileRepositoryProvider);
}
