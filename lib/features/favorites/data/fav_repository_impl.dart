import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/favorites/data/fav_api.dart';
import 'package:culcul/features/favorites/data/dtos/favorite_dtos.dart';
import 'package:culcul/features/favorites/data/favorite_mapper.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:culcul/features/favorites/domain/repositories/favorite_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fav_repository_impl.g.dart';

@riverpod
domain.FavoriteRepository favRepository(Ref ref) {
  return FavRepositoryImpl(FavApi(ref.watch(dioClientProvider)));
}

class FavRepositoryImpl extends BaseRepository implements domain.FavoriteRepository {
  static const int _defaultPageSize = 20;
  final FavApi _api;

  FavRepositoryImpl(this._api);

  Future<FavFolderListResponse> getCreatedFoldersModel({required int upMid}) async {
    return requestApi(() => _api.getCreatedFolders(upMid));
  }

  Future<FavFolderListResponse> getCollectedFoldersModel({
    required int upMid,
    required int pn,
    int ps = _defaultPageSize,
  }) async {
    return requestApi(() => _api.getCollectedFolders(upMid, pn, ps));
  }

  Future<FavResourceListResponse> getFolderResourcesModel({
    required int mediaId,
    required int pn,
    int ps = _defaultPageSize,
    String? keyword,
    String? order,
    int? type,
    int? tid,
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
        platform: 'web',
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

  Future<void> batchDelResource({required String resources, required int mediaId}) async {
    return requestVoid(() => _api.batchDelResource(resources, mediaId, platform: 'web'));
  }

  @override
  Future<Result<void, AppError>> cleanInvalidResources({required int mediaId}) async {
    return runVoidResult(() => requestVoid(() => _api.cleanInvalidResources(mediaId)));
  }

  @override
  Future<FavoriteFolderPage> getCreatedFolders({required int upMid}) async {
    return (await getCreatedFoldersModel(upMid: upMid)).toDomain();
  }

  @override
  Future<FavoriteFolderPage> getCollectedFolders({
    required int upMid,
    required int page,
  }) async {
    return (await getCollectedFoldersModel(upMid: upMid, pn: page)).toDomain();
  }

  @override
  Future<FavoriteResourcePage> getFolderResources({
    required int mediaId,
    required int page,
    String? keyword,
    String? order,
    int? type,
    int? tid,
  }) async {
    return (await getFolderResourcesModel(
      mediaId: mediaId,
      pn: page,
      keyword: keyword,
      order: order,
      type: type,
      tid: tid,
    )).toDomain();
  }

  @override
  Future<Result<FavoriteFolder, AppError>> createFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return runResult(() async {
      return (await addFolderModel(
        title: title,
        intro: intro,
        privacy: privacy,
        cover: cover,
      )).toDomain();
    });
  }

  @override
  Future<Result<FavoriteFolder, AppError>> updateFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return runResult(() async {
      return (await editFolderModel(
        mediaId: mediaId,
        title: title,
        intro: intro,
        privacy: privacy,
        cover: cover,
      )).toDomain();
    });
  }

  @override
  Future<Result<void, AppError>> deleteFolder({required String mediaIds}) {
    return runVoidResult(() => delFolder(mediaIds: mediaIds));
  }

  @override
  Future<Result<void, AppError>> deleteResources({
    required String resources,
    required int mediaId,
  }) {
    return runVoidResult(() => batchDelResource(resources: resources, mediaId: mediaId));
  }
}
