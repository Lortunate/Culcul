import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';

/// Favorites application boundary.
abstract interface class FavoritesPort {
  Future<Result<FavoriteFolderPage, AppError>> getCreatedFolders({
    required int upMid,
    int? rid,
    int? type,
  });

  Future<Result<FavoriteFolderPage, AppError>> getCollectedFolders({
    required int upMid,
    required int page,
  });

  Future<Result<FavoriteResourcePage, AppError>> getFolderResources({
    required int mediaId,
    required int page,
    String? keyword,
    String? order,
    int? type,
    int? tid,
  });

  Future<Result<FavoriteFolder, AppError>> createFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  });

  Future<Result<FavoriteFolder, AppError>> updateFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  });

  Future<Result<void, AppError>> deleteFolder({required String mediaIds});

  Future<Result<void, AppError>> deleteResources({
    required String resources,
    required int mediaId,
  });

  Future<Result<void, AppError>> dealVideoFavorite({
    required int aid,
    required Iterable<int> addMediaIds,
    required Iterable<int> delMediaIds,
  });
}
