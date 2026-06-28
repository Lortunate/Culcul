import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/core/data/network/network_concurrency_executor.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:dio/dio.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/utils/json_utils.dart';
import 'package:culcul/features/profile/data/profile_api.dart';
import 'package:culcul/core/models/user_card_contract.dart';
import 'package:culcul/features/profile/models/profile_user.dart';
import 'package:culcul/features/profile/models/profile_video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository_impl.g.dart';

@riverpod
ProfileRepositoryImpl profileRepository(Ref ref) {
  return ProfileRepositoryImpl(
    api: ProfileApi(ref.watch(dioClientProvider)),
    concurrencyExecutor: const NetworkConcurrencyExecutor(),
  );
}

class ProfileRepositoryImpl {
  final ProfileApi api;
  final RequestExecutor _requestExecutor;
  final NetworkConcurrencyExecutor _concurrencyExecutor;

  ProfileRepositoryImpl({
    required this.api,
    RequestExecutor? requestExecutor,
    NetworkConcurrencyExecutor? concurrencyExecutor,
  }) : _requestExecutor = requestExecutor ?? const RequestExecutor(),
       _concurrencyExecutor = concurrencyExecutor ?? const NetworkConcurrencyExecutor();

  Future<Result<UserCardModel, AppError>> getUserCard(int mid) async {
    final result = await _requestExecutor.runApiDirect(() => api.getCard(mid));
    return result.when(
      success: (data) {
        try {
          final map = Map<String, dynamic>.from(data as Map);
          final card = Map<String, dynamic>.from(map['card'] as Map? ?? const {});
          final following = map['following'] as bool? ?? false;

          return Success(
            UserCardModel(
              mid: card['mid']?.toString() ?? mid.toString(),
              name: card['name']?.toString() ?? '',
              face: card['face']?.toString() ?? '',
              isFollowed: following,
            ),
          );
        } catch (error) {
          return Failure(AppError.unknown('Failed to parse user card', cause: error));
        }
      },
      failure: Failure.new,
    );
  }

  Future<Result<ProfileUser, AppError>> getProfile(int userId) async {
    return _requestExecutor.run(() async {
      final responses = await _concurrencyExecutor.runConcurrent(
        tasks: <ConcurrentTask<dynamic>>[
          ConcurrentTask<dynamic>(label: 'info', task: () => api.getAccountInfo(userId)),
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
            task: () => api.getCard(userId),
          ),
        ],
        profile: NetworkConcurrencyProfile.enrich,
      );
      final infoResponse = responses['info'] as ApiResponse<dynamic>;

      if (infoResponse.code != 0) {
        throw AppError.server(infoResponse.message, code: infoResponse.code);
      }

      final infoData = infoResponse.data as Map<String, dynamic>;
      final relationResponse = responses['relation'];
      final upStatResponse = responses['upStat'];
      final navNumResponse = responses['navNum'];
      final cardResponse = responses['card'];

      final relationData = _optionalResponseDataMap(relationResponse);
      final followers = JsonUtils.parseIntWithDefault(relationData?['follower']);
      final following = JsonUtils.parseIntWithDefault(relationData?['following']);
      final upStatData = _optionalResponseDataMap(upStatResponse);
      final navNumData = _optionalResponseDataMap(navNumResponse);
      final likes = JsonUtils.parseIntWithDefault(upStatData?['likes']);
      final videoCount = JsonUtils.parseIntWithDefault(navNumData?['video']);
      final topPhoto = infoData['top_photo'] as String?;
      final cardData = _optionalResponseDataMap(cardResponse);
      final space = JsonUtils.asStringKeyedMap(cardData?['space']);
      var bannerUrl = topPhoto;
      final largeBanner = space?['l_img'] as String?;
      if (largeBanner != null && largeBanner.isNotEmpty) {
        bannerUrl = largeBanner;
      } else {
        final smallBanner = space?['s_img'] as String?;
        if (smallBanner != null && smallBanner.isNotEmpty) {
          bannerUrl = smallBanner;
        }
      }
      final vipInfo = JsonUtils.asStringKeyedMap(infoData['vip']);
      final officialInfo = JsonUtils.asStringKeyedMap(infoData['official']);

      return ProfileUser(
        id: userId.toString(),
        username: infoData['name'] as String? ?? '',
        avatarUrl: infoData['face'] as String? ?? '',
        bannerUrl: bannerUrl,
        bio: infoData['sign'] as String?,
        followersCount: followers,
        followingCount: following,
        videosCount: videoCount,
        likesCount: likes,
        level: infoData['level'] as int? ?? 0,
        vipType: JsonUtils.parseIntWithDefault(vipInfo?['type']),
        vipStatus: JsonUtils.parseIntWithDefault(vipInfo?['status']),
        isFollowing: infoData['is_followed'] as bool? ?? false,
        isVerified: JsonUtils.parseIntWithDefault(officialInfo?['role']) != 0,
      );
    });
  }

  Future<Result<List<ProfileVideo>, AppError>> getSpaceVideos({
    required int mid,
    int page = 1,
    String order = 'pubdate',
    bool forceRefresh = false,
    CancelToken? cancelToken,
  }) async {
    return _requestExecutor.runApi<List<ProfileVideo>, Object>(
      () => api.getSpaceVideos(
        mid: mid,
        page: page,
        order: order,
        forceRefresh: forceRefresh ? true : null,
        cancelToken: cancelToken,
      ),
      transform: (data) {
        final map = JsonUtils.asStringKeyedMap(data);
        final list = JsonUtils.asStringKeyedMap(map?['list']);
        final videos = list?['vlist'];
        if (videos == null) return const [];

        return JsonUtils.parseObjectList(videos).map(ProfileVideo.fromJson).toList();
      },
    );
  }

  Future<Result<ProfileVideo?, AppError>> getStickyVideo(int vmid) async {
    final result = await _requestExecutor.runApiDirect(() => api.getStickyVideo(vmid));
    return result.when(
      success: Success<ProfileVideo?, AppError>.new,
      failure: (error) {
        if (error is ServerAppError && error.code == 53016) {
          return const Success<ProfileVideo?, AppError>(null);
        }
        return Failure<ProfileVideo?, AppError>(error);
      },
    );
  }

  Future<Result<List<ProfileVideo>, AppError>> getMasterpiece(int vmid) async {
    final result = await _requestExecutor.runApiDirect(() => api.getMasterpiece(vmid));
    return result.when(
      success: Success<List<ProfileVideo>, AppError>.new,
      failure: (_) => const Success<List<ProfileVideo>, AppError>([]),
    );
  }

  Map<String, dynamic>? _optionalResponseDataMap(dynamic response) {
    if (response == null ||
        response.code != 0 ||
        response.data is! Map<String, dynamic>) {
      return null;
    }
    return response.data as Map<String, dynamic>;
  }
}
