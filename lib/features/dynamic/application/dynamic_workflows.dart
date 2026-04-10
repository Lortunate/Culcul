import 'dart:io';

import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:culcul/features/dynamic/dynamic.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/features/dynamic/domain/repositories/dynamic_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_workflows.g.dart';

@riverpod
PublishDynamicWorkflow publishDynamicWorkflow(Ref ref) {
  return PublishDynamicWorkflow(ref.read(dynamicRepositoryProvider));
}

class PublishDynamicWorkflow {
  final DynamicRepository _repository;

  const PublishDynamicWorkflow(this._repository);

  Future<Result<void, AppError>> call({
    required String content,
    required List<File> images,
    String? csrf,
  }) async {
    final resolvedCsrf = await _resolveCsrf(csrf);
    if (resolvedCsrf.errorOrNull case final error?) {
      return Failure(error);
    }
    final csrfToken = resolvedCsrf.dataOrNull!;

    final uploadedImagesResult = await _repository.uploadImagesWithCsrf(
      files: images,
      csrf: csrfToken,
    );
    if (uploadedImagesResult.errorOrNull case final error?) {
      return Failure(error);
    }

    return _repository.publishDynamic(
      content: content,
      csrf: csrfToken,
      images: uploadedImagesResult.dataOrNull ?? const <DynamicUploadImageData>[],
    );
  }

  Future<Result<String, AppError>> _resolveCsrf(String? injectedCsrf) async {
    if (injectedCsrf != null && injectedCsrf.isNotEmpty) {
      return Success(injectedCsrf);
    }
    final csrfResult = await _repository.getPublishCsrf();
    final csrf = csrfResult.dataOrNull;
    if (csrf == null || csrf.isEmpty) {
      return Failure(csrfResult.errorOrNull ?? AppError.auth('Missing csrf token'));
    }
    return Success(csrf);
  }
}
