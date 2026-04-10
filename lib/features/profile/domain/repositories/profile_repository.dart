import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/network/request_cancel_token.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/shared/contracts/user_card_contract.dart';

abstract class ProfileRepository {
  Future<Result<UserCardModel, AppError>> getUserCard(int mid);

  Future<Result<ProfileUser, AppError>> getProfile(int userId);

  Future<Result<List<ProfileVideo>, AppError>> getSpaceVideos({
    required int mid,
    int page = 1,
    String order = 'pubdate',
    bool forceRefresh = false,
    RequestCancelToken? cancelToken,
  });

  Future<Result<ProfileVideo?, AppError>> getStickyVideo(int vmid);

  Future<Result<List<ProfileVideo>, AppError>> getMasterpiece(int vmid);

  Future<Result<void, AppError>> modifyRelation({
    required int mid,
    required bool isFollow,
  });
}
