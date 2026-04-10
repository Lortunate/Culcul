import 'dart:io';

import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/network/network_concurrency_executor.dart';
import 'package:culcul/shared/network/network_concurrency_profiles.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:culcul/features/dynamic/application/dynamic_workflows.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/features/dynamic/domain/repositories/dynamic_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PublishDynamicWorkflow', () {
    test('uploads images with bounded concurrency and reuses csrf', () async {
      final repository = _FakeDynamicRepository(
        uploadDelay: const Duration(milliseconds: 120),
      );
      final workflow = PublishDynamicWorkflow(repository);

      final stopwatch = Stopwatch()..start();
      final result = await workflow.call(
        content: 'hello',
        images: <File>[File('1.png'), File('2.png'), File('3.png')],
      );
      stopwatch.stop();

      expect(result.isSuccess, isTrue);
      expect(repository.csrfCalls, 1);
      expect(repository.uploadBatchCalls, 1);
      expect(repository.uploadCalls, 3);
      expect(repository.publishCalls, 1);
      expect(repository.maxInFlight, lessThanOrEqualTo(3));
      expect(repository.uploadedCsrfValues.toSet(), {'csrf-token'});
      expect(stopwatch.elapsedMilliseconds, lessThan(260));
    });

    test('fails fast when any image upload fails and does not publish', () async {
      final repository = _FakeDynamicRepository(failAtUploadIndex: 1);
      final workflow = PublishDynamicWorkflow(repository);

      final result = await workflow.call(
        content: 'hello',
        images: <File>[File('1.png'), File('2.png'), File('3.png')],
      );

      expect(result.isFailure, isTrue);
      expect(repository.publishCalls, 0);
    });

    test('uses externally injected csrf instead of fetching', () async {
      final repository = _FakeDynamicRepository();
      final workflow = PublishDynamicWorkflow(repository);

      final result = await workflow.call(
        content: 'hello',
        images: <File>[File('1.png')],
        csrf: 'injected-csrf',
      );

      expect(result.isSuccess, isTrue);
      expect(repository.csrfCalls, 0);
      expect(repository.uploadedCsrfValues.toSet(), {'injected-csrf'});
    });
  });
}

class _FakeDynamicRepository extends Fake implements DynamicRepository {
  _FakeDynamicRepository({this.uploadDelay = Duration.zero, this.failAtUploadIndex});

  final Duration uploadDelay;
  final int? failAtUploadIndex;
  final executor = const NetworkConcurrencyExecutor();

  int csrfCalls = 0;
  int uploadBatchCalls = 0;
  int uploadCalls = 0;
  int publishCalls = 0;
  int inFlight = 0;
  int maxInFlight = 0;
  final List<String> uploadedCsrfValues = <String>[];

  @override
  Future<Result<String, AppError>> getPublishCsrf() async {
    csrfCalls++;
    return const Success('csrf-token');
  }

  @override
  Future<Result<List<DynamicUploadImageData>, AppError>> uploadImagesWithCsrf({
    required List<File> files,
    required String csrf,
  }) async {
    uploadBatchCalls++;
    if (files.isEmpty) {
      return const Success(<DynamicUploadImageData>[]);
    }

    try {
      final uploaded = await executor.mapConcurrent<File, DynamicUploadImageData>(
        items: files,
        profile: NetworkConcurrencyProfile.upload,
        scope: 'test_dynamic_upload_batch',
        mapper: (file) async {
          final callIndex = uploadCalls;
          uploadCalls++;
          uploadedCsrfValues.add(csrf);

          inFlight++;
          if (inFlight > maxInFlight) {
            maxInFlight = inFlight;
          }

          if (uploadDelay > Duration.zero) {
            await Future<void>.delayed(uploadDelay);
          }
          inFlight--;

          if (failAtUploadIndex != null && callIndex == failAtUploadIndex) {
            throw AppError.server('upload failed');
          }
          return DynamicUploadImageData(
            imageUrl: 'https://img/$callIndex.jpg',
            width: 100,
            height: 200,
          );
        },
      );
      return Success(uploaded);
    } catch (error) {
      return Failure(error is AppError ? error : AppError.fromObject(error));
    }
  }

  @override
  Future<Result<void, AppError>> publishDynamic({
    required String content,
    required String csrf,
    List<DynamicUploadImageData> images = const [],
  }) async {
    publishCalls++;
    return const Success(null);
  }
}
