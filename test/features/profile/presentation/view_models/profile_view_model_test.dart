import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/profile/application/profile_read_application_providers.dart';
import 'package:culcul/features/profile/application/profile_read_port.dart';
import 'package:culcul/features/profile/data/profile_cache_repository.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('my profile reads through the profile read application provider', () async {
    final profile = _profileUser('42', username: 'alice');
    final port = _FakeProfileReadPort(profile: Success(profile));
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        currentUserProvider.overrideWith((ref) => const _FakeUserSession(uid: '42')),
        profileReadPortProvider.overrideWithValue(port),
        profileRepositoryProvider.overrideWith(
          (ref) => throw StateError(
            'profileRepositoryProvider should not be read by UI state',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final result = await container.read(myProfileProvider.future);

    expect(result, profile);
    expect(port.profileRequests, const [42]);
    expect(port.profileModelRequests, isEmpty);
    expect(port.userCardRequests, isEmpty);
  });

  test(
    'user profile notifier reads through the profile read application provider',
    () async {
      final profile = _profileUser('43', username: 'bob');
      final port = _FakeProfileReadPort(profile: Success(profile));
      final container = ProviderContainer(
        retry: (_, _) => null,
        overrides: [
          profileReadPortProvider.overrideWithValue(port),
          profileCacheRepositoryProvider.overrideWith(
            (ref) => _FakeProfileCacheRepository(),
          ),
          profileRepositoryProvider.overrideWith(
            (ref) => throw StateError(
              'profileRepositoryProvider should not be read by UI state',
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final result = await container.read(userProfileProvider('43').future);

      expect(result, profile);
      expect(port.profileRequests, const [43]);
      expect(port.profileModelRequests, isEmpty);
      expect(port.userCardRequests, isEmpty);
    },
  );
}

final class _FakeProfileReadPort implements ProfileReadPort {
  _FakeProfileReadPort({
    this.profile = const Failure(AppError.data('profile not configured')),
  });

  final Result<ProfileUser, AppError> profile;
  final profileRequests = <int>[];
  final profileModelRequests = <int>[];
  final userCardRequests = <int>[];

  @override
  Future<Result<ProfileUser, AppError>> getProfile(int userId) async {
    profileRequests.add(userId);
    return profile;
  }

  @override
  Future<Result<ProfileUser, AppError>> getProfileModel(int userId) async {
    profileModelRequests.add(userId);
    return const Failure(AppError.data('profile model not configured'));
  }

  @override
  Future<Result<UserCardModel, AppError>> getUserCard(int mid) async {
    userCardRequests.add(mid);
    return const Failure(AppError.data('user card not configured'));
  }
}

final class _FakeUserSession implements UserSession {
  const _FakeUserSession({required this.uid});

  @override
  final String uid;

  @override
  bool get isLoggedIn => true;

  @override
  String? get avatarUrl => null;

  @override
  String? get nickname => null;
}

final class _FakeProfileCacheRepository implements ProfileCacheRepositoryImpl {
  final writtenProfiles = <ProfileUser>[];

  @override
  Future<ProfileUser?> readProfile(String userId) async {
    return null;
  }

  @override
  Future<void> writeProfile(ProfileUser profile) async {
    writtenProfiles.add(profile);
  }

  @override
  Future<void> clearProfile(String userId) async {}

  @override
  Future<void> clearAll() async {}
}

ProfileUser _profileUser(String id, {required String username}) {
  return ProfileUser(
    id: id,
    username: username,
    followersCount: 0,
    followingCount: 0,
    videosCount: 0,
    isFollowing: false,
    isVerified: false,
  );
}
