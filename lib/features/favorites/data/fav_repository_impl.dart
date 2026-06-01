import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/utils/json_utils.dart';
import 'package:culcul/features/favorites/data/fav_api.dart';
import 'package:culcul/features/favorites/data/favorite_paging_constants.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fav_repository_impl.g.dart';

@riverpod
FavRepositoryImpl favRepository(Ref ref) {
  return FavRepositoryImpl(FavApi(ref.watch(dioClientProvider)));
}

class FavRepositoryImpl {
  final FavApi _api;
  final RequestExecutor _requestExecutor;

  FavRepositoryImpl(
    this._api, {
    RequestExecutor requestExecutor = const RequestExecutor(),
  }) : _requestExecutor = requestExecutor;

  Future<Result<List<FavoriteFolder>, AppError>> getCreatedFolders({
    required int upMid,
    int? rid,
    int? type,
  }) async {
    return _requestExecutor.runApi<List<FavoriteFolder>, Object>(
      () => _api.getCreatedFolders(upMid, rid: rid, type: type),
      transform: _parseFavoriteFolders,
    );
  }

  Future<Result<List<FavoriteFolder>, AppError>> getCollectedFolders({
    required int upMid,
    required int page,
  }) async {
    return _requestExecutor.runApi<List<FavoriteFolder>, Object>(
      () => _api.getCollectedFolders(upMid, page, favoriteFolderPageSize),
      transform: _parseFavoriteFolders,
    );
  }

  Future<Result<FavoriteResourcePage, AppError>> getFolderResources({
    required int mediaId,
    required int page,
    String? keyword,
    String? order,
    int? type,
    int? tid,
  }) async {
    return _requestExecutor.runApi<FavoriteResourcePage, Object>(
      () => _api.getFolderResources(
        mediaId,
        page,
        favoriteResourcePageSize,
        keyword: keyword,
        order: order,
        type: type,
        tid: tid,
      ),
      transform: (data) {
        final map = JsonUtils.asStringKeyedMap(data);
        if (map == null) {
          throw const FormatException('Invalid favorite resource response');
        }

        final infoJson = JsonUtils.asStringKeyedMap(map['info']);
        if (infoJson == null) {
          throw const FormatException('Invalid favorite resource folder info');
        }

        final rawMedias = map['medias'];
        final List<Object?> medias;
        if (rawMedias == null) {
          medias = const [];
        } else if (rawMedias is List) {
          medias = rawMedias.cast<Object?>();
        } else {
          throw const FormatException('Invalid favorite resource media list');
        }

        final hasMore = map['has_more'];
        if (hasMore is! bool) {
          throw const FormatException('Invalid favorite resource has_more flag');
        }

        final info = FavoriteFolder.fromJson(infoJson);
        if (info.cover == null || info.upper == null) {
          throw const FormatException('Invalid favorite resource folder info');
        }

        return FavoriteResourcePage(
          info: info,
          medias: medias.map((item) {
            final itemJson = JsonUtils.asStringKeyedMap(item);
            if (itemJson == null) {
              throw const FormatException('Invalid favorite resource item');
            }
            return FavoriteResource.fromJson(itemJson);
          }).toList(),
          hasMore: hasMore,
        );
      },
    );
  }

  Future<Result<FavoriteFolder, AppError>> createFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    final result = await _requestExecutor.runApiDirect(
      () => _api.addFolder(title, intro: intro, privacy: privacy, cover: cover),
    );
    return result;
  }

  Future<Result<FavoriteFolder, AppError>> updateFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    final result = await _requestExecutor.runApiDirect(
      () => _api.editFolder(mediaId, title, intro: intro, privacy: privacy, cover: cover),
    );
    return result;
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

List<FavoriteFolder> _parseFavoriteFolders(Object data) {
  final map = JsonUtils.asStringKeyedMap(data);
  if (map == null) {
    throw const FormatException('Invalid favorite folder response');
  }

  final rawList = map['list'];
  if (rawList == null) {
    return const <FavoriteFolder>[];
  }
  if (rawList is! List) {
    throw const FormatException('Invalid favorite folder list');
  }

  return rawList.map((item) {
    final itemJson = JsonUtils.asStringKeyedMap(item);
    if (itemJson == null) {
      throw const FormatException('Invalid favorite folder item');
    }
    return FavoriteFolder.fromJson(itemJson);
  }).toList();
}
