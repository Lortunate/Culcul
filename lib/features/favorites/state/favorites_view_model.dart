import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/core/data/pagination/paged_list_state.dart';
import 'package:culcul/core/data/pagination/page_merge.dart';
import 'package:culcul/core/data/network/network_concurrency_executor.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/favorites/application/favorites_application_providers.dart';
import 'package:culcul/features/favorites/application/favorites_port.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_view_model.freezed.dart';
part 'favorites_view_model.g.dart';
part 'favorites_view_model.collected.dart';
part 'favorites_view_model.folder_resources.dart';

@riverpod
class FavCreatedFolders extends _$FavCreatedFolders {
  static const NetworkConcurrencyExecutor _concurrencyExecutor =
      NetworkConcurrencyExecutor();

  @override
  Future<List<FavoriteFolder>> build() async {
    final session = ref.watch(currentUserProvider);
    if (session == null || !session.isLoggedIn) {
      return [];
    }
    final mid = int.parse(session.uid);
    final favoritesPort = ref.read(favoritesPortProvider);
    final result = await favoritesPort.getCreatedFolders(upMid: mid);
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
              final resourcesResult = await favoritesPort.getFolderResources(
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
bool videoFavoriteUserLoggedIn(Ref ref) {
  final session = ref.watch(currentUserProvider);
  return session != null && session.isLoggedIn;
}

@riverpod
Future<List<FavoriteFolder>> videoFavoriteFolders(Ref ref, int aid) async {
  final session = ref.watch(currentUserProvider);
  final mid = int.tryParse(session?.uid ?? '');
  if (session == null || !session.isLoggedIn || mid == null) {
    return const <FavoriteFolder>[];
  }

  final result = await ref
      .read(favoritesPortProvider)
      .getCreatedFolders(upMid: mid, rid: aid, type: 2);

  return result.when(success: (page) => page.folders, failure: (error) => throw error);
}

@riverpod
FavoritesPort videoFavoriteCommands(Ref ref) {
  return ref.watch(favoritesPortProvider);
}
