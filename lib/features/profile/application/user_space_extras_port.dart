import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';

/// Profile user-space extras application boundary.
abstract interface class UserSpaceExtrasPort {
  Future<Result<ProfileVideo?, AppError>> getStickyVideo(int vmid);

  Future<Result<List<ProfileVideo>, AppError>> getMasterpiece(int vmid);
}
