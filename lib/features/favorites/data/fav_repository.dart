import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/features/favorites/data/fav_api.dart';
import 'package:culcul/features/favorites/data/mappers/favorite_mapper.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:culcul/features/favorites/domain/repositories/favorite_repository.dart'
    as domain;
import 'package:culcul/features/favorites/models/favorite_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fav_repository.g.dart';

@riverpod
domain.FavoriteRepository favRepository(Ref ref) {
  return FavRepositoryImpl(ref.watch(favApiProvider));
}

class FavRepositoryImpl extends BaseRepository implements domain.FavoriteRepository {
  final FavApi _api;

  FavRepositoryImpl(this._api);

  Future<FavFolderListResponse> getCreatedFoldersModel({required int upMid}) async {
    return requestApi(() => _api.getCreatedFolders(upMid));
  }

  Future<FavFolderListResponse> getCollectedFoldersModel({
    required int upMid,
    required int pn,
    required int ps,
  }) async {
    return requestApi(() => _api.getCollectedFolders(upMid, pn, ps));
  }

  Future<FavResourceListResponse> getFolderResourcesModel({
    required int mediaId,
    required int pn,
    required int ps,
    String? keyword,
    String? order,
    int? type,
    int? tid,
    String platform = 'web',
  }) async {
    return requestApi(
      () => _api.getFolderResources(
        mediaId,
        pn,
        ps,
        keyword: keyword,
        order: order,
        type: type,
        tid: tid,
        platform: platform,
      ),
    );
  }

  Future<FavFolderModel> addFolderModel({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return requestApi(
      () => _api.addFolder(title, intro: intro, privacy: privacy, cover: cover),
    );
  }

  Future<FavFolderModel> editFolderModel({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return requestApi(
      () => _api.editFolder(mediaId, title, intro: intro, privacy: privacy, cover: cover),
    );
  }

  Future<void> delFolder({required String mediaIds}) async {
    return requestVoid(() => _api.delFolder(mediaIds));
  }

  Future<void> batchDelResource({
    required String resources,
    required int mediaId,
    String platform = 'web',
  }) async {
    return requestVoid(
      () => _api.batchDelResource(resources, mediaId, platform: platform),
    );
  }

  @override
  Future<void> cleanInvalidResources({required int mediaId}) async {
    return requestVoid(() => _api.cleanInvalidResources(mediaId));
  }

  @override
  Future<FavoriteFolderPage> getCreatedFolders({required int upMid}) async {
    return (await getCreatedFoldersModel(upMid: upMid)).toDomain();
  }

  @override
  Future<FavoriteFolderPage> getCollectedFolders({
    required int upMid,
    required int page,
    required int pageSize,
  }) async {
    return (await getCollectedFoldersModel(
      upMid: upMid,
      pn: page,
      ps: pageSize,
    )).toDomain();
  }

  @override
  Future<FavoriteResourcePage> getFolderResources({
    required int mediaId,
    required int page,
    required int pageSize,
    String? keyword,
    String? order,
    int? type,
    int? tid,
    String platform = 'web',
  }) async {
    return (await getFolderResourcesModel(
      mediaId: mediaId,
      pn: page,
      ps: pageSize,
      keyword: keyword,
      order: order,
      type: type,
      tid: tid,
      platform: platform,
    )).toDomain();
  }

  @override
  Future<FavoriteFolder> createFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return (await addFolderModel(
      title: title,
      intro: intro,
      privacy: privacy,
      cover: cover,
    )).toDomain();
  }

  @override
  Future<FavoriteFolder> updateFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return (await editFolderModel(
      mediaId: mediaId,
      title: title,
      intro: intro,
      privacy: privacy,
      cover: cover,
    )).toDomain();
  }

  @override
  Future<void> deleteFolder({required String mediaIds}) => delFolder(mediaIds: mediaIds);

  @override
  Future<void> deleteResources({
    required String resources,
    required int mediaId,
    String platform = 'web',
  }) {
    return batchDelResource(resources: resources, mediaId: mediaId, platform: platform);
  }
}
