import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_publish_command.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_workflows.g.dart';

@riverpod
PublishDynamicWorkflow publishDynamicWorkflow(Ref ref) {
  return PublishDynamicWorkflow(ref.read(dynamicRepositoryProvider));
}

class PublishDynamicWorkflow {
  final DynamicRepositoryImpl _repository;

  const PublishDynamicWorkflow(this._repository);

  Future<Result<void, AppError>> call({
    required String content,
    required List<PublishMediaAsset> images,
    String? csrf,
  }) async {
    return (await _resolveCsrf(csrf)).when(
      success: (csrfToken) async {
        final uploadedImagesResult = await _repository.uploadImagesWithCsrf(
          files: images,
          csrf: csrfToken,
        );
        return uploadedImagesResult.when(
          success: (images) => _repository.publishDynamic(
            content: content,
            csrf: csrfToken,
            images: images,
          ),
          failure: (error) async => Failure(error),
        );
      },
      failure: (error) async => Failure(error),
    );
  }

  Future<Result<String, AppError>> _resolveCsrf(String? injectedCsrf) async {
    if (injectedCsrf != null && injectedCsrf.isNotEmpty) {
      return Success(injectedCsrf);
    }
    final csrfResult = await _repository.getPublishCsrf();
    final csrf = csrfResult.dataOrNull;
    if (csrf == null || csrf.isEmpty) {
      return Failure(csrfResult.errorOrNull ?? const AppError.auth('Missing csrf token'));
    }
    return Success(csrf);
  }
}
