import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/application/user_space_application_providers.dart';
import 'package:culcul/features/profile/application/user_space_port.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/features/profile/presentation/view_models/user_space_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test(
    'user space profile reads through the profile user-space application port',
    () async {
      const profile = ProfileUser(
        id: '42',
        username: 'alice',
        followersCount: 10,
        followingCount: 2,
        videosCount: 3,
        isFollowing: false,
        isVerified: true,
      );
      final port = _FakeUserSpacePort(profile: const Success(profile));
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

      final result = await container.read(userSpaceProvider('42').future);

      expect(result, profile);
      expect(port.profileRequests, const [42]);
    },
  );

  test('user space profile propagates application port failures', () async {
    const error = AppError.server('profile failed');
    final port = _FakeUserSpacePort(profile: const Failure(error));
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
      container.read(userSpaceProvider('43').future),
      throwsA(same(error)),
    );
    expect(port.profileRequests, const [43]);
  });
}

final class _FakeUserSpacePort implements UserSpacePort {
  _FakeUserSpacePort({
    this.profile = const Failure(AppError.data('profile not configured')),
  });

  final Result<ProfileUser, AppError> profile;
  final profileRequests = <int>[];

  @override
  Future<Result<ProfileUser, AppError>> getProfile(int userId) async {
    profileRequests.add(userId);
    return profile;
  }

  @override
  Future<Result<ProfileVideo?, AppError>> getStickyVideo(int vmid) async {
    return const Success(null);
  }

  @override
  Future<Result<List<ProfileVideo>, AppError>> getMasterpiece(int vmid) async {
    return const Success(<ProfileVideo>[]);
  }
}
