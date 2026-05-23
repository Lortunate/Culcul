import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/application/profile_read_application_providers.dart';
import 'package:culcul/features/profile/application/profile_read_port.dart';
import 'package:culcul/features/profile/application/profile_session_providers.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('user profile info reads through the profile read application provider', () async {
    final profile = _profileUser('42', username: 'alice');
    final port = _FakeProfileReadPort(profileModel: Success(profile));
    final container = ProviderContainer(
      overrides: [
        profileReadPortProvider.overrideWithValue(port),
        profileRepositoryProvider.overrideWith(
          (ref) => throw StateError(
            'profileRepositoryProvider should not be read by application state',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final result = await container.read(userProfileInfoProvider('42').future);

    expect(result?.mid, '42');
    expect(result?.name, 'alice');
    expect(result?.face, '');
    expect(port.profileModelRequests, const [42]);
    expect(port.profileRequests, isEmpty);
    expect(port.userCardRequests, isEmpty);
  });

  test('user profile card reads through the profile read application provider', () async {
    const card = UserCardModel(
      mid: '43',
      name: 'bob',
      face: 'https://example.test/bob.png',
    );
    final port = _FakeProfileReadPort(userCard: const Success(card));
    final container = ProviderContainer(
      overrides: [
        profileReadPortProvider.overrideWithValue(port),
        profileRepositoryProvider.overrideWith(
          (ref) => throw StateError(
            'profileRepositoryProvider should not be read by application state',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final result = await container.read(userProfileCardProvider('43').future);

    expect(result.isSuccess, isTrue);
    expect(result.dataOrNull, card);
    expect(port.userCardRequests, const [43]);
    expect(port.profileRequests, isEmpty);
    expect(port.profileModelRequests, isEmpty);
  });
}

final class _FakeProfileReadPort implements ProfileReadPort {
  _FakeProfileReadPort({
    this.profileModel = const Failure(AppError.data('profile model not configured')),
    this.userCard = const Failure(AppError.data('user card not configured')),
  });

  final Result<ProfileUser, AppError> profileModel;
  final Result<UserCardModel, AppError> userCard;
  final profileRequests = <int>[];
  final profileModelRequests = <int>[];
  final userCardRequests = <int>[];

  @override
  Future<Result<ProfileUser, AppError>> getProfile(int userId) async {
    profileRequests.add(userId);
    return const Failure(AppError.data('profile not configured'));
  }

  @override
  Future<Result<ProfileUser, AppError>> getProfileModel(int userId) async {
    profileModelRequests.add(userId);
    return profileModel;
  }

  @override
  Future<Result<UserCardModel, AppError>> getUserCard(int mid) async {
    userCardRequests.add(mid);
    return userCard;
  }
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
