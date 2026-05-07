import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/auth/domain/entities/user_entity.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/to_view/domain/entities/to_view_entry.dart';
import 'package:culcul/features/to_view/domain/repositories/to_view_repository.dart';
import 'package:culcul/features/to_view/data/to_view_repository_impl.dart';
import 'package:culcul/features/to_view/presentation/view_models/to_view_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ToViewEntry _entry(int aid, {String title = 'Video'}) => ToViewEntry(
    aid: aid,
    bvid: 'BV$aid',
    title: title,
    coverUrl: '',
    duration: 100,
    progress: 0,
    ownerName: 'Owner',
    viewCount: 0,
    danmakuCount: 0,
  );

  AuthState _loggedIn() => AuthState(
    isLoggedIn: true,
    user: UserEntity(
      id: '1',
      username: 'tester',
      createdAt: DateTime(2024, 1, 1),
    ),
  );

  AuthState _loggedOut() => const AuthState(isLoggedIn: false);

  group('ToViewList', () {
    test('build returns entries from repository', () async {
      final entries = [_entry(1), _entry(2), _entry(3)];
      final repo = _FakeToViewRepository(
        getListResult: Success(entries),
      );
      final container = ProviderContainer(
        overrides: [
          authProvider.overrideWithValue(_loggedIn()),
          toViewRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(container.dispose);

      final result = await container.read(toViewListProvider.future);

      expect(result.length, 3);
      expect(result[0].aid, 1);
      expect(result[1].aid, 2);
      expect(result[2].aid, 3);
    });

    test('build returns empty list when not logged in', () async {
      final repo = _FakeToViewRepository(
        getListResult: const Success(<ToViewEntry>[]),
      );
      final container = ProviderContainer(
        overrides: [
          authProvider.overrideWithValue(_loggedOut()),
          toViewRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(container.dispose);

      final result = await container.read(toViewListProvider.future);

      expect(result, isEmpty);
      expect(repo.getListCalls, 0);
    });

    test('delete optimistically removes entry from state', () async {
      final entries = [_entry(1), _entry(2), _entry(3)];
      final repo = _FakeToViewRepository(
        getListResult: Success(entries),
        deleteResult: const Success(null),
      );
      final container = ProviderContainer(
        overrides: [
          authProvider.overrideWithValue(_loggedIn()),
          toViewRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(container.dispose);

      await container.read(toViewListProvider.future);
      await container.read(toViewListProvider.notifier).delete(2);

      final updated = container.read(toViewListProvider).value!;
      expect(updated.length, 2);
      expect(updated.map((e) => e.aid), [1, 3]);
    });

    test('delete does not remove entry when repository fails', () async {
      final entries = [_entry(1), _entry(2)];
      final repo = _FakeToViewRepository(
        getListResult: Success(entries),
        deleteResult: Failure(AppError.server('delete failed')),
      );
      final container = ProviderContainer(
        overrides: [
          authProvider.overrideWithValue(_loggedIn()),
          toViewRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(container.dispose);

      await container.read(toViewListProvider.future);
      await container.read(toViewListProvider.notifier).delete(1);

      final unchanged = container.read(toViewListProvider).value!;
      expect(unchanged.length, 2);
    });

    test('clear empties state on success', () async {
      final entries = [_entry(1), _entry(2)];
      final repo = _FakeToViewRepository(
        getListResult: Success(entries),
        clearResult: const Success(null),
      );
      final container = ProviderContainer(
        overrides: [
          authProvider.overrideWithValue(_loggedIn()),
          toViewRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(container.dispose);

      await container.read(toViewListProvider.future);
      await container.read(toViewListProvider.notifier).clear();

      final cleared = container.read(toViewListProvider).value!;
      expect(cleared, isEmpty);
    });

    test('clear does not empty state when repository fails', () async {
      final entries = [_entry(1), _entry(2)];
      final repo = _FakeToViewRepository(
        getListResult: Success(entries),
        clearResult: Failure(AppError.server('clear failed')),
      );
      final container = ProviderContainer(
        overrides: [
          authProvider.overrideWithValue(_loggedIn()),
          toViewRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(container.dispose);

      await container.read(toViewListProvider.future);
      await container.read(toViewListProvider.notifier).clear();

      final unchanged = container.read(toViewListProvider).value!;
      expect(unchanged.length, 2);
    });
  });
}

class _FakeToViewRepository implements ToViewRepository {
  _FakeToViewRepository({
    required this.getListResult,
    this.addResult = const Success(null),
    this.deleteResult = const Success(null),
    this.clearResult = const Success(null),
  });

  final Result<List<ToViewEntry>, AppError> getListResult;
  final Result<void, AppError> addResult;
  final Result<void, AppError> deleteResult;
  final Result<void, AppError> clearResult;

  int getListCalls = 0;
  int? lastAddAid;
  int? lastDeleteAid;
  int clearCalls = 0;

  @override
  Future<Result<List<ToViewEntry>, AppError>> getList() async {
    getListCalls++;
    return getListResult;
  }

  @override
  Future<Result<void, AppError>> add({required int aid}) async {
    lastAddAid = aid;
    return addResult;
  }

  @override
  Future<Result<void, AppError>> delete({required int aid}) async {
    lastDeleteAid = aid;
    return deleteResult;
  }

  @override
  Future<Result<void, AppError>> clear() async {
    clearCalls++;
    return clearResult;
  }
}
