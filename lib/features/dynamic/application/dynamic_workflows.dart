import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/dynamic/dynamic_providers.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/features/dynamic/domain/repositories/dynamic_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_workflows.g.dart';

class DynamicFeedQuery {
  final String? type;
  final String? offset;
  final int? hostMid;
  final int? topicId;

  const DynamicFeedQuery({this.type, this.offset, this.hostMid, this.topicId});
}

@riverpod
DynamicFeedWorkflow dynamicFeedWorkflow(Ref ref) {
  return DynamicFeedWorkflow(ref.read(dynamicRepositoryProvider));
}

class DynamicFeedWorkflow {
  final DynamicRepository _repository;

  const DynamicFeedWorkflow(this._repository);

  Future<Result<DynamicData, AppError>> call(DynamicFeedQuery query) async {
    return runResult(() async {
      if (query.topicId != null) {
        return _repository.getTopicFeed(topicId: query.topicId!, offset: query.offset);
      }
      if (query.hostMid != null) {
        return _repository.getSpaceDynamicFeed(
          hostMid: query.hostMid!,
          offset: query.offset,
        );
      }
      return _repository.getFeed(type: query.type, offset: query.offset);
    });
  }
}

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
