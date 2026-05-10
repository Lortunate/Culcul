import 'package:culcul/features/profile/application/profile_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/profile/application/profile_facade.dart' show profileFacadeProvider;

final profileFacadeEntryProvider = Provider<ProfileFacade>(
  (ref) => ref.watch(profileFacadeProvider),
);
