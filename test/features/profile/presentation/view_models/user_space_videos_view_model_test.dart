import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/application/user_space_application_providers.dart';
import 'package:culcul/features/profile/application/user_space_port.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/features/profile/presentation/view_models/user_space_videos_view_model.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test(
    'user space videos read through the profile user-space application port',
    () async {
      final video = _profileVideo(aid: 1, bvid: 'BV1xx411c7mD');
      final port = _FakeUserSpacePort(spaceVideos: Success([video]));
      final container = ProviderContainer(
        retry: (_, _) => null,
        overrides: [
          cacheStoreProvider.overrideWithValue(MemCacheStore()),
          userSpacePortProvider.overrideWithValue(port),
          profileRepositoryProvider.overrideWith(
            (ref) => throw StateError(
              'profileRepositoryProvider should not be read by UI state',
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final videos = await container.read(userSpaceVideosProvider(42).future);

      expect(videos, [video]);
      expect(port.spaceVideoRequests, hasLength(1));
      final request = port.spaceVideoRequests.single;
      expect(request.mid, 42);
      expect(request.page, 1);
      expect(request.order, 'pubdate');
      expect(request.forceRefresh, isFalse);
      expect(request.cancelToken, isNotNull);
    },
  );
}

final class _FakeUserSpacePort implements UserSpacePort {
  _FakeUserSpacePort({this.spaceVideos = const Success(<ProfileVideo>[])});

  final Result<List<ProfileVideo>, AppError> spaceVideos;
  final spaceVideoRequests = <_SpaceVideoRequest>[];

  @override
  Future<Result<ProfileUser, AppError>> getProfile(int userId) async {
    return const Failure(AppError.data('profile not configured'));
  }

  @override
  Future<Result<ProfileUser, AppError>> getProfileModel(int userId) async {
    return const Failure(AppError.data('profile model not configured'));
  }

  @override
  Future<Result<UserCardModel, AppError>> getUserCard(int mid) async {
    return const Failure(AppError.data('user card not configured'));
  }

  @override
  Future<Result<ProfileVideo?, AppError>> getStickyVideo(int vmid) async {
    return const Success(null);
  }

  @override
  Future<Result<List<ProfileVideo>, AppError>> getMasterpiece(int vmid) async {
    return const Success(<ProfileVideo>[]);
  }

  @override
  Future<Result<List<ProfileVideo>, AppError>> getSpaceVideos({
    required int mid,
    int page = 1,
    String order = 'pubdate',
    bool forceRefresh = false,
    CancelToken? cancelToken,
  }) async {
    spaceVideoRequests.add(
      _SpaceVideoRequest(
        mid: mid,
        page: page,
        order: order,
        forceRefresh: forceRefresh,
        cancelToken: cancelToken,
      ),
    );
    return spaceVideos;
  }
}

final class _SpaceVideoRequest {
  const _SpaceVideoRequest({
    required this.mid,
    required this.page,
    required this.order,
    required this.forceRefresh,
    required this.cancelToken,
  });

  final int mid;
  final int page;
  final String order;
  final bool forceRefresh;
  final CancelToken? cancelToken;
}

ProfileVideo _profileVideo({required int aid, required String bvid}) {
  return ProfileVideo(
    aid: aid,
    bvid: bvid,
    title: 'Video $aid',
    pic: '',
    tname: 'Category',
    duration: 60,
    pubDate: 0,
    ctime: 0,
    desc: '',
    state: 0,
    attribute: 0,
    tid: 1,
    owner: const VideoOwner(mid: 1, name: 'Owner'),
    stats: const VideoStat(view: 1),
    reason: '',
    interVideo: false,
  );
}
