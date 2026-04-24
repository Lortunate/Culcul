import 'package:culcul/features/favorites/application/favorite_folder_commands.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:culcul/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavoriteFolderCommandWorkflow', () {
    test('createFolder propagates repository failure', () async {
      final repository = _FakeFavoriteRepository()
        ..createFolderResult = Failure(AppError.server('create failed'));
      final workflow = FavoriteFolderCommandWorkflow(repository);

      final result = await workflow.createFolder(
        title: 'Folder',
        intro: 'Intro',
        privacy: 1,
      );

      expect(result.isFailure, isTrue);
      expect(result.errorOrNull?.message, 'create failed');
      expect(repository.createFolderCalls, 1);
    });

    test('createFolder delegates to repository and maps success to void', () async {
      final repository = _FakeFavoriteRepository();
      final workflow = FavoriteFolderCommandWorkflow(repository);

      final result = await workflow.createFolder(
        title: 'Folder',
        intro: 'Intro',
        privacy: 1,
      );

      expect(result.isSuccess, isTrue);
      expect(repository.createFolderCalls, 1);
      expect(repository.lastTitle, 'Folder');
      expect(repository.lastIntro, 'Intro');
      expect(repository.lastPrivacy, 1);
    });

    test('editFolder propagates repository failure', () async {
      final repository = _FakeFavoriteRepository()
        ..updateFolderResult = Failure(AppError.server('update failed'));
      final workflow = FavoriteFolderCommandWorkflow(repository);

      final result = await workflow.editFolder(
        mediaId: 42,
        title: 'Changed',
        intro: 'Updated',
        privacy: 0,
      );

      expect(result.isFailure, isTrue);
      expect(result.errorOrNull?.message, 'update failed');
      expect(repository.updateFolderCalls, 1);
    });

    test('editFolder delegates to repository and maps success to void', () async {
      final repository = _FakeFavoriteRepository();
      final workflow = FavoriteFolderCommandWorkflow(repository);

      final result = await workflow.editFolder(
        mediaId: 42,
        title: 'Changed',
        intro: 'Updated',
        privacy: 0,
      );

      expect(result.isSuccess, isTrue);
      expect(repository.updateFolderCalls, 1);
      expect(repository.lastTitle, 'Changed');
      expect(repository.lastIntro, 'Updated');
      expect(repository.lastPrivacy, 0);
    });

    test('deleteFolder delegates using string mediaIds', () async {
      final repository = _FakeFavoriteRepository();
      final workflow = FavoriteFolderCommandWorkflow(repository);

      final result = await workflow.deleteFolder(mediaId: 9);

      expect(result.isSuccess, isTrue);
      expect(repository.deleteFolderCalls, 1);
      expect(repository.lastDeletedMediaIds, '9');
    });

    test('deleteFolder propagates repository failure', () async {
      final repository = _FakeFavoriteRepository()
        ..deleteFolderResult = Failure(AppError.server('delete failed'));
      final workflow = FavoriteFolderCommandWorkflow(repository);

      final result = await workflow.deleteFolder(mediaId: 9);

      expect(result.isFailure, isTrue);
      expect(result.errorOrNull?.message, 'delete failed');
      expect(repository.deleteFolderCalls, 1);
      expect(repository.lastDeletedMediaIds, '9');
    });

    test('deleteResources joins resource ids before delegating', () async {
      final repository = _FakeFavoriteRepository();
      final workflow = FavoriteFolderCommandWorkflow(repository);

      final result = await workflow.deleteResources(mediaId: 7, resourceIds: <int>{3, 5});

      expect(result.isSuccess, isTrue);
      expect(repository.deleteResourcesCalls, 1);
      expect(repository.lastResourceIds, anyOf('3,5', '5,3'));
      expect(repository.lastResourceMediaId, 7);
    });

    test('deleteResources propagates repository failure', () async {
      final repository = _FakeFavoriteRepository()
        ..deleteResourcesResult = Failure(AppError.server('resource delete failed'));
      final workflow = FavoriteFolderCommandWorkflow(repository);

      final result = await workflow.deleteResources(mediaId: 7, resourceIds: <int>{3, 5});

      expect(result.isFailure, isTrue);
      expect(result.errorOrNull?.message, 'resource delete failed');
      expect(repository.deleteResourcesCalls, 1);
      expect(repository.lastResourceIds, anyOf('3,5', '5,3'));
      expect(repository.lastResourceMediaId, 7);
    });
  });
}

class _FakeFavoriteRepository implements FavoriteRepository {
  int createFolderCalls = 0;
  int updateFolderCalls = 0;
  int deleteFolderCalls = 0;
  int deleteResourcesCalls = 0;

  String? lastTitle;
  String? lastIntro;
  int? lastPrivacy;
  String? lastDeletedMediaIds;
  String? lastResourceIds;
  int? lastResourceMediaId;

  Result<FavoriteFolder, AppError> createFolderResult = Success(_folder());
  Result<FavoriteFolder, AppError> updateFolderResult = Success(_folder());
  Result<void, AppError> deleteFolderResult = const Success(null);
  Result<void, AppError> deleteResourcesResult = const Success(null);

  @override
  Future<Result<FavoriteFolder, AppError>> createFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    createFolderCalls++;
    lastTitle = title;
    lastIntro = intro;
    lastPrivacy = privacy;
    return createFolderResult;
  }

  @override
  Future<Result<FavoriteFolder, AppError>> updateFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    updateFolderCalls++;
    lastTitle = title;
    lastIntro = intro;
    lastPrivacy = privacy;
    return updateFolderResult;
  }

  @override
  Future<Result<void, AppError>> deleteFolder({required String mediaIds}) async {
    deleteFolderCalls++;
    lastDeletedMediaIds = mediaIds;
    return deleteFolderResult;
  }

  @override
  Future<Result<void, AppError>> deleteResources({
    required String resources,
    required int mediaId,
  }) async {
    deleteResourcesCalls++;
    lastResourceIds = resources;
    lastResourceMediaId = mediaId;
    return deleteResourcesResult;
  }

  @override
  Future<Result<void, AppError>> cleanInvalidResources({required int mediaId}) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<FavoriteFolderPage, AppError>> getCollectedFolders(
    FavoriteFolderListQuery query,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<FavoriteFolderPage, AppError>> getCreatedFolders({
    required int upMid,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<FavoriteResourcePage, AppError>> getFolderResources(
    FavoriteFolderResourcesQuery query,
  ) async {
    throw UnimplementedError();
  }
}

FavoriteFolder _folder() {
  return const FavoriteFolder(
    id: 1,
    fid: 1,
    mid: 2,
    attr: 0,
    title: 'Folder',
    favState: 0,
    mediaCount: 0,
    cover: null,
    upper: null,
    intro: null,
    ctime: null,
    mtime: null,
    state: null,
  );
}
