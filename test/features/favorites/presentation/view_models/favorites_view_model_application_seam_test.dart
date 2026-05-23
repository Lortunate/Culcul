import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/favorites/application/favorites_application_providers.dart';
import 'package:culcul/features/favorites/application/favorites_port.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:culcul/features/favorites/presentation/view_models/favorites_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('created folders read through the application favorites provider', () async {
    final port = _FakeFavoritesPort(
      createdFolders: [
        _folder(id: 1, cover: 'https://example.test/existing.jpg'),
        _folder(id: 2, cover: ''),
      ],
      resourcesByPage: {
        1: _resourcePage(
          infoCover: 'https://example.test/generated.jpg',
          resources: [_resource(id: 20)],
        ),
      },
    );
    final container = _containerWith(port);
    addTearDown(container.dispose);

    final folders = await container.read(favCreatedFoldersProvider.future);

    expect(folders.map((folder) => folder.id), [1, 2]);
    expect(folders.last.cover, 'https://example.test/generated.jpg');
    expect(port.createdFolderRequests, [(upMid: 42, rid: null, type: null)]);
    expect(port.folderResourceRequests, [(mediaId: 2, page: 1)]);
  });

  test('collected folders paginate through the application favorites provider', () async {
    final port = _FakeFavoritesPort(
      collectedFoldersByPage: {
        1: [_folder(id: 10)],
        2: [_folder(id: 11)],
      },
    );
    final container = _containerWith(port);
    addTearDown(container.dispose);

    final provider = favCollectedFoldersProvider;
    final firstPage = await container.read(provider.future);
    await container.read(provider.notifier).loadMore();

    expect(firstPage.map((folder) => folder.id), [10]);
    expect(container.read(provider).value?.map((folder) => folder.id), [10, 11]);
    expect(port.collectedFolderRequests, [(upMid: 42, page: 1), (upMid: 42, page: 2)]);
  });

  test('folder resources paginate through the application favorites provider', () async {
    final port = _FakeFavoritesPort(
      resourcesByPage: {
        1: _resourcePage(resources: [_resource(id: 100)]),
        2: _resourcePage(resources: [_resource(id: 101)], hasMore: false),
      },
    );
    final container = _containerWith(port);
    addTearDown(container.dispose);

    final provider = favFolderResourcesProvider(9);
    final firstPage = await container.read(provider.future);
    await container.read(provider.notifier).loadMore(9);

    expect(firstPage.paging.items.map((resource) => resource.id), [100]);
    expect(container.read(provider).value?.paging.items.map((resource) => resource.id), [
      100,
      101,
    ]);
    expect(port.folderResourceRequests, [(mediaId: 9, page: 1), (mediaId: 9, page: 2)]);
  });

  test(
    'video favorite picker reads and writes through the application provider',
    () async {
      final port = _FakeFavoritesPort(createdFolders: [_folder(id: 1, favState: 1)]);
      final container = _containerWith(port);
      addTearDown(container.dispose);

      final folders = await container.read(videoFavoriteFoldersProvider(100).future);
      final result = await container
          .read(videoFavoriteCommandsProvider)
          .dealVideoFavorite(aid: 100, addMediaIds: const [2], delMediaIds: const [1]);

      expect(folders.map((folder) => folder.id), [1]);
      expect(result.isSuccess, isTrue);
      expect(port.createdFolderRequests, [(upMid: 42, rid: 100, type: 2)]);
      expect(port.videoFavoriteRequests, hasLength(1));
      expect(port.videoFavoriteRequests.single.aid, 100);
      expect(port.videoFavoriteRequests.single.addMediaIds, [2]);
      expect(port.videoFavoriteRequests.single.delMediaIds, [1]);
    },
  );
}

ProviderContainer _containerWith(_FakeFavoritesPort port) {
  return ProviderContainer(
    retry: (_, _) => null,
    overrides: [
      currentUserProvider.overrideWith((ref) => const _FakeUserSession(uid: '42')),
      favoritesPortProvider.overrideWithValue(port),
      dioClientProvider.overrideWith(
        (ref) => throw StateError(
          'favRepositoryProvider dependencies should not be read by favorites UI state',
        ),
      ),
    ],
  );
}

