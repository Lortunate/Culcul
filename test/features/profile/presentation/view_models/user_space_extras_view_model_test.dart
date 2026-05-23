import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/application/user_space_application_providers.dart';
import 'package:culcul/features/profile/application/user_space_port.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/features/profile/presentation/view_models/user_space_extras_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test(
    'user sticky video reads through the profile user-space application port',
    () async {
      final sticky = _profileVideo(aid: 1, bvid: 'BV1xx411c7mD');
      final port = _FakeUserSpacePort(stickyVideo: Success(sticky));
      final container = ProviderContainer(
        retry: (_, _) => null,
        overrides: [
          userSpacePortProvider.overrideWithValue(port),
          profileRepositoryProvider.overrideWith(
            (ref) => throw StateError(
              'profileRepositoryProvider should not be read by UI state',
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final result = await container.read(userStickyVideoProvider(42).future);

      expect(result, sticky);
      expect(port.stickyRequests, const [42]);
    },
  );

  test(
    'user masterpieces read through the profile user-space application port',
    () async {
      final video = _profileVideo(aid: 2, bvid: 'BV1xx411c7mE');
      final port = _FakeUserSpacePort(masterpieces: Success([video]));
      final container = ProviderContainer(
        retry: (_, _) => null,
        overrides: [
          userSpacePortProvider.overrideWithValue(port),
          profileRepositoryProvider.overrideWith(
            (ref) => throw StateError(
              'profileRepositoryProvider should not be read by UI state',
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final result = await container.read(userMasterpiecesProvider(43).future);

      expect(result, [video]);
      expect(port.masterpieceRequests, const [43]);
    },
  );

  test('user masterpieces propagates application port failures', () async {
    const error = AppError.server('masterpiece failed');
    final port = _FakeUserSpacePort(masterpieces: const Failure(error));
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        userSpacePortProvider.overrideWithValue(port),
        profileRepositoryProvider.overrideWith(
          (ref) => throw StateError(
            'profileRepositoryProvider should not be read by UI state',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    await expectLater(
      container.read(userMasterpiecesProvider(44).future),
      throwsA(same(error)),
    );
    expect(port.masterpieceRequests, const [44]);
  });
}

final class _FakeUserSpacePort implements UserSpacePort {
  _FakeUserSpacePort({
    this.stickyVideo = const Success(null),
    this.masterpieces = const Success(<ProfileVideo>[]),
  });

  final Result<ProfileVideo?, AppError> stickyVideo;
  final Result<List<ProfileVideo>, AppError> masterpieces;
  final stickyRequests = <int>[];
  final masterpieceRequests = <int>[];

  @override
  Future<Result<ProfileUser, AppError>> getProfile(int userId) async {
    return const Failure(AppError.data('profile not configured'));
  }

  @override
  Future<Result<ProfileVideo?, AppError>> getStickyVideo(int vmid) async {
    stickyRequests.add(vmid);
    return stickyVideo;
  }

  @override
  Future<Result<List<ProfileVideo>, AppError>> getMasterpiece(int vmid) async {
    masterpieceRequests.add(vmid);
    return masterpieces;
  }
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
    owner: const VideoOwner(mid: 1, name: 'Uploader'),
    stats: const VideoStat(),
    reason: '',
    interVideo: false,
  );
}
