import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/auth/auth.dart';
import 'package:culcul/features/favorites/data/fav_repository_impl.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:culcul/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:culcul/features/favorites/presentation/view_models/favorites_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _FavFakeRepository implements FavoriteRepository {
  _FavFakeRepository(this._pages);

  final List<Result<FavoriteResourcePage, AppError>> _pages;

  static const FavoriteOwner _owner = FavoriteOwner(mid: 1, name: 'u', face: 'f');
  static const FavoriteFolderInfo _info = FavoriteFolderInfo(
    id: 1,
    fid: 1,
    mid: 1,
    attr: 0,
    title: 'folder',
    cover: 'cover',
    upper: _owner,
    mediaCount: 99,
  );

  @override
  Future<Result<FavoriteResourcePage, AppError>> getFolderResources(
    FavoriteFolderResourcesQuery query,
  ) async {
    final page = query.page;
    if (page <= _pages.length) {
      return _pages[page - 1];
    }
    return const Success(
      FavoriteResourcePage(info: _info, medias: <FavoriteResource>[], hasMore: false),
    );
  }

  @override
  Future<Result<FavoriteFolderPage, AppError>> getCreatedFolders({
    required int upMid,
  }) async => throw UnimplementedError();

  @override
  Future<Result<FavoriteFolderPage, AppError>> getCollectedFolders(
    FavoriteFolderListQuery query,
  ) async => throw UnimplementedError();

  @override
  Future<Result<FavoriteFolder, AppError>> createFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async => throw UnimplementedError();

  @override
  Future<Result<FavoriteFolder, AppError>> updateFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async => throw UnimplementedError();

  @override
  Future<Result<void, AppError>> deleteFolder({required String mediaIds}) async =>
      throw UnimplementedError();

  @override
  Future<Result<void, AppError>> deleteResources({
    required String resources,
    required int mediaId,
  }) async => throw UnimplementedError();

  @override
  Future<Result<void, AppError>> cleanInvalidResources({required int mediaId}) async =>
      throw UnimplementedError();
}

class _CreatedFoldersRepository implements FavoriteRepository {
  int inFlight = 0;
  int maxInFlight = 0;

  static const FavoriteOwner _owner = FavoriteOwner(mid: 1, name: 'u', face: 'f');

  @override
  Future<Result<FavoriteFolderPage, AppError>> getCreatedFolders({
    required int upMid,
  }) async {
    return Success(
      FavoriteFolderPage(
        count: 6,
        folders: List<FavoriteFolder>.generate(
          6,
          (index) => FavoriteFolder(
            id: index + 1,
            fid: index + 1,
            mid: upMid,
            attr: 0,
            title: 'folder-${index + 1}',
            favState: 0,
            mediaCount: 1,
            cover: '',
            upper: _owner,
            intro: null,
            ctime: null,
            mtime: null,
            state: null,
          ),
        ),
      ),
    );
  }

  @override
  Future<Result<FavoriteResourcePage, AppError>> getFolderResources(
    FavoriteFolderResourcesQuery query,
  ) async {
    final mediaId = query.mediaId;
    inFlight++;
    if (inFlight > maxInFlight) {
      maxInFlight = inFlight;
    }
    try {
      await Future<void>.delayed(const Duration(milliseconds: 90));
      return Success(
        FavoriteResourcePage(
          info: FavoriteFolderInfo(
            id: mediaId,
            fid: mediaId,
            mid: 1,
            attr: 0,
            title: 'folder-$mediaId',
            cover: 'https://cover-$mediaId.jpg',
            upper: _owner,
            mediaCount: 1,
          ),
          medias: <FavoriteResource>[],
          hasMore: false,
        ),
      );
    } finally {
      inFlight--;
    }
  }

  @override
  Future<Result<FavoriteFolderPage, AppError>> getCollectedFolders(
    FavoriteFolderListQuery query,
  ) async => throw UnimplementedError();

  @override
  Future<Result<FavoriteFolder, AppError>> createFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async => throw UnimplementedError();

  @override
  Future<Result<FavoriteFolder, AppError>> updateFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async => throw UnimplementedError();

  @override
  Future<Result<void, AppError>> deleteFolder({required String mediaIds}) async =>
      throw UnimplementedError();

  @override
  Future<Result<void, AppError>> deleteResources({
    required String resources,
    required int mediaId,
  }) async => throw UnimplementedError();

