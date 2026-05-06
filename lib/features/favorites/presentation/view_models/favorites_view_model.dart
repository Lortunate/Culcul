import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/core/pagination/paged_list_state.dart';
import 'package:culcul/shared/network/network_concurrency_executor.dart';
import 'package:culcul/shared/network/network_concurrency_profiles.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/perf/feature_flow_perf_logger.dart';
import 'package:culcul/core/utils/list_utils.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:culcul/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:culcul/features/favorites/feature_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_view_model.g.dart';
part 'favorites_view_model.collected.dart';
part 'favorites_view_model.folder_resources.dart';

@riverpod
class FavCreatedFolders extends _$FavCreatedFolders {
  static const NetworkConcurrencyExecutor _concurrencyExecutor =
      NetworkConcurrencyExecutor();

  @override
  Future<List<FavoriteFolder>> build() async {
    final authState = ref.watch(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }
    final mid = int.parse(authState.user!.id);
    final repository = ref.read(favRepositoryProvider);
    final result = await repository.getCreatedFolders(upMid: mid);
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
                FavoriteFolderResourcesQuery(mediaId: folder.id, page: 1),
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
