import 'package:culcul/features/profile/domain/entities/profile_user.dart';

/// Profile cache application boundary.
abstract interface class ProfileCachePort {
  Future<ProfileUser?> readProfile(String userId);

  Future<void> writeProfile(ProfileUser profile);

  Future<void> clearProfile(String userId);

  Future<void> clearAll();
}
