import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/features/favorites/application/use_case/favorite_folder_use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_folder_action_view_model.g.dart';

@riverpod
class FavoriteFolderActionViewModel extends _$FavoriteFolderActionViewModel {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<AppError?> createFolder({
    required String title,
    String? intro,
    int? privacy,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(favoriteFolderMutationsUseCaseProvider)
        .createFolder(
          CreateFavoriteFolderCommand(title: title, intro: intro, privacy: privacy),
        );
    state = const AsyncData(null);
    return result.errorOrNull;
  }

  Future<AppError?> editFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(favoriteFolderMutationsUseCaseProvider)
        .editFolder(
          EditFavoriteFolderCommand(
            mediaId: mediaId,
            title: title,
            intro: intro,
            privacy: privacy,
          ),
        );
    state = const AsyncData(null);
    return result.errorOrNull;
  }

  Future<AppError?> deleteFolder({required int mediaId}) async {
    state = const AsyncLoading();
    final result = await ref
        .read(favoriteFolderMutationsUseCaseProvider)
        .deleteFolder(DeleteFavoriteFolderCommand(mediaId: mediaId));
    state = const AsyncData(null);
    return result.errorOrNull;
  }

  Future<AppError?> deleteResources({
    required int mediaId,
    required Set<int> resourceIds,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(favoriteFolderMutationsUseCaseProvider)
        .deleteResources(
          DeleteFavoriteResourcesCommand(mediaId: mediaId, resourceIds: resourceIds),
        );
    state = const AsyncData(null);
    return result.errorOrNull;
  }
}
