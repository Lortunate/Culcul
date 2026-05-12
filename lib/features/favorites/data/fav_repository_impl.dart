import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/data/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/favorites/data/fav_api.dart';
import 'package:culcul/features/favorites/data/dtos/fav_folder_model.dart';
import 'package:culcul/features/favorites/data/dtos/fav_resource_model.dart';
import 'package:culcul/features/favorites/data/favorite_mapper.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_queries.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fav_repository_impl.g.dart';

@riverpod
FavRepositoryImpl favRepository(Ref ref) {
  return FavRepositoryImpl(FavApi(ref.watch(dioClientProvider)));
}

class FavRepositoryImpl with RequestExecutorBinding {
  static const int _defaultPageSize = 20;
  final FavApi _api;
  final RequestExecutor _requestExecutor;

  FavRepositoryImpl(this._api, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  Future<Result<FavFolderListResponse, AppError>> getCreatedFoldersModel({
    required int upMid,
  }) async {
    return requestApiResult(() => _api.getCreatedFolders(upMid));
  }

  Future<Result<FavFolderListResponse, AppError>> getCollectedFoldersModel({
    required int upMid,
    required int pn,
    int ps = _defaultPageSize,
  }) async {
    return requestApiResult(() => _api.getCollectedFolders(upMid, pn, ps));
  }

  Future<Result<FavResourceListResponse, AppError>> getFolderResourcesModel({
    required int mediaId,
    required int pn,
    int ps = _defaultPageSize,
    String? keyword,
    String? order,
    int? type,
    int? tid,
  }) async {
    return requestApiResult(
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

  Future<Result<FavFolderModel, AppError>> addFolderModel({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return requestApiResult(
      () => _api.addFolder(title, intro: intro, privacy: privacy, cover: cover),
    );
  }

  Future<Result<FavFolderModel, AppError>> editFolderModel({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return requestApiResult(
      () => _api.editFolder(mediaId, title, intro: intro, privacy: privacy, cover: cover),
    );
  }

  Future<Result<void, AppError>> delFolder({required String mediaIds}) async {
    return requestVoidResult(() => _api.delFolder(mediaIds));
  }

  Future<Result<void, AppError>> batchDelResource({
    required String resources,
    required int mediaId,
  }) async {
    return requestVoidResult(
      () => _api.batchDelResource(resources, mediaId, platform: 'web'),
    );
  }

  Future<Result<void, AppError>> cleanInvalidResources({required int mediaId}) async {
    return requestVoidResult(() => _api.cleanInvalidResources(mediaId));
  }

  Future<Result<FavoriteFolderPage, AppError>> getCreatedFolders({
    required int upMid,
  }) async {
    final result = await getCreatedFoldersModel(upMid: upMid);
    return result.map((data) => data.toDomain());
  }

  Future<Result<FavoriteFolderPage, AppError>> getCollectedFolders(
    FavoriteFolderListQuery query,
  ) async {
    final result = await getCollectedFoldersModel(upMid: query.upMid, pn: query.page);
    return result.map((data) => data.toDomain());
  }

  Future<Result<FavoriteResourcePage, AppError>> getFolderResources(
    FavoriteFolderResourcesQuery query,
  ) async {
    final result = await getFolderResourcesModel(
      mediaId: query.mediaId,
      pn: query.page,
      keyword: query.keyword,
      order: query.order,
      type: query.type,
      tid: query.tid,
    );
    return result.map((data) => data.toDomain());
  }

  Future<Result<FavoriteFolder, AppError>> createFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    final result = await addFolderModel(
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
    final result = await editFolderModel(
      mediaId: mediaId,
      title: title,
      intro: intro,
      privacy: privacy,
      cover: cover,
    );
    return result.map((data) => data.toDomain());
  }

  Future<Result<void, AppError>> deleteFolder({required String mediaIds}) {
    return delFolder(mediaIds: mediaIds);
  }

  Future<Result<void, AppError>> deleteResources({
    required String resources,
    required int mediaId,
  }) {
    return batchDelResource(resources: resources, mediaId: mediaId);
  }
}
