import 'dart:io';

import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/network/network_concurrency_executor.dart';
import 'package:culcul/shared/network/network_concurrency_profiles.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:culcul/features/dynamic/application/dynamic_workflows.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/features/dynamic/domain/repositories/dynamic_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ArticleDetailCommentWorkflow', () {
    test('submitComment trims input and posts a top-level reply', () async {
      final repository = _FakeDynamicRepository();
      final workflow = ArticleDetailCommentWorkflow(repository);

      final result = await workflow.submitComment(
        article: _buildArticleDetail(),
        commentsEnabled: true,
        rawMessage: '  hello world  ',
      );

      expect(result.submitted, isTrue);
      expect(result.errorMessage, isNull);
      expect(repository.addArticleCommentReplyCalls, 1);
      expect(repository.lastArticleReplyRoot, 0);
      expect(repository.lastArticleReplyParent, 0);
      expect(repository.lastArticleReplyMessage, 'hello world');
    });

    test('submitComment skips repository when comments are disabled', () async {
      final repository = _FakeDynamicRepository();
      final workflow = ArticleDetailCommentWorkflow(repository);

      final result = await workflow.submitComment(
        article: _buildArticleDetail(),
        commentsEnabled: false,
        rawMessage: 'hello world',
      );

      expect(result.submitted, isFalse);
      expect(result.commentsDisabled, isTrue);
      expect(result.errorMessage, isNull);
      expect(repository.addArticleCommentReplyCalls, 0);
    });

    test('submitReply targets the current comment thread', () async {
      final repository = _FakeDynamicRepository();
      final workflow = ArticleDetailCommentWorkflow(repository);

      final result = await workflow.submitReply(
        article: _buildArticleDetail(),
        commentsEnabled: true,
        item: _buildCommentItem(rpid: 20, root: 10),
        message: 'reply body',
      );

      expect(result.submitted, isTrue);
      expect(result.errorMessage, isNull);
      expect(repository.addArticleCommentReplyCalls, 1);
      expect(repository.lastArticleReplyRoot, 10);
      expect(repository.lastArticleReplyParent, 20);
      expect(repository.lastArticleReplyMessage, 'reply body');
    });
  });

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
  int addArticleCommentReplyCalls = 0;
  int inFlight = 0;
  int maxInFlight = 0;
  final List<String> uploadedCsrfValues = <String>[];
  int? lastArticleReplyRoot;
  int? lastArticleReplyParent;
  String? lastArticleReplyMessage;

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

  @override
  Future<Result<CommentItem, AppError>> addArticleCommentReply({
    required ArticleDetailData article,
    required int root,
    required int parent,
    required String message,
  }) async {
    addArticleCommentReplyCalls++;
    lastArticleReplyRoot = root;
    lastArticleReplyParent = parent;
    lastArticleReplyMessage = message;
    return Success(
      _buildCommentItem(rpid: 99, root: root, parent: parent, message: message),
    );
  }
}

ArticleDetailData _buildArticleDetail() {
  return const ArticleDetailData(
    url: 'https://www.bilibili.com/read/cv1',
    commentOid: 'oid-1',
    commentType: 12,
    title: 'Article',
    summary: 'Summary',
    bannerUrl: null,
    authorName: 'Author',
    authorMid: 1,
    authorAvatar: 'https://example.com/avatar.jpg',
    publishTime: 0,
    stats: ArticleStats(
      view: 0,
      favorite: 0,
      like: 0,
      dislike: 0,
      reply: 0,
      share: 0,
      coin: 0,
      dynamicCount: 0,
    ),
    blocks: <ArticleBlock>[],
  );
}

CommentItem _buildCommentItem({
  required int rpid,
  required int root,
  int? parent,
  String message = 'message',
}) {
  return CommentItem(
    rpid: rpid,
    oid: 1,
    type: 12,
    mid: 2,
    root: root,
    parent: parent ?? root,
    ctime: 0,
    member: const CommentMember(
      mid: '2',
      uname: 'user',
      sex: 'unknown',
      sign: '',
      avatar: 'https://example.com/avatar.jpg',
      rank: '10000',
      levelInfo: CommentLevelInfo(
        currentLevel: 1,
        currentMin: 0,
        currentExp: 0,
        nextExp: 1,
      ),
      pendant: CommentPendant(pid: 0, name: '', image: '', expire: 0),
      nameplate: CommentNameplate(
        nid: 0,
        name: '',
        image: '',
        imageSmall: '',
        level: '',
        condition: '',
      ),
      officialVerify: CommentOfficialVerify(),
      vip: CommentVip(),
      fansDetail: null,
    ),
    content: CommentContent(message: message, plat: 0, device: ''),
  );
}
