import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/network/network_concurrency_executor.dart';
import 'package:culcul/core/network/network_concurrency_profiles.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/data/dtos/profile_dtos.dart';
import 'package:culcul/features/profile/data/profile_mapper.dart';
import 'package:culcul/features/profile/data/profile_api.dart';
import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/features/profile/domain/repositories/profile_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository_impl.g.dart';

@riverpod
domain.ProfileRepository profileRepository(Ref ref) {
  return ProfileRepositoryImpl(
    api: ProfileApi(ref.watch(dioClientProvider)),
    concurrencyExecutor: const NetworkConcurrencyExecutor(),
  );
}

class ProfileRepositoryImpl
    with RequestExecutorBinding
    implements domain.ProfileRepository {
  static const int _defaultSpaceVideoPageSize = 30;
  final ProfileApi api;
  final RequestExecutor _requestExecutor;
  final NetworkConcurrencyExecutor _concurrencyExecutor;

  ProfileRepositoryImpl({
    required this.api,
    RequestExecutor? requestExecutor,
    NetworkConcurrencyExecutor? concurrencyExecutor,
  }) : _requestExecutor = requestExecutor ?? const RequestExecutor(),
       _concurrencyExecutor = concurrencyExecutor ?? const NetworkConcurrencyExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  @override
  Future<Result<UserCardModel, AppError>> getUserCard(int mid) async {
    final result = await requestApiResult(() => api.getCard(mid));
    return result.when(
      success: (data) {
        try {
          return Success(_parseUserCard(data, fallbackMid: mid));
        } catch (error) {
          return Failure(AppError.fromObject(error));
        }
      },
      failure: Failure.new,
    );
  }

  Future<Result<UserProfile, AppError>> getProfileModel(int userId) async {
    return requestResult(() async {
      final responses = await _concurrencyExecutor.runConcurrent(
        tasks: <ConcurrentTask<dynamic>>[
          ConcurrentTask<dynamic>(
            label: 'info',
            critical: true,
            task: () => api.getAccountInfo(userId),
          ),
          ConcurrentTask<dynamic>(
            label: 'relation',
            critical: false,
            fallback: (_) => null,
            task: () => api.getRelationStat(userId),
          ),
          ConcurrentTask<dynamic>(
            label: 'upStat',
            critical: false,
            fallback: (_) => null,
            task: () => api.getUpStat(userId),
          ),
          ConcurrentTask<dynamic>(
            label: 'navNum',
            critical: false,
            fallback: (_) => null,
            task: () => api.getNavNum(userId),
          ),
          ConcurrentTask<dynamic>(
            label: 'card',
            critical: false,
            fallback: (_) => null,
            task: () => api.getCard(userId, photo: true),
          ),
        ],
        profile: NetworkConcurrencyProfile.enrich,
        scope: 'profile_get_profile_model',
      );
      final infoResponse = responses['info'] as dynamic;

      if (infoResponse.code != 0) {
        throw ServerException(infoResponse.message, code: infoResponse.code);
      }

      final infoData = infoResponse.data as Map<String, dynamic>;
      final relationResponse = responses['relation'];
      final upStatResponse = responses['upStat'];
      final navNumResponse = responses['navNum'];
      final cardResponse = responses['card'];

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

  Future<Result<List<UserSpaceVideoModel>, AppError>> getSpaceVideosModel({
    required int mid,
    int page = 1,
    String order = 'pubdate',
  }) async {
    final result = await requestApiResult(
      () => api.getSpaceVideos(
        mid: mid,
        page: page,
        pageSize: _defaultSpaceVideoPageSize,
        order: order,
      ),
    );
    return result.map((data) => data.list.vlist);
  }

  Future<Result<UserSpaceVideoModel?, AppError>> getStickyVideoModel(int vmid) async {
    final result = await requestApiResult(() => api.getStickyVideo(vmid));
    return result.when(
      success: (data) => Success(data),
      failure: (error) {
        if (error is ServerAppError && error.code == 53016) {
          return const Success(null);
        }
        return Failure(error);
      },
    );
  }

  Future<Result<List<UserSpaceVideoModel>, AppError>> getMasterpieceModels(
    int vmid,
  ) async {
    final result = await requestApiResult(() => api.getMasterpiece(vmid));
    return result.when(
      success: (data) => Success(data),
      failure: (_) => const Success(<UserSpaceVideoModel>[]),
    );
  }

  @override
  Future<Result<void, AppError>> modifyRelation({
    required int mid,
    required bool isFollow,
  }) {
    return requestVoidResult(() => api.modifyRelation(mid, isFollow ? 1 : 2, 11));
  }

  @override
  Future<Result<ProfileUser, AppError>> getProfile(int userId) async {
    final result = await getProfileModel(userId);
    return result.map((data) => data.toDomain());
  }

  @override
  Future<Result<List<ProfileVideo>, AppError>> getSpaceVideos({
    required int mid,
    int page = 1,
    String order = 'pubdate',
  }) async {
    final result = await getSpaceVideosModel(mid: mid, page: page, order: order);
    return result.map((data) => data.map((item) => item.toDomain()).toList());
  }

  @override
  Future<Result<ProfileVideo?, AppError>> getStickyVideo(int vmid) async {
    final result = await getStickyVideoModel(vmid);
    return result.map((data) => data?.toDomain());
  }

  @override
  Future<Result<List<ProfileVideo>, AppError>> getMasterpiece(int vmid) async {
    final result = await getMasterpieceModels(vmid);
    return result.map((data) => data.map((item) => item.toDomain()).toList());
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
    if (response == null ||
        response.code != 0 ||
        response.data is! Map<String, dynamic>) {
      return (followers: 0, following: 0);
    }

    final data = response.data as Map<String, dynamic>;
    return (
      followers: data['follower'] as int? ?? 0,
      following: data['following'] as int? ?? 0,
    );
  }

  int _parseLikes(dynamic response) {
    if (response == null ||
        response.code != 0 ||
        response.data is! Map<String, dynamic>) {
      return 0;
    }
    final data = response.data as Map<String, dynamic>;
    return data['likes'] as int? ?? 0;
  }

  int _parseVideoCount(dynamic response) {
    if (response == null ||
        response.code != 0 ||
        response.data is! Map<String, dynamic>) {
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
    if (cardResponse == null ||
        cardResponse.code != 0 ||
        cardResponse.data is! Map<String, dynamic>) {
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
