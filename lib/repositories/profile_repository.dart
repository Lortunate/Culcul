import 'package:culcul/data/api/profile_api.dart';
import 'package:culcul/data/models/user/user_card_model.dart';
import 'package:culcul/data/models/user/user_space_video_model.dart';
import 'package:culcul/data/models/user_profile_model.dart';
import 'package:culcul/domain/entities/user_profile.dart';

class ProfileRepository {
  final ProfileApi _api;

  ProfileRepository(this._api);

  Future<UserCardModel> getUserCard(String mid) async {
    final response = await _api.getCard(mid);
    if (response.code != 0 || response.data == null) {
      throw Exception('Failed to load user card: ${response.message}');
    }
    final data = response.data as Map<String, dynamic>;
    final card = data['card'] as Map<String, dynamic>;
    final following = data['following'] as bool? ?? false;
    
    return UserCardModel(
      mid: card['mid']?.toString() ?? mid,
      name: card['name']?.toString() ?? '',
      face: card['face']?.toString() ?? '',
      isFollowed: following,
    );
  }

  Future<UserProfile> getProfile(String userId) async {
    final profileModel = await _getUserProfileModel(userId);
    return profileModel.toEntity();
  }

  Future<List<UserSpaceVideoModel>> getSpaceVideos({
    required int mid,
    int page = 1,
    int pageSize = 30,
    String order = 'pubdate',
  }) async {
    final params = {
      'mid': mid,
      'pn': page,
      'ps': pageSize,
      'order': order,
    };
    final response = await _api.getSpaceVideos(params);
    if (response.code != 0 || response.data == null) {
      throw Exception('Failed to load user videos: ${response.message}');
    }
    return response.data!.list.vlist;
  }

  Future<UserSpaceVideoModel?> getStickyVideo(int vmid) async {
    final response = await _api.getStickyVideo(vmid);
    if (response.code != 0) {
      if (response.code == 53016) return null;
      throw Exception('Failed to load sticky video: ${response.message}');
    }
    return response.data;
  }

  Future<List<UserSpaceVideoModel>> getMasterpiece(int vmid) async {
    final response = await _api.getMasterpiece(vmid);
    if (response.code != 0) {
      return [];
    }
    return response.data ?? [];
  }

  Future<void> modifyRelation({
    required int mid,
    required bool isFollow,
  }) async {
    final response = await _api.modifyRelation(
      mid.toString(),
      isFollow ? 1 : 2,
      11,
    );
    if (response.code != 0) {
      throw Exception('Failed to modify relation: ${response.message}');
    }
  }

  Future<UserProfileModel> _getUserProfileModel(String userId) async {
    final params = {'mid': userId};
    final infoResponse = await _api.getAccountInfo(params);

    if (infoResponse.code != 0) {
      throw Exception('Failed to load user info: ${infoResponse.message}');
    }

    final infoData = infoResponse.data as Map<String, dynamic>;

    final results = await Future.wait([
      _api.getRelationStat(userId),
      _api.getUpStat(userId),
      _api.getNavNum(userId),
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

    return UserProfileModel(
      id: userId,
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
  }
}
