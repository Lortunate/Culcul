import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/dynamic/dynamic_providers.dart';
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
  }) async {
    return runVoidResult(() async {
      final uploadedImages = <DynamicUploadImageData>[];
      for (final image in images) {
        uploadedImages.add(await _repository.uploadImage(image));
      }
      await _repository.publishDynamic(content: content, images: uploadedImages);
    });
  }
}
