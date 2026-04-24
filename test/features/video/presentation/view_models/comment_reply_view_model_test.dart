import 'dart:async';

import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart';
import 'package:culcul/features/video/feature_scope.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/shared/network/request_cancel_token.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/presentation/view_models/comment_reply_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('disposing comment reply controller cancels in-flight reply request', () async {
    final repository = _FakeVideoRepository();
    final container = ProviderContainer(
      overrides: [videoRepositoryProvider.overrideWithValue(repository)],
    );

    container.read(commentReplyControllerProvider(1, 2));
    await Future<void>.delayed(const Duration(milliseconds: 10));

    container.dispose();

    expect(repository.lastCancelToken?.isCancelled, isTrue);
    repository.completePendingFetch();
  });
}

class _FakeVideoRepository extends Fake implements VideoRepository {
  final Completer<Result<CommentResponse, AppError>> _pendingFetchCompleter =
      Completer<Result<CommentResponse, AppError>>();

  RequestCancelToken? lastCancelToken;

  @override
  Future<Result<CommentResponse, AppError>> fetchReply({
    required int oid,
    required int root,
    int page = 1,
    RequestCancelToken? cancelToken,
  }) async {
    lastCancelToken = cancelToken;
    return _pendingFetchCompleter.future;
  }

  void completePendingFetch() {
    if (_pendingFetchCompleter.isCompleted) {
      return;
    }
    _pendingFetchCompleter.complete(
      Success(CommentResponse(replies: <CommentItem>[_comment()])),
    );
  }
}

CommentItem _comment() {
  return CommentItem(
    rpid: 1,
    oid: 1,
    type: 1,
    mid: 1,
    root: 0,
    parent: 0,
    ctime: 0,
    member: const CommentMember(
      mid: '1',
      uname: 'user',
      sex: '',
      sign: '',
      avatar: '',
      rank: '0',
      levelInfo: CommentLevelInfo(
        currentLevel: 0,
        currentMin: 0,
        currentExp: 0,
        nextExp: 0,
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
    ),
    content: const CommentContent(message: 'hello'),
  );
}
