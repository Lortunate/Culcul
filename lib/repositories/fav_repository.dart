import 'package:culcul/data/api/fav_api.dart';
import 'package:culcul/data/models/fav/index.dart';

class FavRepository {
  final FavApi _api;

  FavRepository(this._api);

  Future<FavFolderListResponse> getCreatedFolders({required int upMid}) async {
    final response = await _api.getCreatedFolders(upMid);
    if (response.data == null) {
      throw Exception('Failed to load created folders: ${response.message}');
    }
    return response.data!;
  }

  Future<FavFolderListResponse> getCollectedFolders({
    required int upMid,
    required int pn,
    required int ps,
  }) async {
    final response = await _api.getCollectedFolders(upMid, pn, ps);
    if (response.data == null) {
      throw Exception('Failed to load collected folders: ${response.message}');
    }
    return response.data!;
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
    final response = await _api.getFolderResources(
      mediaId,
      pn,
      ps,
      keyword: keyword,
      order: order,
      type: type,
      tid: tid,
      platform: platform,
    );
    if (response.data == null) {
      throw Exception('Failed to load folder resources: ${response.message}');
    }
    return response.data!;
  }

  Future<FavFolderModel> addFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    final response = await _api.addFolder(
      title,
      intro: intro,
      privacy: privacy,
      cover: cover,
    );
    if (response.code != 0 || response.data == null) {
      throw Exception('Failed to add folder: ${response.message}');
    }
    return response.data!;
  }

  Future<FavFolderModel> editFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    final response = await _api.editFolder(
      mediaId,
      title,
      intro: intro,
      privacy: privacy,
      cover: cover,
    );
    if (response.code != 0 || response.data == null) {
      throw Exception('Failed to edit folder: ${response.message}');
    }
    return response.data!;
  }

  Future<void> delFolder({required String mediaIds}) async {
    final response = await _api.delFolder(mediaIds);
    if (response.code != 0) {
      throw Exception('Failed to delete folder: ${response.message}');
    }
  }

  Future<void> batchDelResource({
    required String resources,
    required int mediaId,
    String platform = 'web',
  }) async {
    final response = await _api.batchDelResource(
      resources,
      mediaId,
      platform: platform,
    );
    if (response.code != 0) {
      throw Exception('Failed to delete resources: ${response.message}');
    }
  }

  Future<void> cleanInvalidResources({required int mediaId}) async {
    final response = await _api.cleanInvalidResources(mediaId);
    if (response.code != 0) {
      throw Exception('Failed to clean invalid resources: ${response.message}');
    }
  }
}
