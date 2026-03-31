import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/features/favorites/favorites_providers.dart';
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
    try {
      await ref.read(favRepositoryProvider).createFolder(
        title: title,
        intro: intro,
        privacy: privacy,
      );
      state = const AsyncData(null);
      return null;
    } catch (error) {
      final appError = AppError.fromObject(error);
      state = const AsyncData(null);
      return appError;
    }
  }

  Future<AppError?> editFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
  }) async {
    state = const AsyncLoading();
    try {
      await ref.read(favRepositoryProvider).updateFolder(
        mediaId: mediaId,
        title: title,
        intro: intro,
        privacy: privacy,
      );
      state = const AsyncData(null);
      return null;
    } catch (error) {
      final appError = AppError.fromObject(error);
      state = const AsyncData(null);
      return appError;
    }
  }

  Future<AppError?> deleteFolder({required int mediaId}) async {
    state = const AsyncLoading();
    try {
      await ref.read(favRepositoryProvider).deleteFolder(mediaIds: mediaId.toString());
      state = const AsyncData(null);
      return null;
    } catch (error) {
      final appError = AppError.fromObject(error);
      state = const AsyncData(null);
      return appError;
    }
  }

  Future<AppError?> deleteResources({
    required int mediaId,
    required Set<int> resourceIds,
  }) async {
    state = const AsyncLoading();
    try {
      await ref.read(favRepositoryProvider).deleteResources(
        resources: resourceIds.join(','),
        mediaId: mediaId,
      );
      state = const AsyncData(null);
      return null;
    } catch (error) {
      final appError = AppError.fromObject(error);
      state = const AsyncData(null);
      return appError;
    }
  }
}
