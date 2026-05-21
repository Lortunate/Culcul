import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_cache_database.g.dart';

const profileUserCacheTtl = Duration(minutes: 30);

class CachedProfileUsers extends Table {
  TextColumn get userId => text()();
  TextColumn get username => text()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get bannerUrl => text().nullable()();
  TextColumn get bio => text().nullable()();
  TextColumn get location => text().nullable()();
  IntColumn get followersCount => integer()();
  IntColumn get followingCount => integer()();
  IntColumn get videosCount => integer()();
  IntColumn get dynamicCount => integer().withDefault(const Constant(0))();
  IntColumn get likesCount => integer().withDefault(const Constant(0))();
  IntColumn get level => integer().withDefault(const Constant(0))();
  IntColumn get vipType => integer().withDefault(const Constant(0))();
  IntColumn get vipStatus => integer().withDefault(const Constant(0))();
  RealColumn get coins => real().nullable()();
  RealColumn get bCoins => real().nullable()();
  IntColumn get currentExp => integer().nullable()();
  IntColumn get nextExp => integer().nullable()();
  IntColumn get currentMinExp => integer().nullable()();
  BoolColumn get isFollowing => boolean()();
  BoolColumn get isVerified => boolean()();
  IntColumn get createdAtMillis => integer().nullable()();
  IntColumn get cachedAtMillis => integer()();
  IntColumn get expiresAtMillis => integer()();

  @override
  Set<Column<Object>> get primaryKey => {userId};
}

@DriftDatabase(tables: [CachedProfileUsers])
class ProfileCacheDatabase extends _$ProfileCacheDatabase {
  ProfileCacheDatabase({QueryExecutor? executor}) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (m) => m.createAll());

  Future<void> upsertUser(
    ProfileUser user, {
    DateTime? now,
    Duration ttl = profileUserCacheTtl,
  }) async {
    final cachedAt = now ?? DateTime.now();
    await into(cachedProfileUsers).insertOnConflictUpdate(
      CachedProfileUsersCompanion.insert(
        userId: user.id,
        username: user.username,
        avatarUrl: Value(user.avatarUrl),
        bannerUrl: Value(user.bannerUrl),
        bio: Value(user.bio),
        location: Value(user.location),
        followersCount: user.followersCount,
        followingCount: user.followingCount,
        videosCount: user.videosCount,
        dynamicCount: Value(user.dynamicCount),
        likesCount: Value(user.likesCount),
        level: Value(user.level),
        vipType: Value(user.vipType),
        vipStatus: Value(user.vipStatus),
        coins: Value(user.coins),
        bCoins: Value(user.bCoins),
        currentExp: Value(user.currentExp),
        nextExp: Value(user.nextExp),
        currentMinExp: Value(user.currentMinExp),
        isFollowing: user.isFollowing,
        isVerified: user.isVerified,
        createdAtMillis: Value(user.createdAt?.millisecondsSinceEpoch),
        cachedAtMillis: cachedAt.millisecondsSinceEpoch,
        expiresAtMillis: cachedAt.add(ttl).millisecondsSinceEpoch,
      ),
    );
  }

  Future<ProfileUser?> getUser(
    String userId, {
    DateTime? now,
    bool allowStale = false,
  }) async {
    final row = await (select(
      cachedProfileUsers,
    )..where((user) => user.userId.equals(userId))).getSingleOrNull();
    if (row == null) return null;
    final currentTime = now ?? DateTime.now();
    if (!allowStale && row.expiresAtMillis < currentTime.millisecondsSinceEpoch) {
      return null;
    }
    return row.toProfileUser();
  }

  Future<void> deleteUser(String userId) async {
    await (delete(cachedProfileUsers)..where((user) => user.userId.equals(userId))).go();
  }

  Future<void> clearUsers() async {
    await delete(cachedProfileUsers).go();
  }
}

extension on CachedProfileUser {
  ProfileUser toProfileUser() {
    return ProfileUser(
      id: userId,
      username: username,
      avatarUrl: avatarUrl,
      bannerUrl: bannerUrl,
      bio: bio,
      location: location,
      followersCount: followersCount,
      followingCount: followingCount,
      videosCount: videosCount,
      dynamicCount: dynamicCount,
      likesCount: likesCount,
      level: level,
      vipType: vipType,
      vipStatus: vipStatus,
      coins: coins,
      bCoins: bCoins,
      currentExp: currentExp,
      nextExp: nextExp,
      currentMinExp: currentMinExp,
      isFollowing: isFollowing,
      isVerified: isVerified,
      createdAt: createdAtMillis == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(createdAtMillis!),
    );
  }
}

@Riverpod(keepAlive: true)
ProfileCacheDatabase profileCacheDatabase(Ref ref) {
  final database = ProfileCacheDatabase();
  ref.onDispose(database.close);
  return database;
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'profile_cache.sqlite', native: const DriftNativeOptions());
}
