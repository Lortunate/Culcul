import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/application/profile_read_port.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:dio/dio.dart';

/// Profile user-space application boundary.
abstract interface class UserSpacePort implements ProfileReadPort {
  Future<Result<ProfileVideo?, AppError>> getStickyVideo(int vmid);

  Future<Result<List<ProfileVideo>, AppError>> getMasterpiece(int vmid);

  Future<Result<List<ProfileVideo>, AppError>> getSpaceVideos({
    required int mid,
    int page = 1,
    String order = 'pubdate',
    bool forceRefresh = false,
    CancelToken? cancelToken,
  });
}
