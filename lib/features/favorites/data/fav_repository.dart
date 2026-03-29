import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
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

  Future<FavFolderListResponse> getCreatedFolders({
    required int upMid,
  }) async {
    return requestApi(() => _api.getCreatedFolders(upMid));
  }

  Future<FavFolderListResponse> getCollectedFolders({
    required int upMid,
    required int pn,
    required int ps,
  }) async {
    return requestApi(() => _api.getCollectedFolders(upMid, pn, ps));
  }

  Future<FavResourceListResponse> getFolderResources({
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

  Future<FavFolderModel> addFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return requestApi(
      () => _api.addFolder(title, intro: intro, privacy: privacy, cover: cover),
    );
  }

  Future<FavFolderModel> editFolder({
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

  Future<void> cleanInvalidResources({required int mediaId}) async {
    return requestVoid(() => _api.cleanInvalidResources(mediaId));
  }
}

