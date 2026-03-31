import 'package:culcul/features/profile/domain/entities/profile_user.dart';

abstract class ProfileCacheRepository {
  Future<ProfileUser?> readProfile(String userId);

  Future<void> writeProfile(ProfileUser profile);
}
