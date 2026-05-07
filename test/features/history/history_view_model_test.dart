import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/history/domain/repositories/history_repository.dart';
import 'package:culcul/features/history/domain/entities/history_entry.dart';
import 'package:culcul/features/history/feature_scope.dart';
import 'package:culcul/features/history/presentation/view_models/history_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeHistoryRepository implements HistoryRepository {
  _FakeHistoryRepository({required this.result});

  final Result<List<HistoryEntry>, AppError> result;

  @override
  Future<Result<List<HistoryEntry>, AppError>> getHistory({
    int max = 0,
    int viewAt = 0,
  }) async {
    return result;
  }
}

List<HistoryEntry> _entries(int count) {
  return List.generate(
    count,
    (i) => HistoryEntry(
      title: 'Video $i',
      coverUrl: 'https://img.example.com/$i.jpg',
      bvid: 'BV$i',
      business: 'archive',
      authorName: 'Author $i',
      viewedAt: 1700000000 + i,
      progress: i * 100,
      duration: i * 200,
      badge: '',
    ),
  );
}

void main() {
  group('HistoryList', () {
    test('build() returns entries from repository', () async {
      final entries = _entries(3);
      final fakeRepo = _FakeHistoryRepository(
        result: Success(entries),
      );

      final container = ProviderContainer(
        overrides: [
          historyRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);

      final result = await container.read(historyListProvider.future);

      expect(result, hasLength(3));
      expect(result[0].title, 'Video 0');
      expect(result[0].authorName, 'Author 0');
      expect(result[1].title, 'Video 1');
      expect(result[1].authorName, 'Author 1');
      expect(result[2].title, 'Video 2');
      expect(result[2].authorName, 'Author 2');
    });

    test('build() returns empty list when repository returns empty', () async {
      final fakeRepo = _FakeHistoryRepository(
        result: const Success(<HistoryEntry>[]),
      );

      final container = ProviderContainer(
        overrides: [
          historyRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);

      final result = await container.read(historyListProvider.future);

      expect(result, isEmpty);
    });

    test('build() returns empty list when repository returns failure', () async {
      final fakeRepo = _FakeHistoryRepository(
        result: Failure(AppError.server('server error')),
      );

      final container = ProviderContainer(
        overrides: [
          historyRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);

      final result = await container.read(historyListProvider.future);

      // dataOrNull is null on failure, so fallback to empty list
      expect(result, isEmpty);
    });

    test('build() preserves entry field values from repository', () async {
      final entry = HistoryEntry(
        title: 'Specific Title',
        coverUrl: 'https://specific.jpg',
        bvid: 'BVspecific',
        business: 'pgc',
        authorName: 'Specific Author',
        viewedAt: 1700009999,
        progress: 42,
        duration: 3600,
        badge: 'vip',
      );
      final fakeRepo = _FakeHistoryRepository(
        result: Success([entry]),
      );

      final container = ProviderContainer(
        overrides: [
          historyRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);

      final result = await container.read(historyListProvider.future);

      expect(result, hasLength(1));
      final item = result.single;
      expect(item.title, 'Specific Title');
      expect(item.coverUrl, 'https://specific.jpg');
      expect(item.bvid, 'BVspecific');
      expect(item.business, 'pgc');
      expect(item.authorName, 'Specific Author');
      expect(item.viewedAt, 1700009999);
      expect(item.progress, 42);
      expect(item.duration, 3600);
      expect(item.badge, 'vip');
    });
  });
}
