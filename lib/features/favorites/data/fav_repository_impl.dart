import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/favorites/data/fav_api.dart';
import 'package:culcul/features/favorites/data/dtos/fav_folder_model.dart';
import 'package:culcul/features/favorites/data/dtos/fav_resource_model.dart';
import 'package:culcul/features/favorites/data/favorite_mapper.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fav_repository_impl.g.dart';

@riverpod
FavRepositoryImpl favRepository(Ref ref) {
  return FavRepositoryImpl(FavApi(ref.watch(dioClientProvider)));
}

class FavRepositoryImpl {
  static const int _favoritePageSize = 20;
  final FavApi _api;
  final RequestExecutor _requestExecutor;

  FavRepositoryImpl(this._api, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  Future<Result<FavFolderListResponse, AppError>> _getCreatedFoldersModel({
    required int upMid,
    int? rid,
    int? type,
  }) {
    return _requestExecutor.runApiDirect(
      () => _api.getCreatedFolders(upMid, rid: rid, type: type),
    );
  }

  Future<Result<FavFolderListResponse, AppError>> _getCollectedFoldersModel({
    required int upMid,
    required int pn,
    int ps = _favoritePageSize,
  }) {
    return _requestExecutor.runApiDirect(() => _api.getCollectedFolders(upMid, pn, ps));
  }

  Future<Result<FavResourceListResponse, AppError>> _getFolderResourcesModel({
    required int mediaId,
    required int pn,
    int ps = _favoritePageSize,
    String? keyword,
    String? order,
    int? type,
    int? tid,
  }) {
    return _requestExecutor.runApiDirect(
      () => _api.getFolderResources(
        mediaId,
        pn,
        ps,
        keyword: keyword,
        order: order,
        type: type,
        tid: tid,
      ),
    );
  }

  Future<Result<FavFolderModel, AppError>> _addFolderModel({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) {
    return _requestExecutor.runApiDirect(
      () => _api.addFolder(title, intro: intro, privacy: privacy, cover: cover),
    );
  }

  Future<Result<FavFolderModel, AppError>> _editFolderModel({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) {
    return _requestExecutor.runApiDirect(
      () => _api.editFolder(mediaId, title, intro: intro, privacy: privacy, cover: cover),
    );
  }

  Future<Result<FavoriteFolderPage, AppError>> getCreatedFolders({
    required int upMid,
    int? rid,
    int? type,
  }) async {
    final result = await _getCreatedFoldersModel(upMid: upMid, rid: rid, type: type);
    return result.map((data) => data.toDomain());
  }

  Future<Result<FavoriteFolderPage, AppError>> getCollectedFolders({
    required int upMid,
    required int page,
  }) async {
    final result = await _getCollectedFoldersModel(upMid: upMid, pn: page);
    return result.map((data) => data.toDomain());
  }

  Future<Result<FavoriteResourcePage, AppError>> getFolderResources({
    required int mediaId,
    required int page,
    String? keyword,
    String? order,
    int? type,
    int? tid,
  }) async {
    final result = await _getFolderResourcesModel(
      mediaId: mediaId,
      pn: page,
      keyword: keyword,
      order: order,
      type: type,
      tid: tid,
    );
    return result.map((data) => data.toDomain());
  }

  Future<Result<FavoriteFolder, AppError>> createFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    final result = await _addFolderModel(
      title: title,
      intro: intro,
      privacy: privacy,
      cover: cover,
    );
    return result.map((data) => data.toDomain());
  }

  Future<Result<FavoriteFolder, AppError>> updateFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    final result = await _editFolderModel(
      mediaId: mediaId,
      title: title,
      intro: intro,
      privacy: privacy,
      cover: cover,
    );
    return result.map((data) => data.toDomain());
  }

  Future<Result<void, AppError>> deleteFolder({required String mediaIds}) {
    return _requestExecutor.runUnit(() => _api.delFolder(mediaIds));
  }

  Future<Result<void, AppError>> deleteResources({
    required String resources,
    required int mediaId,
  }) {
    return _requestExecutor.runUnit(() => _api.batchDelResource(resources, mediaId));
  }

  Future<Result<void, AppError>> dealVideoFavorite({
    required int aid,
    required Iterable<int> addMediaIds,
    required Iterable<int> delMediaIds,
  }) {
    final addIds = _joinMediaIds(addMediaIds);
    final delIds = _joinMediaIds(delMediaIds);
    if (addIds == null && delIds == null) {
      return Future.value(const Success(null));
    }

    return _requestExecutor.runUnit(
      () => _api.dealResource(aid, 2, addMediaIds: addIds, delMediaIds: delIds),
    );
  }

  String? _joinMediaIds(Iterable<int> ids) {
    final normalized = ids.where((id) => id > 0).toSet().toList()..sort();
    if (normalized.isEmpty) {
      return null;
    }
    return normalized.join(',');
  }
}
