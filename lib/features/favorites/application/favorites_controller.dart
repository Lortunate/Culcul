import 'package:culcul/core/data/network/network_concurrency_executor.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/core/data/pagination/paged_list_state.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/utils/list_utils.dart';
import 'package:culcul/features/favorites/data/fav_repository_impl.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_controller.freezed.dart';
part 'favorites_controller.g.dart';
part 'favorites_controller.collected.dart';
part 'favorites_controller.folder_resources.dart';

@riverpod
class FavCreatedFolders extends _$FavCreatedFolders {
  static const NetworkConcurrencyExecutor _concurrencyExecutor =
      NetworkConcurrencyExecutor();

  @override
  Future<List<FavoriteFolder>> build(int upMid) async {
    final repository = ref.read(favRepositoryProvider);
    final result = await repository.getCreatedFolders(upMid: upMid);
    final response = result.dataOrNull;
    if (response == null) return <FavoriteFolder>[];
    final folders = response.folders;
    if (folders.isEmpty) return <FavoriteFolder>[];

    final foldersWithCovers = await _concurrencyExecutor
        .mapConcurrent<FavoriteFolder, FavoriteFolder>(
          items: folders,
          profile: NetworkConcurrencyProfile.enrich,
          scope: 'favorites_cover_enrich',
          mapper: (folder) async {
            if (folder.cover case final cover? when cover.isNotEmpty) {
              return folder;
            }

            try {
              final resourcesResult = await repository.getFolderResources(
                mediaId: folder.id,
                page: 1,
              );
              final resources = resourcesResult.dataOrNull;
              if (resources == null) {
                return folder;
              }

              var cover = resources.info.cover;
              if (cover.isEmpty && resources.medias.isNotEmpty) {
                cover = resources.medias.first.cover;
              }
              if (cover.isEmpty) {
                return folder;
              }
              return folder.copyWith(cover: cover);
            } catch (_) {
              return folder;
            }
          },
        );

    return foldersWithCovers;
  }
}

@riverpod
class FavoriteFolderCommands extends _$FavoriteFolderCommands {
  @override
  FutureOr<void> build() {}

  Future<AppError?> createFolder({
    required String title,
    String? intro,
    required int privacy,
  }) async {
    final result = await ref
        .read(favRepositoryProvider)
        .createFolder(title: title, intro: intro, privacy: privacy);
    final error = result.errorOrNull;
    return error;
  }

  Future<AppError?> updateFolder({
    required int mediaId,
    required String title,
    String? intro,
    required int privacy,
  }) async {
    final result = await ref
        .read(favRepositoryProvider)
        .updateFolder(mediaId: mediaId, title: title, intro: intro, privacy: privacy);
    final error = result.errorOrNull;
    return error;
  }

  Future<AppError?> deleteFolder({required int mediaId}) async {
    final result = await ref
        .read(favRepositoryProvider)
        .deleteFolder(mediaIds: mediaId.toString());
    final error = result.errorOrNull;
    return error;
  }

  Future<AppError?> deleteResources({
    required int mediaId,
    required Set<int> resourceIds,
  }) async {
    final result = await ref
        .read(favRepositoryProvider)
        .deleteResources(mediaId: mediaId, resources: resourceIds.join(','));
    final error = result.errorOrNull;
    if (error == null) {
      ref.invalidate(favFolderResourcesProvider(mediaId));
    }
    return error;
  }
}
