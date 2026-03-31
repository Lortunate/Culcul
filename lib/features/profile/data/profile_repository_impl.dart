import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/features/profile/data/profile_mapper.dart';
import 'package:culcul/features/profile/data/profile_api.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/features/profile/domain/repositories/profile_repository.dart'
    as domain;
import 'package:culcul/features/profile/domain/entities/profile_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository_impl.g.dart';

@riverpod
domain.ProfileRepository profileRepository(Ref ref) {
  return ProfileRepositoryImpl(api: ProfileApi(ref.watch(dioClientProvider)));
}

class ProfileRepositoryImpl extends BaseRepository implements domain.ProfileRepository {
  final ProfileApi api;

  ProfileRepositoryImpl({required this.api});

  @override
  Future<UserCardModel> getUserCard(int mid) async {
    final data = await requestApi(() => api.getCard(mid));
    return _parseUserCard(data, fallbackMid: mid);
  }

  Future<UserProfile> getProfileModel(int userId) async {
    return request(() async {
      final infoResponse = await api.getAccountInfo(userId);

      if (infoResponse.code != 0) {
        throw ServerException(infoResponse.message, code: infoResponse.code);
      }

      final infoData = infoResponse.data as Map<String, dynamic>;

      final results = await Future.wait([
        api.getRelationStat(userId),
        api.getUpStat(userId),
        api.getNavNum(userId),
        api.getCard(userId, photo: true),
      ]);

      final relationResponse = results[0];
      final upStatResponse = results[1];
      final navNumResponse = results[2];
      final cardResponse = results[3];

      final relation = _parseRelationStats(relationResponse);
      final likes = _parseLikes(upStatResponse);
      final videoCount = _parseVideoCount(navNumResponse);
      final topPhoto = _resolveBanner(infoData, cardResponse);

      return UserProfile(
        id: userId.toString(),
        username: infoData['name'] as String? ?? '',
        avatarUrl: infoData['face'] as String? ?? '',
        bannerUrl: topPhoto,
        bio: infoData['sign'] as String?,
        location: null,
        followersCount: relation.followers,
        followingCount: relation.following,
        videosCount: videoCount,
        dynamicCount: 0,
        likesCount: likes,
        level: infoData['level'] as int? ?? 0,
        vipType: _parseVipType(infoData),
        vipStatus: _parseVipStatus(infoData),
        coins: null,
        isFollowing: infoData['is_followed'] as bool? ?? false,
        isVerified: _isVerified(infoData),
        createdAt: null,
      );
    });
  }

  Future<List<UserSpaceVideoModel>> getSpaceVideosModel({
    required int mid,
    int page = 1,
    int pageSize = 30,
    String order = 'pubdate',
  }) async {
    final data = await requestApi(
      () => api.getSpaceVideos(mid: mid, page: page, pageSize: pageSize, order: order),
    );
    return data.list.vlist;
  }

  Future<UserSpaceVideoModel?> getStickyVideoModel(int vmid) async {
    try {
      return await requestApi(() => api.getStickyVideo(vmid));
    } on ServerException catch (e) {
      if (e.code == 53016) return null;
      rethrow;
    }
  }

  Future<List<UserSpaceVideoModel>> getMasterpieceModels(int vmid) async {
    try {
      return await requestApi(() => api.getMasterpiece(vmid));
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> modifyRelation({required int mid, required bool isFollow}) {
    return requestVoid(() => api.modifyRelation(mid, isFollow ? 1 : 2, 11));
  }

  @override
  Future<ProfileUser> getProfile(int userId) async {
    return (await getProfileModel(userId)).toDomain();
  }

  @override
  Future<List<ProfileVideo>> getSpaceVideos({
    required int mid,
    int page = 1,
    int pageSize = 30,
    String order = 'pubdate',
  }) async {
    return (await getSpaceVideosModel(
      mid: mid,
      page: page,
      pageSize: pageSize,
      order: order,
    )).map((item) => item.toDomain()).toList();
  }

  @override
  Future<ProfileVideo?> getStickyVideo(int vmid) async {
    return (await getStickyVideoModel(vmid))?.toDomain();
  }

  @override
  Future<List<ProfileVideo>> getMasterpiece(int vmid) async {
    return (await getMasterpieceModels(vmid)).map((item) => item.toDomain()).toList();
  }

  UserCardModel _parseUserCard(dynamic data, {required int fallbackMid}) {
    try {
      final map = Map<String, dynamic>.from(data as Map);
      final card = Map<String, dynamic>.from(map['card'] as Map? ?? const {});
      final following = map['following'] as bool? ?? false;

      return UserCardModel(
        mid: card['mid']?.toString() ?? fallbackMid.toString(),
        name: card['name']?.toString() ?? '',
        face: card['face']?.toString() ?? '',
        isFollowed: following,
      );
    } catch (error) {
      throw UnknownException('Failed to parse user card', cause: error);
    }
  }

  ({int followers, int following}) _parseRelationStats(dynamic response) {
    if (response.code != 0 || response.data is! Map<String, dynamic>) {
      return (followers: 0, following: 0);
    }

    final data = response.data as Map<String, dynamic>;
    return (
      followers: data['follower'] as int? ?? 0,
      following: data['following'] as int? ?? 0,
    );
  }

  int _parseLikes(dynamic response) {
    if (response.code != 0 || response.data is! Map<String, dynamic>) {
      return 0;
    }
    final data = response.data as Map<String, dynamic>;
    return data['likes'] as int? ?? 0;
  }

  int _parseVideoCount(dynamic response) {
    if (response.code != 0 || response.data is! Map<String, dynamic>) {
      return 0;
    }
    final data = response.data as Map<String, dynamic>;
    return data['video'] as int? ?? 0;
  }

  bool _isVerified(Map<String, dynamic> infoData) {
    final official = infoData['official'];
    if (official is! Map<String, dynamic>) {
      return false;
    }
    return (official['role'] as int? ?? 0) != 0;
  }

  int _parseVipType(Map<String, dynamic> infoData) {
    final vipInfo = infoData['vip'];
    return vipInfo is Map<String, dynamic> ? vipInfo['type'] as int? ?? 0 : 0;
  }

  int _parseVipStatus(Map<String, dynamic> infoData) {
    final vipInfo = infoData['vip'];
    return vipInfo is Map<String, dynamic> ? vipInfo['status'] as int? ?? 0 : 0;
  }

  String? _resolveBanner(Map<String, dynamic> infoData, dynamic cardResponse) {
    var topPhoto = infoData['top_photo'] as String?;
    if (cardResponse.code != 0 || cardResponse.data is! Map<String, dynamic>) {
      return topPhoto;
    }

    final data = cardResponse.data as Map<String, dynamic>;
    final space = data['space'];
    if (space is! Map<String, dynamic>) {
      return topPhoto;
    }

    final large = space['l_img'] as String?;
    if (large != null && large.isNotEmpty) {
      return large;
    }

    final small = space['s_img'] as String?;
    if (small != null && small.isNotEmpty) {
      return small;
    }

    return topPhoto;
  }
}

