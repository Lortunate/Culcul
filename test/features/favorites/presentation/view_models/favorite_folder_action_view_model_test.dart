import 'package:culcul/features/favorites/application/favorite_folder_commands.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:culcul/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:culcul/features/favorites/feature_scope.dart';
import 'package:culcul/features/favorites/presentation/view_models/favorite_folder_action_view_model.dart';
import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('FavoriteFolderActionViewModel', () {
    test('createFolder delegates to workflow provider', () async {
      final workflow = _SpyFavoriteFolderWorkflow();
      final container = ProviderContainer(
        overrides: [
          favRepositoryProvider.overrideWithValue(_ThrowingFavoriteRepository()),
          favoriteFolderCommandWorkflowProvider.overrideWithValue(workflow),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(
        favoriteFolderActionViewModelProvider.notifier,
      );

      final error = await notifier.createFolder(
        title: 'Folder',
        intro: 'Intro',
        privacy: 1,
      );

      expect(error, isNull);
      expect(workflow.createFolderCalls, 1);
      expect(workflow.lastCreateTitle, 'Folder');
      expect(workflow.lastCreateIntro, 'Intro');
      expect(workflow.lastCreatePrivacy, 1);
      expect(
        container.read(favoriteFolderActionViewModelProvider),
        const AsyncData<void>(null),
      );
    });

    test('editFolder returns workflow error', () async {
      final workflow = _SpyFavoriteFolderWorkflow()
        ..editFolderResult = Failure(AppError.server('edit failed'));
      final container = ProviderContainer(
        overrides: [
          favRepositoryProvider.overrideWithValue(_ThrowingFavoriteRepository()),
          favoriteFolderCommandWorkflowProvider.overrideWithValue(workflow),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(
        favoriteFolderActionViewModelProvider.notifier,
      );

      final error = await notifier.editFolder(
        mediaId: 9,
        title: 'Changed',
        intro: 'Updated',
        privacy: 0,
      );

      expect(error?.message, 'edit failed');
      expect(workflow.editFolderCalls, 1);
      expect(workflow.lastEditMediaId, 9);
      expect(workflow.lastEditTitle, 'Changed');
      expect(workflow.lastEditIntro, 'Updated');
      expect(workflow.lastEditPrivacy, 0);
    });

    test('deleteFolder delegates media id conversion to workflow', () async {
      final workflow = _SpyFavoriteFolderWorkflow();
      final container = ProviderContainer(
        overrides: [
          favRepositoryProvider.overrideWithValue(_ThrowingFavoriteRepository()),
          favoriteFolderCommandWorkflowProvider.overrideWithValue(workflow),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(
        favoriteFolderActionViewModelProvider.notifier,
      );

      final error = await notifier.deleteFolder(mediaId: 42);

      expect(error, isNull);
      expect(workflow.deleteFolderCalls, 1);
      expect(workflow.lastDeleteMediaId, 42);
    });

    test('deleteResources delegates resource ids to workflow', () async {
      final workflow = _SpyFavoriteFolderWorkflow();
      final container = ProviderContainer(
        overrides: [
          favRepositoryProvider.overrideWithValue(_ThrowingFavoriteRepository()),
          favoriteFolderCommandWorkflowProvider.overrideWithValue(workflow),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(
        favoriteFolderActionViewModelProvider.notifier,
      );

      final error = await notifier.deleteResources(
        mediaId: 7,
        resourceIds: <int>{1, 3},
      );

      expect(error, isNull);
      expect(workflow.deleteResourcesCalls, 1);
      expect(workflow.lastDeleteResourcesMediaId, 7);
      expect(workflow.lastDeleteResourceIds, <int>{1, 3});
    });
  });
}

class _SpyFavoriteFolderWorkflow extends FavoriteFolderCommandWorkflow {
  _SpyFavoriteFolderWorkflow() : super(_ThrowingFavoriteRepository());

  int createFolderCalls = 0;
  int editFolderCalls = 0;
  int deleteFolderCalls = 0;
  int deleteResourcesCalls = 0;

  String? lastCreateTitle;
  String? lastCreateIntro;
  int? lastCreatePrivacy;

  int? lastEditMediaId;
  String? lastEditTitle;
  String? lastEditIntro;
  int? lastEditPrivacy;

  int? lastDeleteMediaId;
  int? lastDeleteResourcesMediaId;
  Set<int>? lastDeleteResourceIds;

  Result<void, AppError> createFolderResult = const Success(null);
  Result<void, AppError> editFolderResult = const Success(null);
  Result<void, AppError> deleteFolderResult = const Success(null);
  Result<void, AppError> deleteResourcesResult = const Success(null);

  @override
  Future<Result<void, AppError>> createFolder({
    required String title,
    String? intro,
    int? privacy,
  }) async {
    createFolderCalls++;
    lastCreateTitle = title;
    lastCreateIntro = intro;
    lastCreatePrivacy = privacy;
    return createFolderResult;
  }

  @override
  Future<Result<void, AppError>> editFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
  }) async {
    editFolderCalls++;
    lastEditMediaId = mediaId;
    lastEditTitle = title;
    lastEditIntro = intro;
    lastEditPrivacy = privacy;
    return editFolderResult;
  }

  @override
  Future<Result<void, AppError>> deleteFolder({required int mediaId}) async {
    deleteFolderCalls++;
    lastDeleteMediaId = mediaId;
    return deleteFolderResult;
  }

  @override
  Future<Result<void, AppError>> deleteResources({
    required int mediaId,
    required Set<int> resourceIds,
  }) async {
    deleteResourcesCalls++;
    lastDeleteResourcesMediaId = mediaId;
    lastDeleteResourceIds = resourceIds;
    return deleteResourcesResult;
  }
}

class _ThrowingFavoriteRepository implements FavoriteRepository {
  @override
  Future<Result<void, AppError>> cleanInvalidResources({
    required int mediaId,
  }) async => throw UnimplementedError('repository should not be used');

  @override
  Future<Result<FavoriteFolder, AppError>> createFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async => throw UnimplementedError('repository should not be used');

  @override
  Future<Result<void, AppError>> deleteFolder({required String mediaIds}) async =>
      throw UnimplementedError('repository should not be used');

  @override
  Future<Result<void, AppError>> deleteResources({
    required String resources,
    required int mediaId,
  }) async => throw UnimplementedError('repository should not be used');

  @override
  Future<Result<FavoriteFolderPage, AppError>> getCollectedFolders(
    FavoriteFolderListQuery query,
  ) async => throw UnimplementedError('repository should not be used');

  @override
  Future<Result<FavoriteFolderPage, AppError>> getCreatedFolders({
    required int upMid,
  }) async => throw UnimplementedError('repository should not be used');

  @override
  Future<Result<FavoriteResourcePage, AppError>> getFolderResources(
    FavoriteFolderResourcesQuery query,
  ) async => throw UnimplementedError('repository should not be used');

  @override
  Future<Result<FavoriteFolder, AppError>> updateFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async => throw UnimplementedError('repository should not be used');
}