  @override
  Future<Result<void, AppError>> cleanInvalidResources({required int mediaId}) async =>
      throw UnimplementedError();
}

FavoriteResource _resource(int id) {
  const owner = FavoriteOwner(mid: 1, name: 'u', face: 'f');
  return FavoriteResource(
    id: id,
    type: 2,
    title: 'title-$id',
    cover: 'cover-$id',
    intro: '',
    page: 1,
    duration: 1,
    upper: owner,
    attr: 0,
    stats: const FavoriteResourceStats(collect: 0, play: 0, danmaku: 0),
    link: 'link-$id',
    ctime: 1,
    pubtime: 1,
    favTime: 1,
    bvId: 'BV$id',
    bvid: 'BV$id',
  );
}

void main() {
  test('FavFolderResources loadMore merges uniquely and updates paging flags', () async {
    final repository = _FavFakeRepository(<Result<FavoriteResourcePage, AppError>>[
      const Success(
        FavoriteResourcePage(
          info: _FavFakeRepository._info,
          medias: <FavoriteResource>[],
          hasMore: true,
        ),
      ),
      Success(
        FavoriteResourcePage(
          info: _FavFakeRepository._info,
          medias: <FavoriteResource>[_resource(1), _resource(2)],
          hasMore: true,
        ),
      ),
      Success(
        FavoriteResourcePage(
          info: _FavFakeRepository._info,
          medias: <FavoriteResource>[_resource(2), _resource(3)],
          hasMore: false,
        ),
      ),
    ]);
    final container = ProviderContainer(
      overrides: [favRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final provider = favFolderResourcesProvider(1);
    final initial = await container.read(provider.future);
    expect(initial.paging.hasMore, isTrue);
    expect(initial.paging.nextPage, 2);

    await container.read(provider.notifier).loadMore(1);
    final afterFirst = container.read(provider).value!;
    expect(afterFirst.paging.items.map((e) => e.id).toList(), <int>[1, 2]);
    expect(afterFirst.paging.hasMore, isTrue);
    expect(afterFirst.paging.nextPage, 3);
    expect(afterFirst.paging.isLoadingMore, isFalse);

    await container.read(provider.notifier).loadMore(1);
    final afterSecond = container.read(provider).value!;
    expect(afterSecond.paging.items.map((e) => e.id).toList(), <int>[1, 2, 3]);
    expect(afterSecond.paging.hasMore, isFalse);
    expect(afterSecond.paging.nextPage, 4);
    expect(afterSecond.paging.isLoadingMore, isFalse);
  });

  test(
    'FavFolderResources keeps hasMore and surfaces error when next page fails',
    () async {
      final repository = _FavFakeRepository(<Result<FavoriteResourcePage, AppError>>[
        Success(
          FavoriteResourcePage(
            info: _FavFakeRepository._info,
            medias: <FavoriteResource>[_resource(1)],
            hasMore: true,
          ),
        ),
        Failure(AppError.data('load-failed')),
      ]);
      final container = ProviderContainer(
        overrides: [favRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      final provider = favFolderResourcesProvider(1);
      await container.read(provider.future);
      await expectLater(
        container.read(provider.notifier).loadMore(1),
        throwsA(isA<AppError>()),
      );

      final latest = container.read(provider).value!;
      expect(latest.paging.items.map((e) => e.id).toList(), <int>[1]);
      expect(latest.paging.hasMore, isTrue);
      expect(latest.paging.isLoadingMore, isFalse);
      expect(latest.paging.error, isA<AppError>());
    },
  );

  test('FavCreatedFolders enriches covers with bounded concurrency', () async {
    final repository = _CreatedFoldersRepository();
    final container = ProviderContainer(
      overrides: [
        authProvider.overrideWithValue(
          AuthState(
            isLoggedIn: true,
            isLoading: false,
            user: UserEntity(
              id: '1001',
              username: 'tester',
              createdAt: DateTime(2024, 1, 1),
            ),
          ),
        ),
        favRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    final folders = await container.read(favCreatedFoldersProvider.future);
    expect(folders.length, 6);
    expect(folders.every((item) => (item.cover ?? '').isNotEmpty), isTrue);
    expect(repository.maxInFlight, lessThanOrEqualTo(4));
  });
}
