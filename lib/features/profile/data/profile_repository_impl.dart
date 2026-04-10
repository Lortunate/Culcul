import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/network/network_concurrency_executor.dart';
import 'package:culcul/core/network/network_concurrency_profiles.dart';
import 'package:culcul/core/network/request_cancel_token.dart';
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
part 'profile_repository_impl.flows.dart';
part 'profile_repository_impl.parsers.dart';

@riverpod
domain.ProfileRepository profileRepository(Ref ref) {
  return ProfileRepositoryImpl(
    api: ProfileApi(ref.watch(dioClientProvider)),
    concurrencyExecutor: const NetworkConcurrencyExecutor(),
  );
}

class ProfileRepositoryImpl
    with RequestExecutorBinding, _ProfileRepositoryImplFlowsMixin
    implements domain.ProfileRepository {
  static const int _defaultSpaceVideoPageSize = 30;
  @override
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

  @override
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
}
