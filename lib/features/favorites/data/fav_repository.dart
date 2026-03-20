import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/data/api/fav_api.dart';
import 'package:culcul/data/models/fav/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fav_repository.g.dart';

@riverpod
FavRepository favRepository(Ref ref) {
  return FavRepository(ref.watch(favApiProvider));
}

class FavRepository extends BaseRepository {
  final FavApi _api;

  FavRepository(this._api);

  Future<Result<FavFolderListResponse, AppException>> getCreatedFolders({
    required int upMid,
  }) async {
    return safeApiCall(() => _api.getCreatedFolders(upMid));
  }

  Future<Result<FavFolderListResponse, AppException>> getCollectedFolders({
    required int upMid,
    required int pn,
    required int ps,
  }) async {
    return safeApiCall(() => _api.getCollectedFolders(upMid, pn, ps));
  }

  Future<Result<FavResourceListResponse, AppException>> getFolderResources({
    required int mediaId,
    required int pn,
    required int ps,
    String? keyword,
    String? order,
    int? type,
    int? tid,
    String platform = 'web',
  }) async {
    return safeApiCall(
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

  Future<Result<FavFolderModel, AppException>> addFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return safeApiCall(
      () => _api.addFolder(
        title,
        intro: intro,
        privacy: privacy,
        cover: cover,
      ),
    );
  }

  Future<Result<FavFolderModel, AppException>> editFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return safeApiCall(
      () => _api.editFolder(
        mediaId,
        title,
        intro: intro,
        privacy: privacy,
        cover: cover,
      ),
    );
  }

  Future<Result<void, AppException>> delFolder({required String mediaIds}) async {
    return safeVoidApiCall(() => _api.delFolder(mediaIds));
  }

  Future<Result<void, AppException>> batchDelResource({
    required String resources,
    required int mediaId,
    String platform = 'web',
  }) async {
    return safeVoidApiCall(
      () => _api.batchDelResource(
        resources,
        mediaId,
        platform: platform,
      ),
    );
  }

  Future<Result<void, AppException>> cleanInvalidResources({
    required int mediaId,
  }) async {
    return safeVoidApiCall(() => _api.cleanInvalidResources(mediaId));
  }
}
