import 'package:culcul/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:culcul/features/favorites/feature_scope.dart';
import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final favoriteFolderCommandWorkflowProvider = Provider<FavoriteFolderCommandWorkflow>(
  (ref) => FavoriteFolderCommandWorkflow(ref.read(favRepositoryProvider)),
);

class FavoriteFolderCommandWorkflow {
  final FavoriteRepository _repository;

  const FavoriteFolderCommandWorkflow(this._repository);

  Future<Result<void, AppError>> createFolder({
    required String title,
    String? intro,
    int? privacy,
  }) async {
    final result = await _repository.createFolder(
      title: title,
      intro: intro,
      privacy: privacy,
    );
    return _toVoid(result);
  }

  Future<Result<void, AppError>> editFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
  }) async {
    final result = await _repository.updateFolder(
      mediaId: mediaId,
      title: title,
      intro: intro,
      privacy: privacy,
    );
    return _toVoid(result);
  }

  Future<Result<void, AppError>> deleteFolder({required int mediaId}) async {
    final result = await _repository.deleteFolder(mediaIds: mediaId.toString());
    return _toVoid(result);
  }

  Future<Result<void, AppError>> deleteResources({
    required int mediaId,
    required Set<int> resourceIds,
  }) async {
    final result = await _repository.deleteResources(
      resources: resourceIds.join(','),
      mediaId: mediaId,
    );
    return _toVoid(result);
  }

  Result<void, AppError> _toVoid<T>(Result<T, AppError> result) {
    final error = result.errorOrNull;
    if (error != null) {
      return Failure(error);
    }
    return const Success(null);
  }
}