final class _FakeFavoritesPort implements FavoritesPort {
  _FakeFavoritesPort({
    this.createdFolders = const [],
    this.collectedFoldersByPage = const {},
    this.resourcesByPage = const {},
  });

  final List<FavoriteFolder> createdFolders;
  final Map<int, List<FavoriteFolder>> collectedFoldersByPage;
  final Map<int, FavoriteResourcePage> resourcesByPage;

  final createdFolderRequests = <({int upMid, int? rid, int? type})>[];
  final collectedFolderRequests = <({int upMid, int page})>[];
  final folderResourceRequests = <({int mediaId, int page})>[];
  final videoFavoriteRequests =
      <({int aid, List<int> addMediaIds, List<int> delMediaIds})>[];

  @override
  Future<Result<FavoriteFolderPage, AppError>> getCreatedFolders({
    required int upMid,
    int? rid,
    int? type,
  }) async {
    createdFolderRequests.add((upMid: upMid, rid: rid, type: type));
    return Success(
      FavoriteFolderPage(count: createdFolders.length, folders: createdFolders),
    );
  }

  @override
  Future<Result<FavoriteFolderPage, AppError>> getCollectedFolders({
    required int upMid,
    required int page,
  }) async {
    collectedFolderRequests.add((upMid: upMid, page: page));
    final folders = collectedFoldersByPage[page] ?? const <FavoriteFolder>[];
    return Success(FavoriteFolderPage(count: folders.length, folders: folders));
  }

  @override
  Future<Result<FavoriteResourcePage, AppError>> getFolderResources({
    required int mediaId,
    required int page,
    String? keyword,
    String? order,
    int? type,
    int? tid,
  }) async {
    folderResourceRequests.add((mediaId: mediaId, page: page));
    return Success(resourcesByPage[page] ?? _resourcePage());
  }

  @override
  Future<Result<FavoriteFolder, AppError>> createFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return Success(_folder(id: 1, title: title, cover: cover));
  }

  @override
  Future<Result<FavoriteFolder, AppError>> updateFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return Success(_folder(id: mediaId, title: title, cover: cover));
  }

  @override
  Future<Result<void, AppError>> deleteFolder({required String mediaIds}) async {
    return const Success(null);
  }

  @override
  Future<Result<void, AppError>> deleteResources({
    required String resources,
    required int mediaId,
  }) async {
    return const Success(null);
  }

  @override
  Future<Result<void, AppError>> dealVideoFavorite({
    required int aid,
    required Iterable<int> addMediaIds,
    required Iterable<int> delMediaIds,
  }) async {
    videoFavoriteRequests.add((
      aid: aid,
      addMediaIds: addMediaIds.toList(growable: false),
      delMediaIds: delMediaIds.toList(growable: false),
    ));
    return const Success(null);
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

FavoriteFolder _folder({
  required int id,
  int favState = 0,
  String title = 'folder',
  String? cover = 'https://example.test/folder.jpg',
}) {
  return FavoriteFolder(
    id: id,
    fid: id,
    mid: 42,
    attr: 0,
    title: title,
    favState: favState,
    mediaCount: 1,
    cover: cover,
    upper: _owner(),
    intro: null,
    ctime: null,
    mtime: null,
    state: null,
  );
}

FavoriteResourcePage _resourcePage({
  String infoCover = 'https://example.test/info.jpg',
  List<FavoriteResource> resources = const [],
  bool hasMore = true,
}) {
  return FavoriteResourcePage(
    info: FavoriteFolderInfo(
      id: 1,
      fid: 1,
      mid: 42,
      attr: 0,
      title: 'info',
      cover: infoCover,
      upper: _owner(),
      mediaCount: resources.length,
    ),
    medias: resources,
    hasMore: hasMore,
  );
}

FavoriteResource _resource({
  required int id,
  String cover = 'https://example.test/resource.jpg',
}) {
  return FavoriteResource(
    id: id,
    type: 2,
    title: 'resource $id',
    cover: cover,
    intro: '',
    page: 1,
    duration: 1,
    upper: _owner(),
    attr: 0,
    stats: const FavoriteResourceStats(collect: 1, play: 1, danmaku: 1),
    link: '',
    ctime: 1,
    pubtime: 1,
    favTime: 1,
    bvId: null,
    bvid: 'BV$id',
  );
}

VideoOwner _owner() {
  return const VideoOwner(mid: 42, name: 'owner');
}
