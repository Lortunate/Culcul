import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';

abstract class FavoriteRepository {
  Future<FavoriteFolderPage> getCreatedFolders({required int upMid});

  Future<FavoriteFolderPage> getCollectedFolders({
    required int upMid,
    required int page,
    required int pageSize,
  });

  Future<FavoriteResourcePage> getFolderResources({
    required int mediaId,
    required int page,
    required int pageSize,
    String? keyword,
    String? order,
    int? type,
    int? tid,
    String platform = 'web',
  });

  Future<FavoriteFolder> createFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  });

  Future<FavoriteFolder> updateFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  });

  Future<void> deleteFolder({required String mediaIds});

  Future<void> deleteResources({
    required String resources,
    required int mediaId,
    String platform = 'web',
  });

  Future<void> cleanInvalidResources({required int mediaId});
}
