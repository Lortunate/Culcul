import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';

class FavoriteFolderListQuery {
  final int upMid;
  final int page;

  const FavoriteFolderListQuery({required this.upMid, required this.page});
}

class FavoriteFolderResourcesQuery {
  final int mediaId;
  final int page;
  final String? keyword;
  final String? order;
  final int? type;
  final int? tid;

  const FavoriteFolderResourcesQuery({
    required this.mediaId,
    required this.page,
    this.keyword,
    this.order,
    this.type,
    this.tid,
  });
}

abstract class FavoriteRepository {
  Future<Result<FavoriteFolderPage, AppError>> getCreatedFolders({required int upMid});

  Future<Result<FavoriteFolderPage, AppError>> getCollectedFolders(
    FavoriteFolderListQuery query,
  );

  Future<Result<FavoriteResourcePage, AppError>> getFolderResources(
    FavoriteFolderResourcesQuery query,
  );

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

  Future<Result<void, AppError>> cleanInvalidResources({required int mediaId});
}
