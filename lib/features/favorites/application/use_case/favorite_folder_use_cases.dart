import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/data/models/fav/index.dart';
import 'package:culcul/features/favorites/data/fav_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_folder_use_cases.g.dart';

class CreateFavoriteFolderCommand {
  final String title;
  final String? intro;
  final int? privacy;

  const CreateFavoriteFolderCommand({required this.title, this.intro, this.privacy});
}

class EditFavoriteFolderCommand {
  final int mediaId;
  final String title;
  final String? intro;
  final int? privacy;

  const EditFavoriteFolderCommand({
    required this.mediaId,
    required this.title,
    this.intro,
    this.privacy,
  });
}

class DeleteFavoriteFolderCommand {
  final int mediaId;

  const DeleteFavoriteFolderCommand({required this.mediaId});
}

class DeleteFavoriteResourcesCommand {
  final int mediaId;
  final Set<int> resourceIds;

  const DeleteFavoriteResourcesCommand({
    required this.mediaId,
    required this.resourceIds,
  });
}

@riverpod
FavoriteFolderMutationsUseCase favoriteFolderMutationsUseCase(Ref ref) {
  return FavoriteFolderMutationsUseCase(ref.read(favRepositoryProvider));
}

@riverpod
FavoriteFolderQueryUseCase favoriteFolderQueryUseCase(Ref ref) {
  return FavoriteFolderQueryUseCase(ref.read(favRepositoryProvider));
}

class FavoriteFolderQueryUseCase {
  final FavRepository _repository;

  const FavoriteFolderQueryUseCase(this._repository);

  Future<Result<FavFolderListResponse, AppError>> getCreatedFolders(int upMid) async {
    try {
      return Success(await _repository.getCreatedFolders(upMid: upMid));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<FavFolderListResponse, AppError>> getCollectedFolders({
    required int upMid,
    required int page,
    required int pageSize,
  }) async {
    try {
      return Success(
        await _repository.getCollectedFolders(upMid: upMid, pn: page, ps: pageSize),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<FavResourceListResponse, AppError>> getFolderResources({
    required int mediaId,
    required int page,
    required int pageSize,
  }) async {
    try {
      return Success(
        await _repository.getFolderResources(mediaId: mediaId, pn: page, ps: pageSize),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

class FavoriteFolderMutationsUseCase {
  final FavRepository _repository;

  const FavoriteFolderMutationsUseCase(this._repository);

  Future<Result<FavFolderModel, AppError>> createFolder(
    CreateFavoriteFolderCommand command,
  ) async {
    try {
      final folder = await _repository.addFolder(
        title: command.title,
        intro: command.intro,
        privacy: command.privacy,
      );
      return Success(folder);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<FavFolderModel, AppError>> editFolder(
    EditFavoriteFolderCommand command,
  ) async {
    try {
      final folder = await _repository.editFolder(
        mediaId: command.mediaId,
        title: command.title,
        intro: command.intro,
        privacy: command.privacy,
      );
      return Success(folder);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<void, AppError>> deleteFolder(DeleteFavoriteFolderCommand command) async {
    try {
      await _repository.delFolder(mediaIds: command.mediaId.toString());
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<void, AppError>> deleteResources(
    DeleteFavoriteResourcesCommand command,
  ) async {
    try {
      await _repository.batchDelResource(
        resources: command.resourceIds.join(','),
        mediaId: command.mediaId,
      );
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
