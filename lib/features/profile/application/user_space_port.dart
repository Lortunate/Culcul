import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';

/// Profile user-space application boundary.
abstract interface class UserSpacePort {
  Future<Result<ProfileUser, AppError>> getProfile(int userId);

  Future<Result<ProfileVideo?, AppError>> getStickyVideo(int vmid);

  Future<Result<List<ProfileVideo>, AppError>> getMasterpiece(int vmid);
}
