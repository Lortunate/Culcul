import 'package:culcul/core/session/session_lifecycle_providers.dart';
import 'package:culcul/features/profile/application/profile_cache_application_providers.dart';
import 'package:culcul/features/profile/application/profile_cache_port.dart';
import 'package:culcul/features/profile/application/profile_session_cleanup.dart';
import 'package:culcul/features/profile/data/profile_cache_repository.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('logout cleanup clears profile cache through the application port', () async {
    final cache = _FakeProfileCachePort();
    final container = ProviderContainer(
      overrides: [
        profileCachePortProvider.overrideWithValue(cache),
        profileCacheRepositoryProvider.overrideWith(
          (ref) => throw StateError(
            'profileCacheRepositoryProvider should not be read by session cleanup',
          ),
        ),
        sessionLogoutCleanerProvider.overrideWith(createProfileSessionLogoutCleaner),
      ],
    );
    addTearDown(container.dispose);

    await container.read(sessionLogoutCleanerProvider).clearAfterLogout();

    expect(cache.clearAllCalls, 1);
  });
}

final class _FakeProfileCachePort implements ProfileCachePort {
  var clearAllCalls = 0;

  @override
  Future<ProfileUser?> readProfile(String userId) async => null;

  @override
  Future<void> writeProfile(ProfileUser profile) async {}

  @override
  Future<void> clearProfile(String userId) async {}

  @override
  Future<void> clearAll() async {
    clearAllCalls += 1;
  }
}
