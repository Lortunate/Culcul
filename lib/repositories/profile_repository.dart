import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/repositories/base_repository.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/api/profile_api.dart';
import 'package:culcul/data/models/user/user_card_model.dart';
import 'package:culcul/data/models/user/user_space_video_model.dart';
import 'package:culcul/data/models/user/user_profile_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository.g.dart';

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(api: ref.watch(profileApiProvider));
}

class ProfileRepository extends BaseRepository {
  final ProfileApi api;

  ProfileRepository({required this.api});

  Future<Result<UserCardModel, AppException>> getUserCard(int mid) async {
    final result = await safeApiCall(() => api.getCard(mid));

    return switch (result) {
      Success(value: final data) => () {
        try {
          final map = data as Map<String, dynamic>;
          final card = map['card'] as Map<String, dynamic>;
          final following = map['following'] as bool? ?? false;

          return Success<UserCardModel, AppException>(UserCardModel(
            mid: card['mid']?.toString() ?? mid.toString(),
            name: card['name']?.toString() ?? '',
            face: card['face']?.toString() ?? '',
            isFollowed: following,
          ));
        } catch (e) {
          return Failure<UserCardModel, AppException>(
            UnknownException('Failed to parse user card', cause: e),
          );
        }
      }(),
      Failure(exception: final e) => Failure<UserCardModel, AppException>(e),
    };
  }

  Future<Result<UserProfile, AppException>> getProfile(int userId) async {
    return safeCall(() async {
      final infoResponse = await api.getAccountInfo(userId);

      if (infoResponse.code != 0) {
        throw ServerException(infoResponse.message, code: infoResponse.code);
      }

      final infoData = infoResponse.data as Map<String, dynamic>;

      final results = await Future.wait([
        api.getRelationStat(userId),
        api.getUpStat(userId),
        api.getNavNum(userId),
      ]);

      final relationResponse = results[0];
      final upStatResponse = results[1];
      final navNumResponse = results[2];

      int followers = 0;
      int following = 0;
      if (relationResponse.code == 0) {
        final relData = relationResponse.data as Map<String, dynamic>;
        followers = relData['follower'] as int? ?? 0;
        following = relData['following'] as int? ?? 0;
      }

      int likes = 0;
      if (upStatResponse.code == 0) {
        final statData = upStatResponse.data as Map<String, dynamic>;
        likes = statData['likes'] as int? ?? 0;
      }

      int videoCount = 0;
      int dynamicCount = 0;
      if (navNumResponse.code == 0) {
        final navData = navNumResponse.data as Map<String, dynamic>;
        videoCount = navData['video'] as int? ?? 0;
      }

      final name = infoData['name'] as String;
      final face = infoData['face'] as String;
      final sign = infoData['sign'] as String?;
      final level = infoData['level'] as int? ?? 0;

      bool isVerified = false;
      if (infoData['official'] != null) {
        final official = infoData['official'] as Map<String, dynamic>;
        final role = official['role'] as int? ?? 0;
        isVerified = role != 0;
      }

      final vipInfo = infoData['vip'] as Map<String, dynamic>?;
      final vipType = vipInfo?['type'] as int? ?? 0;
      final vipStatus = vipInfo?['status'] as int? ?? 0;

      bool isFollowing = false;
      if (infoData['is_followed'] != null) {
        isFollowing = infoData['is_followed'] as bool;
      }

      return UserProfile(
        id: userId.toString(),
        username: name,
        avatarUrl: face,
        bio: sign,
        location: null,
        followersCount: followers,
        followingCount: following,
        videosCount: videoCount,
        dynamicCount: dynamicCount,
        likesCount: likes,
        level: level,
        vipType: vipType,
        vipStatus: vipStatus,
        coins: null,
        isFollowing: isFollowing,
        isVerified: isVerified,
        createdAt: null,
      );
    });
  }

  Future<Result<List<UserSpaceVideoModel>, AppException>> getSpaceVideos({
    required int mid,
    int page = 1,
    int pageSize = 30,
    String order = 'pubdate',
  }) async {
    final result = await safeApiCall(
      () => api.getSpaceVideos(
        mid: mid,
        page: page,
        pageSize: pageSize,
        order: order,
      ),
    );

    return switch (result) {
      Success(value: final data) => Success(data.list.vlist),
      Failure(exception: final e) => Failure(e),
    };
  }

  Future<Result<UserSpaceVideoModel?, AppException>> getStickyVideo(int vmid) async {
    final result = await safeApiCall(() => api.getStickyVideo(vmid));

    return switch (result) {
      Success(value: final data) => Success(data),
      Failure(exception: final e) => 
        (e is ServerException && e.code == 53016)
          ? const Success(null)
          : Failure(e),
    };
  }

  Future<Result<List<UserSpaceVideoModel>, AppException>> getMasterpiece(
    int vmid,
  ) async {
    final result = await safeApiCall(() => api.getMasterpiece(vmid));

    return switch (result) {
      Success(value: final data) => Success(data),
      Failure(exception: final _) => const Success([]), // Fallback to empty list as per original logic
    };
  }

  Future<Result<void, AppException>> modifyRelation({
    required int mid,
    required bool isFollow,
  }) {
    return safeVoidApiCall(
      () => api.modifyRelation(mid, isFollow ? 1 : 2, 11),
    );
  }
}
