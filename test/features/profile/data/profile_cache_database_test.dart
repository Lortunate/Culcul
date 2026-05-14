import 'package:culcul/features/profile/data/dtos/profile_user.dart';
import 'package:culcul/features/profile/data/local/profile_cache_database.dart';
import 'package:culcul/features/profile/data/user_info_cache_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileCacheDatabase', () {
    late ProfileCacheDatabase database;
    late UserInfoCacheRepository repository;

    setUp(() {
      database = ProfileCacheDatabase(executor: NativeDatabase.memory());
      repository = UserInfoCacheRepository(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('warm read returns cached profile user', () async {
      final user = _profileUser('42');

      await repository.saveUser(user);

      expect(await repository.getUser('42'), user);
    });

    test('stale read respects ttl unless explicitly allowed', () async {
      final cachedAt = DateTime(2026, 1, 1, 10);
      final user = _profileUser('42');

      await repository.saveUser(user, now: cachedAt, ttl: const Duration(minutes: 5));

      expect(
        await repository.getUser('42', now: cachedAt.add(const Duration(minutes: 6))),
        isNull,
      );
      expect(
        await repository.getUser(
          '42',
          now: cachedAt.add(const Duration(minutes: 6)),
          allowStale: true,
        ),
        user,
      );
    });

    test('session invalidation clears sensitive rows', () async {
      await repository.saveUser(_profileUser('42'));
      await repository.saveUser(_profileUser('43'));

      await repository.clearAllUsers();

      expect(await repository.getUser('42', allowStale: true), isNull);
      expect(await repository.getUser('43', allowStale: true), isNull);
    });

    test('migration opens cleanly', () async {
      await database.customSelect('SELECT 1').getSingle();

      expect(database.schemaVersion, 1);
    });
  });
}

ProfileUser _profileUser(String id) {
  return ProfileUser(
    id: id,
    username: 'user-$id',
    avatarUrl: 'https://example.com/avatar-$id.png',
    bannerUrl: 'https://example.com/banner-$id.png',
    bio: 'bio-$id',
    location: 'Earth',
    followersCount: 10,
    followingCount: 2,
    videosCount: 3,
    dynamicCount: 4,
    likesCount: 5,
    level: 6,
    vipType: 1,
    vipStatus: 1,
    coins: 1.5,
    bCoins: 2.5,
    currentExp: 100,
    nextExp: 200,
    currentMinExp: 50,
    isFollowing: true,
    isVerified: false,
    createdAt: DateTime(2020, 1, 1),
  );
}
